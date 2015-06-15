//
//  NSDictionary+Helper.m
//  Helper
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

- (void)each:(void (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		block(key, obj);
	}];
}

- (void)apply:(void (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	[self enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
		block(key, obj);
	}];
}

- (id)match:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	return self[[[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
		if (block(key, obj)) {
			*stop = YES;
			return YES;
		}

		return NO;
	}] anyObject]];
}

- (NSDictionary *)select:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	NSArray *keys = [[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
		return block(key, obj);
	}] allObjects];

	NSArray *objects = [self objectsForKeys:keys notFoundMarker:[NSNull null]];
	return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (NSDictionary *)reject:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);
	return [self select:^BOOL(id key, id obj) {
		return !block(key, obj);
	}];
}

- (NSDictionary *)map:(id (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];

	[self each:^(id key, id obj) {
		id value = block(key, obj) ?: [NSNull null];
		result[key] = value;
	}];

	return result;
}

- (BOOL)any:(BOOL (^)(id key, id obj))block
{
	return [self match:block] != nil;
}

- (BOOL)none:(BOOL (^)(id key, id obj))block
{
	return [self match:block] == nil;
}

- (BOOL)all:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	__block BOOL result = YES;

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		if (!block(key, obj)) {
			result = NO;
			*stop = YES;
		}
	}];

	return result;
}

@end
