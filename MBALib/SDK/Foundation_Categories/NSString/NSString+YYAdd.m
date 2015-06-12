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


DUMMY_CLASS(NSString_YYAdd)

@implementation NSString (YYAdd)

- (NSString *)md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md2String];
}

- (NSString *)md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md4String];
}

- (NSString *)md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}

- (NSString *)sha1String{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1String];
}

- (NSString *)sha224String{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha224String];
}

- (NSString *)sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha256String];
}

- (NSString *)sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha384String];
}

- (NSString *)sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha512String];
}

- (NSString *)crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] crc32String];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacMD5StringWithKey:key];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA1StringWithKey:key];
}

- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA224StringWithKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA256StringWithKey:key];
}

- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA384StringWithKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA512StringWithKey:key];
}

- (NSString *)base64Encoding {
	return [[self dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
}

+ (NSString *)stringWithBase64Encoding:(NSString *)base64Encoding {
    NSData *data = [NSData dataWithBase64Encoding:base64Encoding];
	return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}



- (NSString *)stringByURLEncode {
    return [self stringByURLEncode:NSUTF8StringEncoding];
}


- (NSString *)stringByURLDecode {
    return [self stringByURLDecode:NSUTF8StringEncoding];
}


- (NSString *)stringByURLEncode:(NSStringEncoding)encoding {
    NSString *encoded = (G_BRIDGE_TRANSFER NSString *)
    CFURLCreateStringByAddingPercentEscapes(
        NULL,
        (G_BRIDGE CFStringRef)self,
        NULL,
        CFSTR("!#$&'()*+,/:;=?@[]"),
        (CFStringEncoding)encoding);
    return encoded;
}



- (NSString *)stringByURLDecode:(NSStringEncoding)encoding {
    CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(encoding);
    NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                        withString:@" "];
    decoded = (G_BRIDGE_TRANSFER NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
            NULL,
            (G_BRIDGE CFStringRef)decoded,
            CFSTR(""),
            en);
    return decoded;
}





- (NSString *)stringByEscapingHTML{
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i=0; i<len; i++,buf++) {
        unichar c = *buf;
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result,&c,1);
        }
    }
    free(buf);
    return result;
}




@end
