//
//  UIView+Add.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIView+YYAdd.h"
#import <QuartzCore/QuartzCore.h>
#import "YYKitMacro.h"


DUMMY_CLASS(UIView_YYAdd)

@implementation UIView (YYAdd)

@dynamic cg_origin;
@dynamic cg_size;

// Frame Origin
@dynamic cg_x;
@dynamic cg_y;

// Frame Size
@dynamic cg_width;
@dynamic cg_height;

// Frame Borders
@dynamic cg_top;
@dynamic cg_left;
@dynamic cg_bottom;
@dynamic cg_right;

// Center Point
@dynamic cg_centerX;
@dynamic cg_centerY;

@dynamic cg_middlePoint;
@dynamic cg_middleX;
@dynamic cg_middleY;

- (UIImage *)snapshotImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)snapshotImageAntialiasing {
    return [self.class renderImageForAntialiasing:[self snapshotImage]
                                       withInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
}

+ (UIImage *)renderImageForAntialiasing:(UIImage *)image
                             withInsets:(UIEdgeInsets)insets {
    CGSize imageSizeWithBorder = CGSizeMake([image size].width + insets.left
                                            + insets.right, [image size].height
                                            + insets.top + insets.bottom);
    
    UIGraphicsBeginImageContextWithOptions(imageSizeWithBorder,
                                           UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero), 0);
    
    [image drawInRect:(CGRect) {{ insets.left, insets.top }, [image size] }];
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return renderedImage;
}


- (void)removeAllSubviews{
    while (self.subviews.count) {
        UIView* subView = self.subviews.lastObject;
        [subView removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    for (UIView *view = [self superview]; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - Frame

- (CGPoint)cg_origin
{
    return self.frame.origin;
}

- (void)setCg_origin:(CGPoint)newOrigin
{
    CGRect newFrame = self.frame;
    newFrame.origin = newOrigin;
    self.frame = newFrame;
}

- (CGSize)cg_size
{
    return self.frame.size;
}

- (void)setCg_size:(CGSize)newSize
{
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    self.frame = newFrame;
}


#pragma mark - Frame Origin

- (CGFloat)cg_x
{
    return self.frame.origin.x;
}

- (void)setCg_x:(CGFloat)newX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newX;
    self.frame = newFrame;
}

- (CGFloat)cg_y
{
    return self.frame.origin.y;
}

- (void)setCg_y:(CGFloat)newY
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newY;
    self.frame = newFrame;
}


#pragma mark - Frame Size

- (CGFloat)cg_height
{
    return self.frame.size.height;
}

- (void)setCg_height:(CGFloat)newHeight
{
    CGRect newFrame = self.frame;
    newFrame.size.height = newHeight;
    self.frame = newFrame;
}

- (CGFloat)cg_width
{
    return self.frame.size.width;
}

- (void)setCg_width:(CGFloat)newWidth
{
    CGRect newFrame = self.frame;
    newFrame.size.width = newWidth;
    self.frame = newFrame;
}


#pragma mark - Frame Borders

- (CGFloat)cg_left
{
    return self.cg_x;
}

- (void)setCg_left:(CGFloat)left
{
    self.cg_x = left;
}

- (CGFloat)cg_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setCg_right:(CGFloat)right
{
    self.cg_x = right - self.cg_width;
}

- (CGFloat)cg_top
{
    return self.cg_y;
}

- (void)setCg_top:(CGFloat)top
{
    self.cg_y = top;
}

- (CGFloat)cg_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setCg_bottom:(CGFloat)bottom
{
    self.cg_y = bottom - self.cg_height;
}


#pragma mark - Center Point

- (CGFloat)cg_centerX
{
    return self.center.x;
}

- (void)setCg_centerX:(CGFloat)newCenterX
{
    self.center = CGPointMake(newCenterX, self.center.y);
}

- (CGFloat)cg_centerY
{
    return self.center.y;
}

- (void)setCg_centerY:(CGFloat)newCenterY
{
    self.center = CGPointMake(self.center.x, newCenterY);
}


#pragma mark - Middle Point

- (CGPoint)cg_middlePoint
{
    return CGPointMake(self.cg_middleX, self.cg_middleY);
}

- (CGFloat)cg_middleX
{
    return self.cg_width / 2;
}

- (CGFloat)cg_middleY
{
    return self.cg_height / 2;
}

#pragma mark - Shadow Border Corner
- (void)addShadow {
    [self addShadowWithOffsetSize:CGSizeMake(1.0, 1.0) color:[UIColor blackColor] opacity:0.5 radius:0.0];
}

- (void)addShadowWithOffsetSize:(CGSize)offset color:(UIColor *)color opacity:(float)opacity radius:(float)radius {
    self.layer.shadowColor = color ? color.CGColor : [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = opacity ? opacity : 0.5;
    self.layer.shadowOffset = offset.height ? offset : CGSizeMake(1.0, 1.0);
    self.layer.shadowRadius = radius ? radius : 0;
    self.layer.masksToBounds = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    self.layer.shadowPath = path.CGPath;
}

- (void)addBorderWithWidth:(float)width color:(UIColor *)color {
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width ? width : 1.0;
    self.layer.borderColor = color ? color.CGColor : [UIColor blackColor].CGColor;
}

- (void)setCornerRadius:(float)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius ? radius : 0.0;
}

- (void)addViewBorder
{
    static NSMutableArray *borderColors = nil;
    if (borderColors==nil) {
        borderColors = [[NSMutableArray alloc] initWithCapacity:5];
        [borderColors addObject:[UIColor redColor]];
        [borderColors addObject:[UIColor greenColor]];
        [borderColors addObject:[UIColor blueColor]];
        [borderColors addObject:[UIColor blackColor]];
        [borderColors addObject:[UIColor orangeColor]];
        [borderColors addObject:[UIColor purpleColor]];
    }
    
    int i = arc4random()%[borderColors count];
    self.layer.borderWidth = 1;
    self.layer.borderColor = ((UIColor*)[borderColors objectAtIndex:i]).CGColor;
}

@end
