//
//  NSNotificationCenter+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kNotificationCenter                [NSNotificationCenter defaultCenter]

/**
 Provide some method for `NSNotificationCenter`
 to post notification in different thread.
 */
@interface NSNotificationCenter (YYAdd)

- (id)addObserverForName:(NSString *)name usingBlock:(void (^)(NSNotification *note))block;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName;

- (void)postNotificationOnMainThreadWithName:(NSString *)name;

- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object;

- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo;

- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo
                               waitUntilDone:(BOOL)wait;

@end
