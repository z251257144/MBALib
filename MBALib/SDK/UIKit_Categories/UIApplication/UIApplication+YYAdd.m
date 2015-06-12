//
//  UIApplication+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIApplication+YYAdd.h"
#import "NSArray+YYAdd.h"
#import "YYKitMacro.h"

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

- (void)setApplicationStyle:(UIStatusBarStyle)style animated:(BOOL)animated {
	[self setApplicationStyle:style animated:animated defaultBackgroundColor:[UIColor whiteColor]];
}

- (void)setApplicationStyle:(UIStatusBarStyle)style animated:(BOOL)animated defaultBackgroundColor:(UIColor*)defaultBackgroundColor {
	[self setStatusBarStyle:style animated:animated];
	
	UIColor* newBackgroundColor = style == UIStatusBarStyleDefault ? defaultBackgroundColor : [UIColor blackColor];
	UIColor* oldBackgroundColor = style == UIStatusBarStyleDefault ? [UIColor blackColor] : defaultBackgroundColor;
	
	if(animated) {
	    [CATransaction setValue:[NSNumber numberWithFloat:0.3] forKey:kCATransactionAnimationDuration];
		
		CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
		fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
		fadeAnimation.fromValue = (id)oldBackgroundColor.CGColor;
		fadeAnimation.toValue = (id)newBackgroundColor.CGColor;
		fadeAnimation.fillMode = kCAFillModeForwards;
		fadeAnimation.removedOnCompletion = NO;
		[self.keyWindow.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
		[CATransaction commit];
	} else {
		self.keyWindow.backgroundColor = newBackgroundColor;
	}
}

@end
