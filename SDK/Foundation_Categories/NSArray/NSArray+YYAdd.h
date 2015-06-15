//
//  NSArray+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+Helper.h"
#import "NSMutableArray+Helper.h"

// Provide some some common method for `NSArray`.
@interface NSArray (YYAdd)

// Checks to see if the array is empty
@property(nonatomic,readonly,getter=isEmpty) BOOL empty;

// Random
@property (nonatomic, readonly) id firstObject;
@property (nonatomic, readonly) id randomObject;

// Utility
@property (nonatomic, readonly) NSArray *reversed;
@property (nonatomic, readonly) NSArray *sorted;
@property (nonatomic, readonly) NSArray *sortedCaseInsensitive;

// Setification
@property (nonatomic, readonly) NSArray *uniqueElements;
- (NSArray *) unionWithArray: (NSArray *) anArray;
- (NSArray *) intersectionWithArray: (NSArray *) anArray;
- (NSArray *) differenceToArray: (NSArray *) anArray;

// Returns the object located at index, or return nil when out of bounds.
- (id)objectOrNilAtIndex:(NSUInteger)index;

@end


// Provide some some common method for `NSMutableArray`.
@interface NSMutableArray (YYAdd)

// Inserts a given object at the end of the array. If the object is nil, it just return and do not throw exception.
- (void)addObjectOrNil:(id)anObject;

// Removes the object with the lowest-valued index in the array. If the array is empty, nothing will happen.
- (void)removeFirstObject;


// Reverse the index of object in this array. Example: Before @[ @1, @2, @3 ] After @[ @3, @2, @1 ]
- (void) reverse;

// Sort the object in this array randomly.
- (void) shuffle;

@end