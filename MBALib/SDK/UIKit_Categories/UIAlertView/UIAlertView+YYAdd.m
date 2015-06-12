//
//  UIAlertView+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIAlertView+YYAdd.h"

#import <objc/runtime.h>



#pragma mark - Macros

#ifndef L10n
    #define L10n(key) NSLocalizedString(key, nil)
#endif



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
    UIAlertView* alertView = [[[self class] alloc]
                              initWithTitle:title message:message delegate:nil
                              cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    alertView.delegate = alertView;
    [alertView setCompletionBlock:^(NSInteger buttonIndex) {
        completion();
    }];

    return alertView;
}

+ (instancetype)inputWithTitle:(NSString*)title submission:(void (^)(NSString* text))submission
{
    UIAlertView* alertView = [[[self class] alloc]
                              initWithTitle:title message:nil delegate:nil
                              cancelButtonTitle:L10n(@"Cancel") otherButtonTitles:L10n(@"OK"), nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    __weak id weakRef = alertView;
    [alertView setCompletionBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) submission([weakRef textFieldAtIndex:0].text);
    }];

    return alertView;
}

+ (instancetype)confirmationWithTitle:(NSString*)title confirmation:(void (^)())confirmation
{
    UIAlertView* alertView = [[[self class] alloc]
                              initWithTitle:title message:nil delegate:nil
                              cancelButtonTitle:L10n(@"Cancel") otherButtonTitles:L10n(@"OK"), nil];

    [alertView setCompletionBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) confirmation();
    }];

    return alertView;
}

- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message
            cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles
                   completion:(void (^)(NSInteger buttonIndex))completion
{
    self = [super init];
    if (self != nil) {
        self.title = title;
        self.message = message;

        for (NSString* buttonTitle in otherButtonTitles) {
            [self addButtonWithTitle:buttonTitle];
        }
        [self addButtonWithTitle:cancelButtonTitle];
        [self setCancelButtonIndex:([self numberOfButtons] - 1)];

        self.delegate = self;
        [self setCompletionBlock:completion];
    }

    return self;
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
