//
//  Channel.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "CodeName.h"

@interface Channel : CodeName

@property (nonatomic, retain) NSMutableArray *subArray; //子集渠道数组，没有就为空

+ (Channel*)channelWithCode:(NSString*)theCode name:(NSString*)theName;

@end
