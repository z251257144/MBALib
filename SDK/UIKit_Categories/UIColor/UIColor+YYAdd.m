//
//  UIColor+YYAdd.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "UIColor+YYAdd.h"
#import "NSString+YYAdd.h"

DUMMY_CLASS(UIColor_YYDebug)

#define CLAMP_COLOR_VALUE(v) (v) = (v) < 0 ? 0 : (v) > 1 ? 1 : (v)

@implementation UIColor (YYAdd)

+ (UIColor *)colorWithHexString:(NSString *)hexStr
{
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return nil;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString length] != 6)
        return nil;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (CGFloat)red {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color))
        != kCGColorSpaceModelRGB) {
		return 0;
	}
	return CGColorGetComponents(color)[0];
}

- (CGFloat)green {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color))
        != kCGColorSpaceModelRGB) {
		return 0;
	}
	return CGColorGetComponents(color)[1];
}

- (CGFloat)blue {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color))
        != kCGColorSpaceModelRGB) {
		return 0;
	}
	return CGColorGetComponents(color)[2];
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}


+ (UIColor*)groupColor
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"GColor.bundle/group_color"]];
}

+ (UIColor *)randomColor
{
	return [UIColor colorWithRed:random() / (CGFloat)RAND_MAX
						   green:random() / (CGFloat)RAND_MAX
							blue:random() / (CGFloat)RAND_MAX
						   alpha:1.0f];
}

+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue alpha:(float)alpha
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
}

@end
