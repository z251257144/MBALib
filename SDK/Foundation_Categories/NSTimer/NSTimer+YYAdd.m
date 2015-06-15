//
//  NSTimer+Helper.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSTimer+YYAdd.h"

@interface NSTimer (HelperPrivate)

+ (void)executeBlockFromTimer:(NSTimer *)aTimer;

@end

@implementation NSTimer (Helper)

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))block repeats:(BOOL)inRepeats
{
	NSParameterAssert(block != nil);
	return [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeBlockFromTimer:) userInfo:[block copy] repeats:inRepeats];
}

+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))block repeats:(BOOL)inRepeats
{
	NSParameterAssert(block != nil);
	return [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(executeBlockFromTimer:) userInfo:[block copy] repeats:inRepeats];
}

+ (void)executeBlockFromTimer:(NSTimer *)aTimer {
	void (^block)(NSTimer *) = [aTimer userInfo];
	if (block) block(aTimer);
}

//暂停定时器
- (void)pauseTimer
{
    if (self) {
        [self setFireDate:[NSDate distantFuture]];
    }
}

//继续定时器
- (void)continueTimer
{
    if (self) {
        [self setFireDate:[NSDate distantPast]];
    }
}

@end
