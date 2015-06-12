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

+ (instancetype)inputWithTitle:(NSString*)title submission:(void (^)(NSString* text))submission;

+ (instancetype)confirmationWithTitle:(NSString*)title confirmation:(void (^)())confirmation;

- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message
            cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles
                   completion:(void (^)(NSInteger buttonIndex))completion;

- (void)setCompletionBlock:(void (^)(NSInteger buttonIndex))completion;

@end
