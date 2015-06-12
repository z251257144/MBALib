//
//  UIView+EasingFunctions.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

/**
 介绍：
 简单易用的动画操作类库，提供了一种简单的方式对view进行相关的动画显示。主要是对view的frame/alpha/center/transform等属性进行设置。
 
 *********************************
 使用方法：
 [superView addSubview:subview];
 
 subview.center = CGPointMake(0, CGRectGetMidY(superView.bounds));
 subview.transform = CGAffineTransformMakeScale(0.5, 0.5);
 
 // Animate!
 [UIView animateWithDuration:1 animations:^{
 
 [subview setEasingFunction:QuadraticEaseInOut forKeyPath:@"center"];
 [subview setEasingFunction:QuadraticEaseInOut forKeyPath:@"transform"];
 
 subview.center = CGPointMake(CGRectGetMidX(superView.bounds), CGRectGetMidY(superView.bounds));
 subview.transform = CGAffineTransformIdentity;
 
 } completion:^(BOOL finished) {
 
 [subview removeEasingFunctionForKeyPath:@"center"];
 [subview removeEasingFunctionForKeyPath:@"transform"];
 
 }];
 */

#import <UIKit/UIKit.h>
#include "EasingFunctions.h"

typedef CGFloat (*ViewEasingFunctionPointerType)(CGFloat);

@interface UIView (Easing)

/**
 Assigns an easing function to an animatable `UIView` property.
 
 The function remains assigned and in effect until removed using `removeEasingFunctionForKeyPath:`.
 
 @param function Pointer to a function that defines the pacing of an animation by mapping an input time normalized to the range [0,1] to an output time.
 
 @param keyPath The key-path of the property to assign the easing function to.主要是
 
 @see -removeEasingFunctionForKeyPath:
 
 */
- (void)setEasingFunction:(ViewEasingFunctionPointerType)function forKeyPath:(NSString *)keyPath;

/** 
 Disassociates a previously assigned easing function from a `UIView` property.
 
 @param keyPath The key-path of the property to remove a previously assigned easing function from.
 
 @see -setEasingFunction:forKeyPath:

 */
- (void)removeEasingFunctionForKeyPath:(NSString *)keyPath;

@end
