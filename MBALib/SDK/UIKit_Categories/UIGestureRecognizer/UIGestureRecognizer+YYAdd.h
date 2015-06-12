//
//  UIGestureRecognizer+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYKitMacro.h"

@interface UIGestureRecognizer (ALActionBlocks)

- (instancetype)initWithBlock:(ALActionBlock)actionBlock;

- (void)setBlock:(ALActionBlock)actionBlock;

@end
