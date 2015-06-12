//
//  YYKitMacro.h
//  MBALib
//
//  Created by zmsoul on 30/04/2013.
//  Copyright (c) 2013 MBALib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "DDLog.h"

typedef void (^ALActionBlock)(id weakSender);

#define USER_DEFAULT                [NSUserDefaults standardUserDefaults]      //UserDefault
#define kDegreesToRadian(x)         (M_PI * (x) / 180.0)    //弧度转角度
#define kRadianToDegrees(radian)    (radian*180.0)/(M_PI)   //角度转弧度

#define kAppKeyWindow               [UIApplication sharedApplication].keyWindow
#define kAppRootController          [UIApplication sharedApplication].keyWindow.rootViewController

//pragma mark - Collections
#pragma mark - Collections
#define ARRAY(...)                  [NSArray arrayWithObjects: __VA_ARGS__, nil]
#define DICT(...)                   [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]

//Log打印
#ifdef DEBUG
    #define GLog(FORMAT, ...)  NSLog( @"<%@:%d>%@ %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithUTF8String:__PRETTY_FUNCTION__], [NSString stringWithFormat:(FORMAT), ##__VA_ARGS__] )
#else
    #define GLog(FORMAT, ...) nil
#endif

#define GLogString(s)          GLog(@"%@", s);
#define GLogFloat(f)           GLog(@"%02f", f);
#define GLogInt(i)             GLog(@"%i", i)
#define GLogBool(flag)         GLog(@"%@", flag?@"YES":@"NO")
#define GLogRect(rect)         GLogString(NSStringFromCGRect(rect))
#define GLogSize(size)         GLogString(NSStringFromCGSize(size))
#define GLogPoint(point)       GLogString(NSStringFromCGPoint(point))
#define GLogSelector           GLogString(NSStringFromSelector(_cmd))


#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

// Use dummy class for category in static library.
#ifndef DUMMY_CLASS
#define DUMMY_CLASS(name) \
    @interface DUMMY_CLASS_ ## name : NSObject @end \
    @implementation DUMMY_CLASS_ ## name @end
#endif

#if __has_feature(objc_arc)
    #define G_BRIDGE __bridge
    #define G_BRIDGE_TRANSFER __bridge_transfer
    #define G_AUTORELEASE(exp) 
    #define G_RELEASE(exp) exp
    #define G_RETAIN(exp) exp
#else
    #define G_BRIDGE
    #define G_BRIDGE_TRANSFER
    #define G_AUTORELEASE(exp) [exp autorelease]
    #define G_RELEASE(exp) [exp release]
    #define G_RETAIN(exp) [exp retain]
#endif


//*****************************变量相关定义
//安全删除变量(SAFE_RELEASE)
#if __has_feature(objc_arc)
    //compiling with ARC
    #define SAFE_RELEASE(mValue) mValue = nil
    #define SUPER_DEALLOC
#else
    // compiling without ARC
    #define SAFE_RELEASE(mValue) [mValue release];mValue=nil
    #define SUPER_DEALLOC       [super dealloc]
#endif

//安全创建MutableArray
#define SAFE_CREATE_MUTABLEARRAY(marValue)\
    SAFE_RELEASE(marValue);\
    marValue = [[NSMutableArray alloc]init];\

//安全创建MutableDictionary
#define SAFE_CREATE_MUTABLEDIC(mdicValue)\
    SAFE_RELEASE(mdicValue);\
    mdicValue = [[NSMutableDictionary alloc] init];\

//安全赋值
#define SAFE_ASSIGN_STRING(strVarible, strValue)\
    SAFE_RELEASE(strVarible);\
    strVarible = [[NSString alloc] initWithFormat:@"%@", strValue];\

//创建或清空可变数组
#define CREATE_CLEAR_MUTABLEARRAY(marValue)\
    if (marValue == nil) {\
        marValue = [[NSMutableArray alloc] init];\
    }\
    else {\
        [marValue removeAllObjects];\
    }\




