//
//  NSData+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Provide hash and encode method for `NSData`.
 */
@interface NSData (YYAdd)


///=============================================================================
/// @name Hash
///=============================================================================




/**
 Return a lowercase NSString for md5 hash.
 */
- (NSString *)md5String;

/**
 Return an NSData for md5 hash.
 */
- (NSData *)md5Data;




///=============================================================================
/// @name Encode and decode
///=============================================================================


/**
 Return a uppercase NSString for HEX.
 */
- (NSString *)hexString;

/**
 Return an NSData from hex string.
 @param hexString The hex string which is case insensitive.
 @return a new NSData, or nil when error occured.
 */
+ (NSData *)dataWithHexString:(NSString *)hexString;

/**
 Return an NSString for base64 encoded.
 
 @warning This method has been implemented in iOS7.
 */
- (NSString *)base64Encoding;

/**
 Return an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64Encoding The encoded string.
 */
+ (NSData *)dataWithBase64Encoding:(NSString *)base64Encoding;


@end
