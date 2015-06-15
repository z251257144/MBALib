//
//  UIAlertView+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#pragma mark -

@interface UIAlertView (BBExtensions) <UIAlertViewDelegate>

+ (instancetype)noticeWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle
                     completion:(void (^)())completion;

- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle :(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)setCompletionBlock:(void (^)(NSInteger buttonIndex))completion;

@end
