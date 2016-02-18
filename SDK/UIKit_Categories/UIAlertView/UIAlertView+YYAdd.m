//
//  UIAlertView+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIAlertView+YYAdd.h"

#pragma mark -

@implementation UIAlertView (BBExtensions)

static id kUIAlertView_BBExtensionsCompletionBlockKey;

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^completion)(NSInteger buttonIndex);
    completion = objc_getAssociatedObject(self, &kUIAlertView_BBExtensionsCompletionBlockKey);
    if (completion != nil) completion(buttonIndex);
}


#pragma mark Class interface

+ (instancetype)noticeWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle
                     completion:(void (^)())completion
{
    UIAlertView* alertView = [[UIAlertView alloc]
                              initWithTitle:title message:message delegate:nil
                              cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    alertView.delegate = alertView;
    [alertView setCompletionBlock:^(NSInteger buttonIndex) {
        completion();
    }];

    return alertView;
}


- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    return [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
}


#pragma mark Interface

- (void)setCompletionBlock:(void (^)(NSInteger buttonIndex))completion
{
    if (completion == nil) return;

    self.delegate = self;
    objc_setAssociatedObject(self, &kUIAlertView_BBExtensionsCompletionBlockKey,
                             completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
