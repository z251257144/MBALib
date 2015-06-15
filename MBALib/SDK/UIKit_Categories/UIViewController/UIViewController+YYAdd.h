//
//  UIViewController+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "YYKitMacro.h"

@interface UIViewController (YYAdd)

@property (nonatomic, assign) BOOL firstUse;

@property (nonatomic, readonly) CGRect		viewFrame;
@property (nonatomic, readonly) CGRect		viewBound;
@property (nonatomic, readonly) CGSize		viewSize;
@property (nonatomic, readonly) CGFloat		viewWidth;
@property (nonatomic, readonly) CGFloat		viewHeight;

- (void)adaptIOS7;

@end
