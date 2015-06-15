//
//  ExceptionHelper.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//

#ifdef ENABLE_EXCEPTIONS
#import <Foundation/Foundation.h>

@interface ExceptionHelper : NSObject {

}

// This will output a command to console to run in atos to get a full stacktrace
// It will also display any available information with the exception
+ (void)generateStackTraceForException:(NSException*)exception;

@end
#endif