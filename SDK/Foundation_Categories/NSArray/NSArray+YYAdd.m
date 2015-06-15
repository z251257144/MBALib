//
//  NSArray+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSArray+YYAdd.h"
#import "YYKitMacro.h"

DUMMY_CLASS(NSArray_YYAdd)

@implementation NSArray (YYAdd)

- (BOOL)isEmpty {
	return [self count] == 0 ? YES : NO;
}

- (id)firstObject
{
    if (self.count)
        return self[0];
    return nil;
}

- (id)randomObject
{
	if (self.count) {
	    return self[arc4random_uniform((u_int32_t)self.count)];
	}
    return nil;
}

- (id)objectOrNilAtIndex:(NSUInteger)index
{
    return index < self.count ? self[index] : nil;
}

#pragma mark - Utility

- (NSArray *) reversed
{
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *) sorted
{
    NSArray *resultArray = [self sortedArrayUsingComparator:
                            ^(id obj1, id obj2){return [obj1 compare:obj2];}];
    return resultArray;
}

- (NSArray *) sortedCaseInsensitive
{
    NSArray *resultArray = [self sortedArrayUsingComparator:
                            ^(id obj1, id obj2){return [obj1 caseInsensitiveCompare:obj2];}];
    return resultArray;
}


#pragma mark - Set theory

- (NSArray *) uniqueElements
{
    return [NSOrderedSet orderedSetWithArray:self].array.copy;
}

- (NSArray *) unionWithArray: (NSArray *) anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    
    [set1 unionOrderedSet:set2];
    
    return set1.array.copy;
}

- (NSArray *) intersectionWithArray: (NSArray *) anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    
    [set1 intersectOrderedSet:set2];
    
    return set1.array.copy;
}

- (NSArray *) differenceToArray: (NSArray *) anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    
    [set1 minusOrderedSet:set2];
    
    return set1.array.copy;
}

@end


/**
 Provide some some common method for `NSMutableArray`.
 */
@implementation NSMutableArray (YYAdd)

- (void)addObjectOrNil:(id)anObject{
    if (anObject) {
        [self addObject:anObject];
    }
}


- (void)removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (void)reverse {
    NSInteger count = self.count;
    int mid = floor(count / 2.0);
    for (int i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}

@end