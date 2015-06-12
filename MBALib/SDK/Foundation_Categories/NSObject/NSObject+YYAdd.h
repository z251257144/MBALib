//
//  NSObject+Add.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+AssociatedHelper.h"
#import "NSObject+ExecutionHelper.h"
#import "NSObject+ObservationHelper.h"
#import "NSObject+LogDealloc.h"

//*****************************线程相关定义
#pragma mark - Block
FOUNDATION_EXTERN void BACK_RUN(void (^block)(void));
FOUNDATION_EXTERN void MAIN_RUN(void (^block)(void));

/**
 @discussion Common tasks for NSObject.
 */
@interface NSObject (YYAdd)

@property(nonatomic,readonly) NSArray* arrayValue;
@property(nonatomic,readonly) NSMutableArray* mutableArrayValue;


/// @name Others
+ (NSString *)className;
- (NSString *)className;
- (NSString *)autoDescribe;

@end

@interface NSObject (BlockTimer)

- (void)logTimeToRunBlock:(void (^)(void)) block withPrefix:(NSString*)prefixString;

@end
