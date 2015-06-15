//
//  UIApplication+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "YYKitMacro.h"

#define kApplication            [UIApplication sharedApplication]

#pragma mark - 文件夹路径
#define kMainBoundPath          [[NSBundle mainBundle] bundlePath]
#define kResourcePath           [[NSBundle mainBundle] resourcePath]
#define kExecutablePath         [[NSBundle mainBundle] executablePath]
#define kBundleFile(file,type)  [[NSBundle mainBundle] pathForResource:file ofType:type]

#define kDocumentsFolder        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
#define kLibraryFolder          [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];

#pragma mark - UIApplication
// Provide some some common method for `UIApplication`.
@interface UIApplication (YYAdd)

// 返回当前程序的版本（CFBundleVersion），examlpe:1.0.12
@property (nonatomic, readonly) NSString *appVersion;

// 当前app版本（CFBundleVersion）和服务端版本进行比较
- (BOOL)appLessNewVersion:(NSString*)newVersion;

// 返回当前程序最上层的window
@property (nonatomic, readonly) UIWindow *lastWindow;


// Return "Documents" folder in this app's sandbox.
@property (nonatomic,strong, readonly) NSURL *documentsURL;

// Return "Caches" folder in this app's sandbox.
@property (nonatomic,strong, readonly) NSURL *cachesURL;

// Return "Library" folder in this app's sandbox.
@property (nonatomic,strong, readonly) NSURL *libraryURL;

/**
 * Sets the status bar style as well as the key window background color
 * UIStatusBarStyleDefault will result in a white background color
 * UIStatusBarStyleBlackTranslucent/Opaque will result in a black background color
 */
- (void)setApplicationStyle:(UIStatusBarStyle)style animated:(BOOL)animated;

// Same as the above, however, you can specify the default/original/starting backgroundColor, instead of white.
- (void)setApplicationStyle:(UIStatusBarStyle)style animated:(BOOL)animated defaultBackgroundColor:(UIColor*)defaultBackgroundColor;

@end
