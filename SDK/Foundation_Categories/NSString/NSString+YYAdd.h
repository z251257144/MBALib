//
//  NSString+Add.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Helper.h"
#import "NSString+DataDetector.h"

//判断字符串是否为空
FOUNDATION_EXTERN BOOL      IS_NULL_STRING(NSString* string);
//判断字符串不为空
FOUNDATION_EXTERN BOOL      NOT_NULL_STRING(NSString* string);
//如果string为空指针，则将返回@""
FOUNDATION_EXTERN NSString* NIL_STR(NSString *string);

