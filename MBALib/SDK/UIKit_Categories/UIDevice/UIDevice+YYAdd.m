//
//  UIDevice+Add.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIDevice+YYAdd.h"

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedAscending)


//*****************************屏幕相关定义
BOOL kOSVersionEqualTo(NSString *version)
{
    return [[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch]==NSOrderedSame;
}
FOUNDATION_EXTERN BOOL kOSVersionGreaterThan(NSString *version)
{
    return ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch]==NSOrderedDescending);
}
FOUNDATION_EXTERN BOOL kOSVersionGreaterThanAndEqualTo(NSString *version)
{
    return ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch]!=NSOrderedAscending);
}
FOUNDATION_EXTERN BOOL kOSVersionLessThan(NSString *version)
{
    return ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch]==NSOrderedAscending);
}
FOUNDATION_EXTERN BOOL kOSVersionLessThanAndEqualTo(NSString *version)
{
    return ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch]!=NSOrderedDescending);
}
//设备小于iOS7
void kOSVersionLess7(void (^block)(void))
{
    if (kOSVersionLessThan(@"7.0")) {
        ((void (^)())block)();
    }
}
//设备大于等于iOS7
void kOSVersionGreaterEuqal7(void (^block)(void))
{
    if (kOSVersionGreaterThanAndEqualTo(@"7.0")) {
        ((void (^)())block)();
    }
}


DUMMY_CLASS(UIDevice_YYAdd)

@implementation UIDevice (YYAdd)


- (BOOL) isRetina{
    static dispatch_once_t one;
	static BOOL retina;
	dispatch_once(&one, ^{
        retina = [[UIScreen mainScreen] scale] >= 2;
	});
	return retina;
}

- (BOOL) isPad{
    static dispatch_once_t one;
	static BOOL pad;
	dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
	});
	return pad;
}

- (BOOL) isSimulator{
    static dispatch_once_t one;
	static BOOL simu;
	dispatch_once(&one, ^{
        simu = NSNotFound != [[self model] rangeOfString:@"Simulator"].location;
	});
	return simu;
}

@end
