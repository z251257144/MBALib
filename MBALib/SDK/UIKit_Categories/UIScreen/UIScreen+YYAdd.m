//
//  UIScreen+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIScreen+YYAdd.h"

DUMMY_CLASS(UIScreen_YYDebug)

@implementation UIScreen (YYAdd)

- (float)width
{
    return [UIScreen mainScreen].bounds.size.width;
}

- (float)height
{
    return [UIScreen mainScreen].bounds.size.height;
}

- (CGRect)currentBounds {
	return [self boundsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}


- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation {
	CGRect bounds = [self bounds];
    
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		CGFloat buffer = bounds.size.width;
		bounds.size.width = bounds.size.height;
		bounds.size.height = buffer;
	}
	return bounds;
}

// should not predicate
- (BOOL)isRetina {
    return self.scale == 2;
}


@end
