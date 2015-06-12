//
//  NSURLHelper.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSURL (Helper)

/*
 * Returns a string of the base of the URL, will contain a trailing slash
 *
 * Example:
 * NSURL is http://www.cnn.com/full/path?query=string&key=value
 * baseString will return: http://www.cnn.com/
 */
- (NSString*)baseString;

@end
