//
//  NSObject+BKAssociatedObjects.m
//  Helper
//

#import <objc/runtime.h>
#import "NSObject+AssociatedHelper.h"

#pragma mark - Weak support

@interface _BKWeakAssociatedObject : NSObject

@property (nonatomic, weak) id value;

@end

@implementation _BKWeakAssociatedObject

@end

@implementation NSObject (AssociatedHelper)

#pragma mark - Instance Methods

- (void)associateValue:(id)value withKey:(const void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)atomicallyAssociateValue:(id)value withKey:(const void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)associateCopyOfValue:(id)value withKey:(const void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

- (void)weaklyAssociateValue:(__autoreleasing id)value withKey:(const void *)key
{
	_BKWeakAssociatedObject *assoc = objc_getAssociatedObject(self, key);
	if (!assoc) {
		assoc = [_BKWeakAssociatedObject new];
		[self associateValue:assoc withKey:key];
	}
	assoc.value = value;
}

- (id)associatedValueForKey:(const void *)key
{
	id value = objc_getAssociatedObject(self, key);
	if (value && [value isKindOfClass:[_BKWeakAssociatedObject class]]) {
		return [(_BKWeakAssociatedObject *)value value];
	}
	return value;
}

- (void)removeAllAssociatedObjects
{
	objc_removeAssociatedObjects(self);
}

#pragma mark - Class Methods

+ (void)associateValue:(id)value withKey:(const void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)atomicallyAssociateValue:(id)value withKey:(const void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

+ (void)associateCopyOfValue:(id)value withKey:(const void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

+ (void)weaklyAssociateValue:(__autoreleasing id)value withKey:(const void *)key
{
	_BKWeakAssociatedObject *assoc = objc_getAssociatedObject(self, key);
	if (!assoc) {
		assoc = [_BKWeakAssociatedObject new];
		[self associateValue:assoc withKey:key];
	}
	assoc.value = value;
}

+ (id)associatedValueForKey:(const void *)key
{
	id value = objc_getAssociatedObject(self, key);
	if (value && [value isKindOfClass:[_BKWeakAssociatedObject class]]) {
		return [(_BKWeakAssociatedObject *)value value];
	}
	return value;
}

+ (void)removeAllAssociatedObjects
{
	objc_removeAssociatedObjects(self);
}

@end
