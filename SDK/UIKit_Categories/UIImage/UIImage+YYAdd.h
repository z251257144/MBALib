//
//  UIImage+YYAdd.h
//  YYKit
//
//  Created by ibireme on 13-4-4.
//  Copyright 2013 ibireme.
//

#import "YYKitMacro.h"

#pragma mark - 图片相关
FOUNDATION_EXTERN UIImage* IMAGE_LOAD(NSString* fileName);
FOUNDATION_EXTERN UIImage* IMAGE_NAMED(NSString* fileName);
FOUNDATION_EXTERN UIImage* IMAGE_STRETCHABLE(NSString* fileName, float w, float h);

// Provide some commen method for `UIImage`.
@interface UIImage (YYAdd)

/**
 *  创建一个指定大小的透明图像
 *
 *  @param size 空白图像大小
 *
 *  @return 返回一个空白图像
 */
+ (UIImage*)imageWithClearColor:(CGSize)size;


/**
 *  创建一个指定颜色、指定大小的纯色图像
 *
 *  @param color 图像颜色
 *  @param size  图像大小
 *
 *  @return 返回创建的图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;


/**
 *  从APP资源目录创建一个指定图片名称的图像
 *
 *  @param pathCompontent 图片名称
 *
 *  @return 返回创建的图片
 */
+ (UIImage*)imageWithResourcesPathCompontent:(NSString*)pathCompontent;


/**
 *  在图像中添加小图片，使之合成新的图片
 *
 *  @param smallImage 被添加的小图片
 *  @param origin     图片的位置
 *
 *  @return 返回一个新的图片
 */
- (UIImage*)addSmallImage:(UIImage*)smallImage origin:(CGPoint)origin;

/**
 *  缩放图片
 *
 *  @param size 缩放后的大小
 *
 *  @return 返回缩放后的图片
 */
- (UIImage *)imageScaledToSize:(CGSize)size;

// 图像旋转
- (UIImage *)imageByRotation:(UIImageOrientation)orientation;


@end
