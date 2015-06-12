//
//  NSNotificationCenter+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSNotificationCenter+YYAdd.h"
#include <pthread.h>
#import "YYKitMacro.h"

//DUMMY_CLASS(NSNotificationCenter_YYAdd)

@implementation NSNotificationCenter (YYAdd)

- (id)addObserverForName:(NSString *)name usingBlock:(void (^)(NSNotification *note))block
{
#if NS_BLOCKS_AVAILABLE
    return [self addObserverForName:name object:nil queue:nil usingBlock:block];
#endif
    return nil;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName
{
    [self addObserver:observer selector:aSelector name:aName object:nil];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name
{
    [self postNotificationName:name object:nil];
}

- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object {
	if( pthread_main_np() ) return [self postNotificationName:name object:object userInfo:nil];
	[self postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo {
	if( pthread_main_np() ) return [self postNotificationName:name object:object userInfo:userInfo];
	[self postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo waitUntilDone:(BOOL) wait {
	if( pthread_main_np() ) return [self postNotificationName:name object:object userInfo:userInfo];
    
	NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
	if( name ) [info setObject:name forKey:@"name"];
	if( object ) [info setObject:object forKey:@"object"];
	if( userInfo ) [info setObject:userInfo forKey:@"userInfo"];
    
	[[self class] performSelectorOnMainThread:@selector( _postNotificationName: ) withObject:info waitUntilDone:wait];
    
}

+ (void) _postNotificationName:(NSDictionary *) info {
	NSString *name = [info objectForKey:@"name"];
	id object = [info objectForKey:@"object"];
	NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    
	[[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}
@end
