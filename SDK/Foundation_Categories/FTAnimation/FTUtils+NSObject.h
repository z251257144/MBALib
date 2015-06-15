//
//  FTUtils+NSObject.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FTUtilsAdditions)

- (void)performSelector:(SEL)selector andReturnTo:(void *)returnData withArguments:(void **)arguments;
- (void)performSelector:(SEL)selector withArguments:(void **)arguments;
- (void)performSelectorIfExists:(SEL)selector andReturnTo:(void *)returnData withArguments:(void **)arguments;
- (void)performSelectorIfExists:(SEL)selector withArguments:(void **)arguments;

@end

@interface NSArray (FTUtilsAdditions)

/**
 Returns a new `NSArray` with the elements in reverse order.
*/
- (NSArray *)reversedArray;

@end

@interface NSMutableArray (FTUtilsAdditions)

/**
 Reorders the elements of the array in place.
*/
- (void)reverse;

@end
