//
//  UIDevice+Add.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "YYKitMacro.h"

//*****************************系统相关定义
FOUNDATION_EXTERN BOOL kOSVersionEqualTo(NSString *version);
FOUNDATION_EXTERN BOOL kOSVersionGreaterThan(NSString *version);
FOUNDATION_EXTERN BOOL kOSVersionGreaterThanAndEqualTo(NSString *version);
FOUNDATION_EXTERN BOOL kOSVersionLessThan(NSString *version);
FOUNDATION_EXTERN BOOL kOSVersionLessThanAndEqualTo(NSString *version);
//设备小于iOS7
FOUNDATION_EXTERN void kOSVersionLess7(void (^block)(void));
//设备大于等于iOS7
FOUNDATION_EXTERN void kOSVersionGreaterEuqal7(void (^block)(void));

/**
 Provide some some common method for `UIDevice`.
 */
@interface UIDevice (YYAdd)

/**
 Returns if the device has retina display.
 */
- (BOOL) isRetina;

/**
 Returns if the device is iPad/iPad Mini.
 */
- (BOOL) isPad;

/**
 Returns `YES` if the device is a simulator.
 */
- (BOOL) isSimulator;

@end
