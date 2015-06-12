//
//  UIScrollView+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIScrollView+YYAdd.h"
#import "YYKitMacro.h"

DUMMY_CLASS(UIScrollView_YYDebug)

@implementation UIScrollView (YYAdd)

#pragma mark Content Offset

- (CGFloat)contentOffsetX
{
    return self.contentOffset.x;
}

- (CGFloat)contentOffsetY
{
    return self.contentOffset.y;
}

- (void)setContentOffsetX:(CGFloat)newContentOffsetX
{
    self.contentOffset = CGPointMake(newContentOffsetX, self.contentOffsetY);
}

- (void)setContentOffsetY:(CGFloat)newContentOffsetY
{
    self.contentOffset = CGPointMake(self.contentOffsetX, newContentOffsetY);
}


#pragma mark Content Size

- (CGFloat)contentSizeWidth
{
    return self.contentSize.width;
}

- (CGFloat)contentSizeHeight
{
    return self.contentSize.height;
}

- (void)setContentSizeWidth:(CGFloat)newContentSizeWidth
{
    self.contentSize = CGSizeMake(newContentSizeWidth, self.contentSizeHeight);
}

- (void)setContentSizeHeight:(CGFloat)newContentSizeHeight
{
    self.contentSize = CGSizeMake(self.contentSizeWidth, newContentSizeHeight);
}


#pragma mark Content Inset

- (CGFloat)contentInsetTop
{
    return self.contentInset.top;
}

- (CGFloat)contentInsetRight
{
    return self.contentInset.right;
}

- (CGFloat)contentInsetBottom
{
    return self.contentInset.bottom;
}

- (CGFloat)contentInsetLeft
{
    return self.contentInset.left;
}

- (void)setContentInsetTop:(CGFloat)newContentInsetTop
{
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.top = newContentInsetTop;
    self.contentInset = newContentInset;
}

- (void)setContentInsetRight:(CGFloat)newContentInsetRight
{
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.right = newContentInsetRight;
    self.contentInset = newContentInset;
}

- (void)setContentInsetBottom:(CGFloat)newContentInsetBottom
{
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.bottom = newContentInsetBottom;
    self.contentInset = newContentInset;
}

- (void)setContentInsetLeft:(CGFloat)newContentInsetLeft
{
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.left = newContentInsetLeft;
    self.contentInset = newContentInset;
}


- (void)scrollToTop {
    [self scrollToTopAnimated:YES];
}

- (void)scrollToBottom {
    [self scrollToBottomAnimated:YES];
}

- (void)scrollToLeft {
    [self scrollToLeftAnimated:YES];
}

- (void)scrollToRight {
    [self scrollToRightAnimated:YES];
}

- (void)scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width;
    [self setContentOffset:off animated:animated];
}

@end
