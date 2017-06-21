//
//  NSString+Add.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSString+YYAdd.h"
#import "NSData+YYAdd.h"
#import "NSNumber+YYAdd.h"
#import "YYKitMacro.h"


//*****************************字符串相关
#pragma mark - 字符串相关
//判断字符串是否为空
BOOL IS_NULL_STRING(NSString* string)
{
    return (string == nil || string == (NSString *)[NSNull null] || ![string isKindOfClass:[NSString class]] || ![string length]);
}

//判断字符串不为空
BOOL NOT_NULL_STRING(NSString* string)
{
    return ([string isKindOfClass:[NSString class]] || [string length]);
}

//如果string为空指针，则将返回@""
NSString* NIL_STR(NSString *string)
{
    return string?string:@"";
}

