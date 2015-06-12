//
//  CAAnimation+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 30/04/2013.
//  Copyright (c) 2013 MBALib. All rights reserved.
//

#import "CAAnimation+YYAdd.h"
#import <objc/runtime.h>

static id kCAAnimationFinishedBlockKey;
static id kCAAnimationStartBlockKey;

@implementation CAAnimation (YYAdd)

#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    void (^finishedBlock)(BOOL flag);
    finishedBlock = objc_getAssociatedObject(self, &kCAAnimationFinishedBlockKey);
    if (finishedBlock) {
        finishedBlock(flag);
    }
    
}

- (void)animationDidStart:(CAAnimation *)anim
{
    void (^startBlock)(void);
    startBlock = objc_getAssociatedObject(self, &kCAAnimationStartBlockKey);
    if (startBlock) {
        startBlock();
    }
}

#pragma mark - Interface

- (void)setFinishedBlock:(void (^)(BOOL finished))finishedBlock
{
    if (finishedBlock == nil) return;
    
    self.delegate = self;
    objc_setAssociatedObject(self, &kCAAnimationFinishedBlockKey, finishedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setStartBlock:(void (^)(void))startBlock
{
    if (startBlock == nil) return;
    
    self.delegate = self;
    objc_setAssociatedObject(self, &kCAAnimationStartBlockKey, startBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
