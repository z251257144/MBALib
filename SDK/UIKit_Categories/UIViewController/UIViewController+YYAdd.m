//
//  UIViewController+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIViewController+YYAdd.h"

static BOOL _staticFirstUse = NO;

@implementation UIViewController (YYAdd)

- (BOOL)firstUse
{
    return _staticFirstUse;
}

- (void)setFirstUse:(BOOL)firstUse
{
    _staticFirstUse = firstUse;
}

- (void)adaptIOS7
{
    if (IOS7_OR_LATER) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

#pragma mark Quick frame changes
@dynamic viewFrame;
@dynamic viewBound;
@dynamic viewSize;
@dynamic viewWidth;
@dynamic viewHeight;

#pragma mark -

- (CGRect)viewFrame
{
	CGRect bounds = [UIScreen mainScreen].bounds;
    
	if ( UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
	{
		bounds.origin = CGPointMake( bounds.origin.y, bounds.origin.x );
		bounds.size = CGSizeMake( bounds.size.height, bounds.size.width );
	}
	
    if (IOS7_OR_LATER) {
        if ( ![UIApplication sharedApplication].statusBarHidden )
        {
            bounds.size.height -= [UIApplication sharedApplication].statusBarFrame.size.height;
        }
        
        if ( !self.navigationController.navigationBarHidden )
        {
            bounds.size.height -= self.navigationController.navigationBar.bounds.size.height;
        }
        
        if (self.tabBarController.tabBar) {
            if ( !self.hidesBottomBarWhenPushed )
            {
                bounds.size.height -= self.tabBarController.tabBar.bounds.size.height;
            }
        }
    }
	else {
        if ( ![UIApplication sharedApplication].statusBarHidden )
        {
            bounds.size.height -= [UIApplication sharedApplication].statusBarFrame.size.height;
        }
        
        if ( !self.navigationController.navigationBarHidden )
        {
            bounds.size.height -= self.navigationController.navigationBar.bounds.size.height;
        }
        
        if (self.tabBarController.tabBar) {
            if ( !self.hidesBottomBarWhenPushed )
            {
                bounds.size.height -= self.tabBarController.tabBar.bounds.size.height;
            }
        }
    }
	
	return bounds;
}

- (CGRect)viewBound
{
	CGRect bound = self.viewFrame;
	bound.origin = CGPointZero;
	return bound;
}

- (CGSize)viewSize
{
	return self.viewFrame.size;
}

- (CGFloat)viewWidth
{
	return self.viewFrame.size.width;
}

- (CGFloat)viewHeight
{
	return self.viewFrame.size.height;
}

@end
