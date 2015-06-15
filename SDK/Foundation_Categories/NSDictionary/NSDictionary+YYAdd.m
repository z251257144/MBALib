//
//  NSDictionary+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSDictionary+YYAdd.h"
#import "YYKitMacro.h"

DUMMY_CLASS(NSDictionary_YYAdd)

@implementation NSDictionary (YYAdd)

- (BOOL)isEmpty {
	return [self count] == 0 ? YES : NO;
}

- (NSArray *)allKeysSorted {
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)allValuesSortedByKeys {
    NSArray *sortedKeys = [self allKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return arr;
}

- (CGPoint)pointForKey:(NSString *)key
{
    CGPoint point = CGPointZero;
    NSDictionary *dictionary = [self valueForKey:key];
    BOOL success = CGPointMakeWithDictionaryRepresentation((G_BRIDGE CFDictionaryRef)dictionary, &point);
    if (success) return point;
    else return CGPointZero;
}

- (CGSize)sizeForKey:(NSString *)key
{
    CGSize size = CGSizeZero;
    NSDictionary *dictionary = [self valueForKey:key];
    BOOL success = CGSizeMakeWithDictionaryRepresentation((G_BRIDGE CFDictionaryRef)dictionary, &size);
    if (success) return size;
    else return CGSizeZero;
}

- (CGRect)rectForKey:(NSString *)key
{
    CGRect rect = CGRectZero;
    NSDictionary *dictionary = [self valueForKey:key];
    BOOL success = CGRectMakeWithDictionaryRepresentation((G_BRIDGE CFDictionaryRef)dictionary, &rect);
    if (success) return rect;
    else return CGRectZero;
}

- (void)setPoint:(CGPoint)value forKey:(NSString *)key {
    NSDictionary *dictionary = (G_BRIDGE NSDictionary *)CGPointCreateDictionaryRepresentation(value);
    [self setValue:dictionary forKey:key];
    dictionary = nil;
}

- (void)setSize:(CGSize)value forKey:(NSString *)key {
    NSDictionary *dictionary = (G_BRIDGE NSDictionary *)CGSizeCreateDictionaryRepresentation(value);
    [self setValue:dictionary forKey:key];
    dictionary = nil;
}

- (void)setRect:(CGRect)value forKey:(NSString *)key {
    NSDictionary *dictionary = (G_BRIDGE NSDictionary *)CGRectCreateDictionaryRepresentation(value);
    [self setValue:dictionary forKey:key];
    dictionary = nil;
}

@end


@implementation NSDictionary (NetParam)

- (NSString*)httpParamsString
{
    NSEnumerator *keys = [self keyEnumerator];
    NSString *field = [keys nextObject];
    if (!field) {
        return nil;
    }
    
    NSString *paramString = [NSString stringWithFormat:@"%@=%@", field, [self objectForKey:field]];
    while (field = [keys nextObject]) {
        paramString = [paramString stringByAppendingFormat:@"&%@=%@", field, [self objectForKey:field]];
    }
    return paramString;
}

- (BOOL)containKey:(NSString*)key
{
    id valueObject = [self valueForKey:key];
    return valueObject!=nil;
}

- (NSString*)stringForKey:(NSString*)key
{
    id valueObject = [self valueForKey:key];
    NSString *value = nil;
    if ([valueObject isKindOfClass:[NSString class]]) {
        value = (NSString*)valueObject;
    }
    else if ([valueObject isKindOfClass:[NSNumber class]]) {
        value = [valueObject stringValue];
    }
    return value;
}

- (int)intForKey:(NSString*)key
{
    id valueObject = [self valueForKey:key];
    int value = -1;
    if ([valueObject isKindOfClass:[NSString class]] ||
        [valueObject isKindOfClass:[NSNumber class]]) {
        value = [valueObject intValue];
    }
    return value;
}

- (float)floatForKey:(NSString*)key
{
    id valueObject = [self valueForKey:key];
    float value = -1.0f;
    if ([valueObject isKindOfClass:[NSString class]] ||
        [valueObject isKindOfClass:[NSNumber class]]) {
        value = [valueObject floatValue];
    }
    return value;
}

//异常情况，返回NO
- (BOOL)boolForKey:(NSString*)key
{
    id valueObject = [self valueForKey:key];
    BOOL value = NO;
    if ([valueObject isKindOfClass:[NSString class]] ||
        [valueObject isKindOfClass:[NSNumber class]]) {
        value = [valueObject boolValue];
    }
    return value;
}

@end

@implementation NSMutableDictionary (NetParam)

//如果value如空，将空字符串传进去
- (void)setString:(NSString*)value forKey:(NSString*)key
{
    if (value) {
        [self setValue:value forKey:key];
    }
    else {
        [self setValue:@"" forKey:key];
    }
}

- (void)setInt:(int)value forKey:(NSString*)key
{
    NSString *valueString = [NSString stringWithFormat:@"%d", value];
    [self setValue:valueString forKey:key];
}

@end
