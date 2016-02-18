//
//  NSDate+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATE_FORMAT_DT_HHmmss           @"yyyyMMddHHmmss"
#define DATE_FORMAT_DT_HHmm             @"yyyyMMddHHmm"
#define DATE_FORMAT_DT                  @"yyyy-MM-dd HH:mm:ss"

#define DATE_FORMAT_yyyyMMdd            @"yyyyMMdd"
#define DATE_FORMAT_yyyy_MM_dd          @"yyyy-MM-dd"
#define DATE_FORMAT_yyyyMM              @"yyyyMM"
#define DATE_FORMAT_yyyy_MM             @"yyyy-MM"

@interface NSDate(String)

- (void)sleepUntilDate;

// Convenience methods for date comparisons. Easier to read than -[NSDate compare:]
- (BOOL)isEarlierThanDate:(NSDate *)otherDate;
- (BOOL)isEarlierThanOrEqualToDate:(NSDate *)otherDate;
- (BOOL)isLaterThanDate:(NSDate *)otherDate;
- (BOOL)isLaterThanOrEqualToDate:(NSDate *)otherDate;

+ (NSString*)currentTime;

/*
 *@desc:    根据指定格式获取日期字符串
 *@parm:    formatString:专程目标格式(如:yyyy-mm-dd, yyyymmdd)
 *@return:  返回转换后的字符串
 */
- (NSString*)getStringWithFormat:(NSString*)formatString;

//获取以前的日期(N年、月、日前)
- (NSDate*)getPriousDateWithYear:(int)year month:(int)month day:(int)day;

- (NSDate*)getPriousDateWithYear:(int)year;

- (NSDate*)getPriousDateWithMonth:(int)month;

- (NSDate*)getPriousDateWithDay:(int)day;

@end


@interface NSString(Date)

/*
 *@desc:    根据指定格式获取日期
 *@parm:    formatString:专程目标格式(如:yyyy-mm-dd, yyyymmdd)
 *@return:  返回转换后的日期
 */
- (NSDate*)getDateWithFormat:(NSString*)formatString;

@end

