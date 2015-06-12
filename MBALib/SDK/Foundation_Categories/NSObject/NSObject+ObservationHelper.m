//
//  NSObject+BKBlockObservation.m
//  Helper
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "NSArray+Helper.h"
#import "NSDictionary+Helper.h"
#import "NSObject+ExecutionHelper.h"
#import "NSObject+ObservationHelper.h"
#import "NSObject+AssociatedHelper.h"
#import "NSSet+Helper.h"

typedef NS_ENUM(int, BKObserverContext) {
	BKObserverContextKey,
	BKObserverContextKeyWithChange,
	BKObserverContextManyKeys,
	BKObserverContextManyKeysWithChange
};

@interface _BKObserver : NSObject {
	BOOL _isObserving;
}

@property (nonatomic, readonly, unsafe_unretained) id observee;
@property (nonatomic, readonly) NSMutableArray *keyPaths;
@property (nonatomic, readonly) id task;
@property (nonatomic, readonly) BKObserverContext context;

- (id)initWithObservee:(id)observee keyPaths:(NSArray *)keyPaths context:(BKObserverContext)context task:(id)task;

@end

static void *BKObserverBlocksKey = &BKObserverBlocksKey;
static void *BKBlockObservationContext = &BKBlockObservationContext;

@implementation _BKObserver

- (id)initWithObservee:(id)observee keyPaths:(NSArray *)keyPaths context:(BKObserverContext)context task:(id)task
{
	if ((self = [super init])) {
		_observee = observee;
		_keyPaths = [keyPaths mutableCopy];
		_context = context;
		_task = [task copy];
	}
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context != BKBlockObservationContext) return;

	@synchronized(self) {
		switch (self.context) {
			case BKObserverContextKey: {
				void (^task)(id) = self.task;
				task(object);
				break;
			}
			case BKObserverContextKeyWithChange: {
				void (^task)(id, NSDictionary *) = self.task;
				task(object, change);
				break;
			}
			case BKObserverContextManyKeys: {
				void (^task)(id, NSString *) = self.task;
				task(object, keyPath);
				break;
			}
			case BKObserverContextManyKeysWithChange: {
				void (^task)(id, NSString *, NSDictionary *) = self.task;
				task(object, keyPath, change);
				break;
			}
		}
	}
}

- (void)startObservingWithOptions:(NSKeyValueObservingOptions)options
{
	@synchronized(self) {
		if (_isObserving) return;

		[self.keyPaths each:^(NSString *keyPath) {
			[self.observee addObserver:self forKeyPath:keyPath options:options context:BKBlockObservationContext];
		}];

		_isObserving = YES;
	}
}

- (void)stopObservingKeyPath:(NSString *)keyPath
{
	NSParameterAssert(keyPath);

	@synchronized (self) {
		if (!_isObserving) return;
		if (![self.keyPaths containsObject:keyPath]) return;

		NSObject *observee = self.observee;
		if (!observee) return;

		[self.keyPaths removeObject: keyPath];
		keyPath = [keyPath copy];

		if (!self.keyPaths.count) {
			_task = nil;
			_observee = nil;
			_keyPaths = nil;
		}

		[observee removeObserver:self forKeyPath:keyPath context:BKBlockObservationContext];
	}
}

- (void)_stopObservingLocked
{
	if (!_isObserving) return;

	_task = nil;

	NSObject *observee = self.observee;
	NSArray *keyPaths = [self.keyPaths copy];

	_observee = nil;
	_keyPaths = nil;

	[keyPaths each:^(NSString *keyPath) {
		[observee removeObserver:self forKeyPath:keyPath context:BKBlockObservationContext];
	}];
}

- (void)stopObserving
{
	if (_observee == nil) return;

	@synchronized (self) {
		[self _stopObservingLocked];
	}
}

- (void)dealloc
{
	if (self.keyPaths) {
		[self _stopObservingLocked];
	}
}

@end

@implementation NSObject (ObservationHelper)

- (NSString *)addObserverForKeyPath:(NSString *)keyPath task:(void (^)(id target))task
{
	NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
	[self addObserverForKeyPaths:@[ keyPath ] identifier:token options:0 context:BKObserverContextKey task:task];
	return token;
}

- (NSString *)addObserverForKeyPaths:(NSArray *)keyPaths task:(void (^)(id obj, NSDictionary *keyPath))task
{
	NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
	[self addObserverForKeyPaths:keyPaths identifier:token options:0 context:BKObserverContextManyKeys task:task];
	return token;
}

- (NSString *)addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task
{
	NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
	[self addObserverForKeyPath:keyPath identifier:token options:options task:task];
	return token;
}

- (NSString *)addObserverForKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task
{
	NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
	[self addObserverForKeyPaths:keyPaths identifier:token options:options task:task];
	return token;
}

- (void)addObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)identifier options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task
{
	BKObserverContext context = (options == 0) ? BKObserverContextKey : BKObserverContextKeyWithChange;
	[self addObserverForKeyPaths:@[keyPath] identifier:identifier options:options context:context task:task];
}

- (void)addObserverForKeyPaths:(NSArray *)keyPaths identifier:(NSString *)identifier options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task
{
	BKObserverContext context = (options == 0) ? BKObserverContextManyKeys : BKObserverContextManyKeysWithChange;
	[self addObserverForKeyPaths:keyPaths identifier:identifier options:options context:context task:task];
}

- (void)removeObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token
{
	NSParameterAssert(keyPath.length);
	NSParameterAssert(token.length);

	NSMutableDictionary *dict;

	@synchronized (self) {
		dict = [self observerBlocks];
		if (!dict) return;
	}

	_BKObserver *observer = dict[token];
	[observer stopObservingKeyPath:keyPath];

	if (observer.keyPaths.count == 0) {
		[dict removeObjectForKey:token];
	}

	if (dict.count == 0) [self setObserverBlocks:nil];
}

- (void)removeObserversWithIdentifier:(NSString *)token
{
	NSParameterAssert(token);

	NSMutableDictionary *dict;

	@synchronized (self) {
		dict = [self observerBlocks];
		if (!dict) return;
	}

	_BKObserver *observer = dict[token];
	[observer stopObserving];

	[dict removeObjectForKey:token];

	if (dict.count == 0) [self setObserverBlocks:nil];
}

- (void)removeAllBlockObservers
{
	NSDictionary *dict;

	@synchronized (self) {
		dict = [[self observerBlocks] copy];
		[self setObserverBlocks:nil];
	}

	[dict.allValues each:^(_BKObserver *trampoline) {
		[trampoline stopObserving];
	}];
}

#pragma mark - "Private"s

+ (NSMutableSet *)observedClassesHash
{
	static dispatch_once_t onceToken;
	static NSMutableSet *swizzledClasses = nil;
	dispatch_once(&onceToken, ^{
		swizzledClasses = [[NSMutableSet alloc] init];
	});

	return swizzledClasses;
}

- (void)addObserverForKeyPaths:(NSArray *)keyPaths identifier:(NSString *)identifier options:(NSKeyValueObservingOptions)options context:(BKObserverContext)context task:(id)task
{
	NSParameterAssert(keyPaths.count);
	NSParameterAssert(identifier.length);
	NSParameterAssert(task);

    Class classToSwizzle = self.class;
    NSMutableSet *classes = self.class.observedClassesHash;
    @synchronized (classes) {
        NSString *className = NSStringFromClass(classToSwizzle);
        if (![classes containsObject:className]) {
            SEL deallocSelector = sel_registerName("dealloc");
            
			__block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
            
			id newDealloc = ^(__unsafe_unretained id objSelf) {
                [objSelf removeAllBlockObservers];
                
                if (originalDealloc == NULL) {
                    struct objc_super superInfo = {
                        .receiver = objSelf,
                        .super_class = class_getSuperclass(classToSwizzle)
                    };
                    
                    void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                    msgSend(&superInfo, deallocSelector);
                } else {
                    originalDealloc(objSelf, deallocSelector);
                }
            };
            
            IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
            
            if (!class_addMethod(classToSwizzle, deallocSelector, newDeallocIMP, "v@:")) {
                // The class already contains a method implementation.
                Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);
                
                // We need to store original implementation before setting new implementation
                // in case method is called at the time of setting.
                originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
                
                // We need to store original implementation again, in case it just changed.
                originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
            }
            
            [classes addObject:className];
        }
    }

	NSMutableDictionary *dict;
	_BKObserver *observer = [[_BKObserver alloc] initWithObservee:self keyPaths:keyPaths context:context task:task];
	[observer startObservingWithOptions:options];

	@synchronized (self) {
		dict = [self observerBlocks];

		if (dict == nil) {
			dict = [NSMutableDictionary dictionary];
			[self setObserverBlocks:dict];
		}
	}

	dict[identifier] = observer;
}

- (void)setObserverBlocks:(NSMutableDictionary *)dict
{
	[self associateValue:dict withKey:BKObserverBlocksKey];
}

- (NSMutableDictionary *)observerBlocks
{
	return [self associatedValueForKey:BKObserverBlocksKey];
}

@end
