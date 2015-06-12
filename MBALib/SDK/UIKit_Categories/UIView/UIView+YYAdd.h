//
//  UIView+Add.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ActionHandlers.h"

// Provide some some common method for `UIView`.
@interface UIView (YYAdd)


/**
 Create a snapshot image from this view (and subviews).
 
 @return A snapshot image with view.size.
 */
- (UIImage *)snapshotImage;

/**
 Create a snapshot image and add 1 px transparency edge (for antialiasing).
 
 @see snapshotImage
 @return A snapshot image.
 */
- (UIImage *)snapshotImageAntialiasing;


// Remove all subviews.
- (void)removeAllSubviews;


// Return the view's ViewController.
@property (nonatomic, strong, readonly) UIViewController *viewController;

// Frame
@property (nonatomic) CGPoint cg_origin;
@property (nonatomic) CGSize cg_size;

// Frame Origin
@property (nonatomic) CGFloat cg_x;
@property (nonatomic) CGFloat cg_y;

// Frame Size
@property (nonatomic) CGFloat cg_width;
@property (nonatomic) CGFloat cg_height;

// Frame Borders
@property (nonatomic) CGFloat cg_top;
@property (nonatomic) CGFloat cg_left;
@property (nonatomic) CGFloat cg_bottom;
@property (nonatomic) CGFloat cg_right;

// Center Point
@property (nonatomic) CGFloat cg_centerX;
@property (nonatomic) CGFloat cg_centerY;

// Middle Point
@property (nonatomic, readonly) CGPoint cg_middlePoint;
@property (nonatomic, readonly) CGFloat cg_middleX;
@property (nonatomic, readonly) CGFloat cg_middleY;


#pragma mark - Shadows
- (void)addShadow;
- (void)addShadowWithOffsetSize:(CGSize)offset color:(UIColor *)color opacity:(float)opacity radius:(float)radius;
- (void)addBorderWithWidth:(float)width color:(UIColor *)color;
- (void)setCornerRadius:(float)radius;

//为视图添加边框
- (void)addViewBorder;

@end
