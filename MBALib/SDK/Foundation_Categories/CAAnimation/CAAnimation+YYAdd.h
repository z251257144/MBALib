//
//  CAAnimation+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 30/04/2013.
//  Copyright (c) 2013 MBALib. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (YYAdd)

- (void)setFinishedBlock:(void (^)(BOOL finished))finishedBlock;

- (void)setStartBlock:(void (^)(void))startBlock;

@end
