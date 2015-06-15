//
//  NSStringHelper.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>

int const GGCharacterIsNotADigit = 10;

@implementation NSString (Helper)

- (BOOL)isNotEmpty {
    return [self length] > 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isEmptyOrWhitespace {
    return !self.length ||
    ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}


- (BOOL)containsString:(NSString *)string {
	return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options {
	return [self rangeOfString:string options:options].location != NSNotFound;
}

+ (NSString *)stringWithUUID {
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, uuid);
	CFRelease(uuid);
	return (G_BRIDGE_TRANSFER NSString *)string;
}

- (BOOL)isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)removeWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// even in the middle, like strange whitespace due &nbsp;
- (NSString *)removeAllWhitespaces {
    return [[self componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];
}

- (NSString *)stringByRemovingPrefix:(NSString *)prefix;
{
    NSRange aRange = [self rangeOfString:prefix options:NSAnchoredSearch];
    if ((aRange.length == 0) || (aRange.location != 0))
        return [NSString stringWithString:self];
    return [self substringFromIndex:aRange.length];
}

- (NSString *)stringByRemovingSuffix:(NSString *)suffix;
{
    if (![self hasSuffix:suffix])
        return [NSString stringWithString:self];
    return [self substringToIndex:[self length] - [suffix length]];
}

- (NSString *)stringByRemovingString:(NSString *)removeString
{
    if (![self containsString:removeString])
        return [NSString stringWithString:self];
    
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:[self length]];
    NSArray *lines = [self componentsSeparatedByString:removeString];
    NSUInteger lineIndex, lineCount = [lines count];
    
    for (lineIndex = 0; lineIndex < lineCount; lineIndex++) {
        [newString appendString:[lines objectAtIndex:lineIndex]];
    }
    
    return [NSString stringWithString:newString];
}


@end
