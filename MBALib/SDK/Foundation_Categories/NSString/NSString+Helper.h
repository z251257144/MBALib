//
//  NSStringHelper.h
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

enum {
	NSTruncateStringPositionStart=0,
	NSTruncateStringPositionMiddle,
	NSTruncateStringPositionEnd
}; typedef int NSTruncateStringPosition;

@interface NSString (Helper)

- (BOOL)isNotEmpty;

// Determines if the string contains only whitespace and newlines.
- (BOOL)isWhitespaceAndNewlines;

// Determines if the string is empty or contains only whitespace.
- (BOOL)isEmptyOrWhitespace;

// Checks to see if the string contains the given string, case insenstive
- (BOOL)containsString:(NSString *)string;

// Checks to see if the string contains the given string while allowing you to define the compare options
- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options;

// Return a new UUID NSString; e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
+ (NSString *)stringWithUUID;

// nil, @"", @"  ", @"\n" will return NO, others will return YES.
- (BOOL) isNotBlank;

//去掉两端的空格
- (NSString *)removeWhitespace;

//去掉所有的空格
- (NSString *)removeAllWhitespaces;

- (NSString *)stringByRemovingPrefix:(NSString *)prefix;
- (NSString *)stringByRemovingSuffix:(NSString *)suffix;
- (NSString *)stringByRemovingString:(NSString *)removeString;

@end


@interface NSString (Truncation)

- (NSString*)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font;

@end
