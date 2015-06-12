//
//  UIColor+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <UIKit/UIKit.h>




#define UIColorRGB(r, g, b)     [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1]
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)]

@interface UIColor (YYAdd)

+ (UIColor *)colorWithHexString:(NSString *)hexStr;


@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;


+ (UIColor *)groupColor;

+ (UIColor *)randomColor;

/*!
 *  @brief Initialize color from 32bit color component
 *  @param red、green、blue
 *      Value from 0 to 255
 *  @param alpha
 *      Value from 0 to 1.0f
 */
+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue alpha:(float)alpha;

+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue;

@end
