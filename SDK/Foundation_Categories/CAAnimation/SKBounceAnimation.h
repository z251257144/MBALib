//
//  SKBounceAnimation.h
//  MBALib
//
//  Created by zmsoul on 30/04/2013.
//  Copyright (c) 2013 MBALib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 介绍：
 一种简单易用的动画操作类库...
 
 *********************************
 使用方法：
 NSString *keyPath = @"position.y";
 id finalValue = [NSNumber numberWithFloat:300];
 [view.layer setValue:finalValue forKeyPath:keyPath];
 
 SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
 bounceAnimation.fromValue = [NSNumber numberWithFloat:view.center.x];
 bounceAnimation.toValue = finalValue;
 bounceAnimation.duration = 0.5f;
 bounceAnimation.numberOfBounces = 2;
 
 [view.layer addAnimation:bounceAnimation forKey:@"someKey"];
 */



typedef CGFloat SKBounceAnimationStiffness;

extern SKBounceAnimationStiffness SKBounceAnimationStiffnessLight;
extern SKBounceAnimationStiffness SKBounceAnimationStiffnessMedium;
extern SKBounceAnimationStiffness SKBounceAnimationStiffnessHeavy;

@interface SKBounceAnimation : CAKeyframeAnimation

@property (nonatomic, retain) id fromValue;
@property (nonatomic, retain) id byValue;
@property (nonatomic, retain) id toValue;
@property (nonatomic, assign) NSUInteger numberOfBounces;
@property (nonatomic, assign) BOOL shouldOvershoot; //default YES
@property (nonatomic, assign) BOOL shake; //if shaking, set fromValue to the furthest value, and toValue to the current value
@property (nonatomic, assign) SKBounceAnimationStiffness stiffness;

+ (SKBounceAnimation*) animationWithKeyPath:(NSString*)keyPath;


@end
