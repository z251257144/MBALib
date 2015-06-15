//
//  NSString+DataDetector.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kStringDotNumbers       @"0123456789."
#define kStringNumbers          @"0123456789"

@interface NSString (DataDetector)

- (BOOL)isEmail;
- (BOOL)isMobileNumber;

- (BOOL)isValidFormat:(NSString*)formatter;

@end
