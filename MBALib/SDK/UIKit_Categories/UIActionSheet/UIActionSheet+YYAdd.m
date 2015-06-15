//
//  UIActionSheet+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIActionSheet+YYAdd.h"

@implementation UIActionSheet (BBExtensions)

static id kUIActionSheet_BBExtensionsCompletionBlockKey;

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^completion)(NSInteger buttonIndex);
    completion = objc_getAssociatedObject(self, &kUIActionSheet_BBExtensionsCompletionBlockKey);
    completion(buttonIndex);
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    return [self initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
}

#pragma mark Interface

- (void)setCompletionBlock:(void (^)(NSInteger buttonIndex))completion
{
    if (completion == nil) return;

    self.delegate = self;
    objc_setAssociatedObject(self, &kUIActionSheet_BBExtensionsCompletionBlockKey,
                             completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
