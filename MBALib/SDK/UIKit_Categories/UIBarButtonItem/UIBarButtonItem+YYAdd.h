//
//  UIBarButtonItem+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ALActionBlocks)

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem block:(ALActionBlock)actionBlock;
- (instancetype)initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style block:(ALActionBlock)actionBlock;
- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style block:(ALActionBlock)actionBlock;
- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style block:(ALActionBlock)actionBlock;

- (void)setBlock:(ALActionBlock)actionBlock;


+ (UIBarButtonItem*)fixedSizeSpacerWithWidth:(CGFloat)width;
+ (UIBarButtonItem*)flexibleSpacer;

@end
