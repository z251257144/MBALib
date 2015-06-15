//
//  NSNumber+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSNumber+YYAdd.h"
#import "NSString+YYAdd.h"
#import "YYKitMacro.h"

DUMMY_CLASS(NSNumber_YYAdd)

@implementation NSNumber (YYAdd)

+ (NSNumber *)numberWithString:(NSString *)string {
    NSString *str = [[string removeWhitespace] lowercaseString];
    if (!str || !str.length) {
        return nil;
    }
    int sign = 0;
    if ([str hasPrefix:@"0x"])
        sign = 1;
    else if ([str hasPrefix:@"-0x"])
        sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}

@end
