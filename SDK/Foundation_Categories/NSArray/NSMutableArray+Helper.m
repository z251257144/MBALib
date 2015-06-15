//
//  NSMutableArray+Helper.m
//  Helper
//

#import "NSMutableArray+Helper.h"

@implementation NSMutableArray (Helper)

- (void)performSelect:(BOOL (^)(id obj))block {
	NSParameterAssert(block != nil);

	NSIndexSet *list = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return !block(obj);
	}];

	if (!list.count) return;
	[self removeObjectsAtIndexes:list];
}

- (void)performReject:(BOOL (^)(id obj))block {
	NSParameterAssert(block != nil);
	return [self performSelect:^BOOL(id obj) {
		return !block(obj);
	}];
}

- (void)performMap:(id (^)(id obj))block {
	NSParameterAssert(block != nil);

	NSMutableArray *new = [self mutableCopy];

	[self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		id value = block(obj) ?: [NSNull null];
		if ([value isEqual:obj]) return;
		new[idx] = value;
	}];

	[self setArray:new];
}

@end
