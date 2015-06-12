//
//  Channel.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "Channel.h"

@implementation Channel

@synthesize subArray = _subArray;

- (id)init
{
    if (self = [super init]) {
        self.subArray = [NSMutableArray array];
    }
    return self;
}

+ (Channel*)channelWithCode:(NSString*)theCode name:(NSString*)theName
{
    Channel *channel = [[Channel alloc] init];
    [channel setCode:theCode name:theName];
    return channel;
}
@end
