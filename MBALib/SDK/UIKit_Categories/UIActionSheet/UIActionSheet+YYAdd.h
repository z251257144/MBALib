//
//  UIActionSheet+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "YYKitMacro.h"

@interface UIActionSheet (BBExtensions) <UIActionSheetDelegate>

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark Interface

- (void)setCompletionBlock:(void (^)(NSInteger buttonIndex))completion;

@end
