//
//  UIDevice+Add.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <UIKit/UIKit.h>

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

#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS7_OR_LESS		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending )
#define IOS6_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )

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

/**
 Returns `YES` when this device is jailbroken.
 */
- (BOOL) isJailbreake;

//设备是否是iPhone5
+ (BOOL)isIPhone5;

- (BOOL)isOS4;
- (BOOL)isOS5;
- (BOOL)isOS6;
- (BOOL)isOS7;


/**
 Return the MAC address of this device.
 e.g. AA:BB:CC:DD:EE:FF
 */
@property (nonatomic,strong, readonly) NSString *macAddress;

/**
 Return the current IP address of this device.
 e.g. 192.168.1.1
 */
@property (nonatomic,strong, readonly) NSString *ipAddress;

/**
 Return avaliable device memory in Byte.
 Return -1 when error occured.
 */
@property (nonatomic, readonly) int64_t availableMemory;


@end
