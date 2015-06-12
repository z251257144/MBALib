//
//  UIScreen+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAppScreen  [UIScreen mainScreen]

// Provide some some common method for `UIScreen`.
@interface UIScreen (YYAdd)

@property (nonatomic, readonly) float width;
@property (nonatomic, readonly) float height;

/**
 Returns the bounds of the screen for the current device orientation.
 
 @return A rect indicating the bounds of the screen.
 @see boundsForOrientation:
 */
- (CGRect)currentBounds;

/**
 Returns the bounds of the screen for a given device orientation. `UIScreen`'s `bounds` method always returns the bounds
 of the screen of it in the portrait orientation.
 
 @param orientation The orientation to get the screen's bounds.
 @return A rect indicating the bounds of the screen.
 @see currentBounds
 */
- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation;

// Returns a Boolean indicating if the screen is a Retina display.
- (BOOL)isRetina;

@end
