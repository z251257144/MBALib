//
//  MBProgressHUD+YYAdd.m
//  MBALib
//
//  Created by zhoumin on 15/6/15.
//  Copyright (c) 2015年 zhoumin. All rights reserved.
//

#import "MBProgressHUD+YYAdd.h"
#import "UIView+ActionHandlers.h"

static char kNeedHiddenWhenTapedKey;

@implementation MBProgressHUD (YYAdd)

- (BOOL)needHiddenWhenTaped
{
    NSNumber *flag = objc_getAssociatedObject(self, &kNeedHiddenWhenTapedKey);
    if (!flag) {
        return NO;
    }
    return [flag boolValue];
}

- (void)setNeedHiddenWhenTaped:(BOOL)needHiddenWhenTaped
{
    UITapGestureRecognizer *tap = self.tapGestureRecognizer;
    __weak MBProgressHUD *weakSelf = self;
    if (!tap) {
        [self setTapActionWithBlock:^{
            if (weakSelf.needHiddenWhenTaped) {
                [weakSelf hide:YES];
                [weakSelf removeFromSuperview];
            };
        }];
    }
    tap.enabled = needHiddenWhenTaped;
    objc_setAssociatedObject(self, &kNeedHiddenWhenTapedKey, [NSNumber numberWithBool:needHiddenWhenTaped], OBJC_ASSOCIATION_ASSIGN);
}



+ (MBProgressHUD*)progressViewWithTitile:(NSString*)title InView:(UIView*)inView
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
    [inView addSubview:hud];
    if (title.length) {
        hud.labelText = title;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    return hud;
}

+ (MBProgressHUD*)showProgressViewWithTitile:(NSString*)title InView:(UIView*)inView
{
    MBProgressHUD *hud = [MBProgressHUD progressViewWithTitile:title InView:inView];
    [hud show:YES];
    return hud;
}

+ (void)showNetWorkErroWarningInView:(UIView*)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = @"您当前的网络异常";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning_network.png"]];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.needHiddenWhenTaped = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:10];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title delay:(NSTimeInterval)delay
{
    [MBProgressHUD showPromptViewTappedHideInView:view Title:title delay:delay center:CGPointZero];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay
{
    [MBProgressHUD showPromptViewTappedHideInView:view Title:title detail:detail delay:delay center:CGPointZero];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title delay:(NSTimeInterval)delay center:(CGPoint)point
{
    [MBProgressHUD showPromptViewTappedHideInView:view Title:title detail:nil delay:delay center:CGPointZero];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view Title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay center:(CGPoint)point {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    if (title) {
        hud.labelText = title;
    }
    if (detail) {
        hud.detailsLabelText = detail;
    }
    if (!CGPointEqualToPoint(point, CGPointZero)) {
        hud.center = point;
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.needHiddenWhenTaped = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

+ (void)showPromptViewInWindow:(UIImage*)image message:(NSString*)message
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    if (windows.count==0) {
        NSLog(@"屏幕没有初始化");
        return;
    }
    UIWindow *window = [windows lastObject];
    [MBProgressHUD showPromptViewTappedHideInView:window image:image title:message detail:nil delay:2];
}

+ (void)showPromptViewTappedHideInView:(UIView*) view  image:(UIImage*)image title:(NSString*)title detail:(NSString*)detail delay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.customView = imageView;
    
    hud.labelText = title;
    hud.labelFont = [UIFont boldSystemFontOfSize:15.0f];
    
    hud.detailsLabelText = detail;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:13.0f];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.needHiddenWhenTaped = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

+ (void)showMessag:(NSString *)message
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:1.5f];
}


@end
