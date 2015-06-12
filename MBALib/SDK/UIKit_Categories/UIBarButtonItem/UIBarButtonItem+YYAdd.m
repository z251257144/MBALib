//
//  UIBarButtonItem+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIBarButtonItem+YYAdd.h"
#import "ALActionBlockWrapper.h"
#import <objc/runtime.h>


@implementation UIBarButtonItem (ALActionBlocks)


- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem block:(ALActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithBarButtonSystemItem:systemItem target:nil action:nil];
    [barButtonItem setBlock:actionBlock];
    return barButtonItem;
}


- (instancetype)initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style block:(ALActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:nil action:nil];
    [barButtonItem setBlock:actionBlock];
    return barButtonItem;
}


- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style block:(ALActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithImage:image style:style target:nil action:nil];
    [barButtonItem setBlock:actionBlock];
    return barButtonItem;
}


- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style block:(ALActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithTitle:title style:style target:nil action:nil];
    [barButtonItem setBlock:actionBlock];
    return barButtonItem;
}


- (void)setBlock:(ALActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self actionBlocksArray];
    
    ALActionBlockWrapper *blockActionWrapper = [[ALActionBlockWrapper alloc] init];
    blockActionWrapper.actionBlock = actionBlock;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self setTarget:blockActionWrapper];
    [self setAction:@selector(invokeBlock:)];
}


- (NSMutableArray *)actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, &ALActionBlocksArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, &ALActionBlocksArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}

+ (UIBarButtonItem*)fixedSizeSpacerWithWidth:(CGFloat)width
{
    UIBarButtonItem* spacer = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                               target:nil action:nil];
    spacer.width = width;
    G_AUTORELEASE(spacer);
    return spacer;
}

+ (UIBarButtonItem*)flexibleSpacer
{
    UIBarButtonItem* spacer = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                               target:nil action:nil];
    G_AUTORELEASE(spacer);
    return spacer;
}

@end
