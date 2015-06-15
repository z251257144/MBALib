//
//  NSDate+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSDate+YYAdd.h"
#import "YYKitMacro.h"

DUMMY_CLASS(NSDate_YYAdd)


@implementation NSDate(String)

- (void)sleepUntilDate;
{
    NSTimeInterval timeIntervalSinceNow;
    
    timeIntervalSinceNow = [self timeIntervalSinceNow];
    if (timeIntervalSinceNow < 0)
        return;
    [NSThread sleepUntilDate:self];
}

#pragma mark Convenience methods

- (BOOL)isEarlierThanDate:(NSDate *)otherDate
{
    return [self compare:otherDate] == NSOrderedAscending;
}

- (BOOL)isEarlierThanOrEqualToDate:(NSDate *)otherDate
{
    return [self compare:otherDate] != NSOrderedDescending;
}

- (BOOL)isLaterThanDate:(NSDate *)otherDate
{
    return [self compare:otherDate] == NSOrderedDescending;
}

- (BOOL)isLaterThanOrEqualToDate:(NSDate *)otherDate
{
    return [self compare:otherDate] != NSOrderedAscending;
}


//获取当前时间
+(NSString*)currentTime
{
    NSDate *now = [NSDate date];
    return [now getStringWithFormat:DATE_FORMAT_DT];
}

/*
 *@desc:    根据指定格式获取日期字符串
 *@parm:    formatString:专程目标格式(如:yyyy-mm-dd, yyyymmdd)
 *@return:  返回转换后的字符串
 */
- (NSString*)getStringWithFormat:(NSString*)formatString
{
    if (self==nil) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:formatString];
    
    NSString *dateString = [formatter stringFromDate:self];
    G_AUTORELEASE(formatter);
    return dateString;
}


//获取以前的日期(N年、月、日前)
- (NSDate*)getPriousDateWithYear:(int)year month:(int)month day:(int)day
{
    if (self == nil) {
        return nil;
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:self options:0];
    G_AUTORELEASE(comps);
    G_AUTORELEASE(calender);
    return mDate;
}

- (NSDate*)getPriousDateWithYear:(int)year
{
    return [self getPriousDateWithYear:year month:0 day:0];
}

- (NSDate*)getPriousDateWithMonth:(int)month
{
    return [self getPriousDateWithYear:0 month:month day:0];
}

- (NSDate*)getPriousDateWithDay:(int)day
{
    return [self getPriousDateWithYear:0 month:0 day:day];
}

@end


@implementation NSString(Date)

/*
 *@desc:    根据指定格式获取日期
 *@parm:    formatString:专程目标格式(如:yyyy-mm-dd, yyyymmdd)
 *@return:  返回转换后的日期
 */
- (NSDate*)getDateWithFormat:(NSString*)formatString
{
    if (self.length==0) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:formatString];
    
    NSDate *date = [formatter dateFromString:self];
    G_AUTORELEASE(formatter);
    return date;
}

@end
