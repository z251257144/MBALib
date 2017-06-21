//
//  UIApplication+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIApplication+YYAdd.h"
#import "NSString+YYAdd.h"

DUMMY_CLASS(UIApplication_YYDebug)

NSString *NSDocumentsFolder() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES) firstObject];
}

NSString *NSLibraryFolder() {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                        NSUserDomainMask, YES) firstObject];
}

NSString *NSBundleFolder() {
    return [[NSBundle mainBundle] bundlePath];
}

@implementation UIApplication (YYAdd)

- (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (BOOL)appLessNewVersion:(NSString*)newVersion
{
    if (IS_NULL_STRING(newVersion)) {
        return NO;
    }
    return [self.appVersion compare:newVersion] == NSOrderedAscending;
}

- (UIWindow *)lastWindow
{
	NSArray *windows = [[UIApplication sharedApplication] windows];
    if ([windows count]) {
        return [windows lastObject];
    }
    return nil;
}


- (NSURL *)documentsURL {
	return [[[NSFileManager defaultManager]
             URLsForDirectory:NSDocumentDirectory
             inDomains:NSUserDomainMask] lastObject];
}


- (NSURL *)cachesURL {
	return [[[NSFileManager defaultManager]
             URLsForDirectory:NSCachesDirectory
             inDomains:NSUserDomainMask] lastObject];
}


- (NSURL *)libraryURL {
	return [[[NSFileManager defaultManager]
             URLsForDirectory:NSLibraryDirectory
             inDomains:NSUserDomainMask] lastObject];
}

- (BOOL)_fileExistMainBundle:(NSString *)name {
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *path = [NSString stringWithFormat:@"%@/%@", bundlePath, name];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

@end
