//
//  UIDevice+Add.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIDevice+YYAdd.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <mach/mach.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#import "YYKitMacro.h"

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
@dynamic macAddress;
@dynamic ipAddress;
@dynamic availableMemory;

- (BOOL) isRetina{
    static dispatch_once_t one;
	static BOOL retina;
	dispatch_once(&one, ^{
        retina = [[UIScreen mainScreen] scale] == 2;
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

- (BOOL)isOS4 {
	return [self.systemVersion hasPrefix:@"4."];
}

- (BOOL)isOS5 {
	return [self.systemVersion hasPrefix:@"5."];
}

- (BOOL)isOS6 {
	return [self.systemVersion hasPrefix:@"6."];
}

- (BOOL)isOS7 {
	return [self.systemVersion hasPrefix:@"7."];
}


// should not predicate
- (BOOL)isJailbreake {
    NSString *cydiaPath = @"/Applications/Cydia.app";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return YES;
    }

    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }

    FILE *bash = fopen("/bin/bash", "r");
    if (bash != NULL) {
        fclose(bash);
        return YES;
    }

    return NO;
}

+ (BOOL)isIPhone5
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
}


// copy from rr core
// should not predicate
- (NSString *)macAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;

    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;

    if ((mib[5] = if_nametoindex("en0")) == 0) return nil;
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) return nil;
    if ((buf = malloc(len)) == NULL) return nil;
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        return nil;
    }

    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString
                           stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3),
                           *(ptr + 4), *(ptr + 5)];
    free(buf);
    return outstring;
}



// http://blog.zachwaugh.com/post/309927273/programmatically-retrieving-ip-address-of-iphone
- (NSString *)ipAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;

    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:
                               inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }

            temp_addr = temp_addr->ifa_next;
        }
    }

    // Free memory
    freeifaddrs(interfaces);

    return address;
}


/*
 * Available device memory in Byte
 */
- (int64_t)availableMemory {
	vm_statistics_data_t vmStats;
	mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
	kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
	
	if(kernReturn != KERN_SUCCESS) {
		return -1;
	}
	return (vm_page_size * vmStats.free_count);
}

@end
