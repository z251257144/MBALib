//
//  MBProgressHUD+YYAdd.h
//  MBALib
//
//  Created by zhoumin on 15/6/15.
//  Copyright (c) 2015年 zhoumin. All rights reserved.
//

#import "YYKitMacro.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define HUD_WARN                @"MBProgressHUD.bundle/images/mb_warn"
#define HUD_ERROR               @"MBProgressHUD.bundle/images/mb_error"
#define HUD_SUCCESS             @"MBProgressHUD.bundle/images/mb_success"
#define NETWORK_WARN            @"MBProgressHUD.bundle/images/network_warning"

@interface MBProgressHUD (YYAdd)

/**
 * When the view is tapped,view will hidden and remove from superview,default is NO;
 */

@property (assign) BOOL needHiddenWhenTaped;

+ (MBProgressHUD*)progressViewWithTitile:(NSString*)title InView:(UIView*)inView;

+ (MBProgressHUD*)showProgressViewWithTitile:(NSString*)title InView:(UIView*)inView;

+ (void)showNetWorkErroWarningInView:(UIView*)view;

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title delay:(NSTimeInterval)delay;

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay;

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title delay:(NSTimeInterval)delay center:(CGPoint)point;

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay center:(CGPoint)point;

+ (void)showPromptViewInWindow:(UIImage*)image message:(NSString*)message;

+ (void)showPromptViewTappedHideInView:(UIView*) view  image:(UIImage*)image title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay;

+ (void)showMessag:(NSString *)message;

@end
