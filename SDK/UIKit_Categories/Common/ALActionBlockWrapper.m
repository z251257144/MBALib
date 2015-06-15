//
//  ALActionBlockWrapper.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "ALActionBlockWrapper.h"


@implementation ALActionBlockWrapper


- (void)invokeBlock:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}


@end
