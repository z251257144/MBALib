//
//  NSDictionary+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDictionary+Helper.h"
#import "NSMutableDictionary+Helper.h"

/**
 Provide some some common method for `NSDictionary`.
 */
@interface NSDictionary (YYAdd)

@property(nonatomic,readonly,getter=isEmpty) BOOL empty;

- (NSArray *)allKeysSorted;
- (NSArray *)allValuesSortedByKeys;


- (CGPoint)pointForKey:(NSString *)key;
- (CGSize)sizeForKey:(NSString *)key;
- (CGRect)rectForKey:(NSString *)key;

- (void)setPoint:(CGPoint)value forKey:(NSString *)key;
- (void)setSize:(CGSize)value forKey:(NSString *)key;
- (void)setRect:(CGRect)value forKey:(NSString *)key;

@end

@interface NSDictionary (NetParam)

//将字典转换为get请求的参数string，例如：xxx=ppp&xxx1=pp1
- (NSString*)httpParamsString;

- (BOOL)containKey:(NSString*)key;

- (NSString*)stringForKey:(NSString*)key;
//异常情况，返回-1
- (int)intForKey:(NSString*)key;
//异常情况，返回-1.0f
- (float)floatForKey:(NSString*)key;
//异常情况，返回NO
- (BOOL)boolForKey:(NSString*)key;

@end


@interface NSMutableDictionary (NetParam)

//如果value如空，将空字符串传进去
- (void)setString:(NSString*)value forKey:(NSString*)key;
- (void)setInt:(int)value forKey:(NSString*)key;

@end