//
//  NSString+DataDetector.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSString+DataDetector.h"

@implementation NSString (DataDetector)

- (BOOL) isEmail
{
    if (self.length == 0) {
        return NO;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isMobileNumber
{
    if (self.length == 0) {
        return NO;
    }
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
    * 中国移动：China Mobile
    * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
    * 中国联通：China Unicom
    * 130,131,132,152,155,156,185,186
    */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
    * 中国电信：China Telecom
    * 133,1349,153,180,189
    */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
    * 大陆地区固话及小灵通
    * 区号：010,020,021,022,023,024,025,027,028,029
    * 号码：七位或八位
    */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)) {
        return YES;
    }

    return NO;
}

- (BOOL)isValidFormat:(NSString*)formatter
{
    if (self.length == 0) {
        return NO;
    }
    
    if (formatter.length == 0) {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:formatter] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

@end
