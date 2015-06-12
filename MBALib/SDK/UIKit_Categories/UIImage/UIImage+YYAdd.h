//
//  UIImage+YYAdd.h
//  YYKit
//
//  Created by ibireme on 13-4-4.
//  Copyright 2013 ibireme.
//

#import <UIKit/UIKit.h>

#pragma mark - 图片相关
FOUNDATION_EXTERN UIImage* IMAGE_LOAD(NSString* fileName);
FOUNDATION_EXTERN UIImage* IMAGE_NAMED(NSString* fileName);
FOUNDATION_EXTERN UIImage* IMAGE_STRETCHABLE(NSString* fileName, float w, float h);

// Provide some commen method for `UIImage`.
@interface UIImage (YYAdd)

+ (UIImage*)clearImage:(CGSize)size;

+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;

- (UIImage*)addSmallImage:(UIImage*)smallImage origin:(CGPoint)origin;

- (UIImage *)imageScaledToSize:(CGSize)size;

// 图像旋转
- (UIImage *)imageByRotation:(UIImageOrientation)orientation;


/**
 Create and return a new UIColor object from the pixel pointed in this image.
 @param point The point in this image.
    The range of point.x and point.y is [0,image.width-1].
    If the point is out of this image, it will return nil.
 
 @return The UIColor object, or nil when error occured.
 */
- (UIColor *)colorAtPoint:(CGPoint )point;

// Creates an image from the contents of a URL
+ (UIImage*)imageWithContentsOfURL:(NSURL*)url;

// Creates an image with a path compontent relative to the main bundle's resource path
+ (UIImage*)imageWithResourcesPathCompontent:(NSString*)pathCompontent;

@end
