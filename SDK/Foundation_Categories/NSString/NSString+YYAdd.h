//
//  NSString+Add.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Helper.h"
#import "NSString+DataDetector.h"

//判断字符串是否为空
FOUNDATION_EXTERN BOOL      IS_NULL_STRING(NSString* string);
//判断字符串不为空
FOUNDATION_EXTERN BOOL      NOT_NULL_STRING(NSString* string);
//如果string为空指针，则将返回@""
FOUNDATION_EXTERN NSString* NIL_STR(NSString *string);

/**
 Provide hash, encode and some some common method for 'NSString'.
 */
@interface NSString (YYAdd)


///=============================================================================
/// @name Hash
///=============================================================================

/**
 Return a lowercase NSString for md5 hash.
 */
- (NSString *)md5String;


///=============================================================================
/// @name Encode and decode
///=============================================================================


/**
 Return an NSString for base64 encoded.
 */
- (NSString *)base64Encoding;

/**
 Return an NSString from base64 encoded string.
 
 @param base64Encoding The encoded string.
 */
+ (NSString *)stringWithBase64Encoding:(NSString *)base64Encoding;



/**
 URL encode a string in utf-8.
 
 @return the encoded string.
 */
- (NSString *)stringByURLEncode;


/**
 URL decode a string in utf-8.
 
 @return the decoded string.
 */
- (NSString *)stringByURLDecode;


/**
 URL encode a string.
 
 @param encoding The encoding to use.
 
 @return URL encoded string
 */
- (NSString *)stringByURLEncode:(NSStringEncoding)encoding;


/**
 URL encode a string.
 
 @param encoding The encoding to use.
 
 @return URL encoded string
 */
- (NSString *)stringByURLDecode:(NSStringEncoding)encoding;



/**
 Escape commmon HTML to Entity.
 
 Example: "a<b" will be escape to "a&lt;b".
 */
- (NSString *)stringByEscapingHTML;



///=============================================================================
/// @name Utilities
///=============================================================================




@end
