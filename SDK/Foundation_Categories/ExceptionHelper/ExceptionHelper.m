//
//  ExceptionHelper.m
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

#import "ExceptionHelper.h"

#ifdef ENABLE_EXCEPTIONS

@implementation ExceptionHelper
+ (void)generateStackTraceForException:(NSException*)exception {
	NSString* processIdentifier = [[NSNumber numberWithInt:[[NSProcessInfo processInfo] processIdentifier]] stringValue];
	NSString* stackAddresses = [[exception callStackReturnAddresses] componentsJoinedByString:@" "];
	NSMutableString* debugInfo = [NSMutableString string];
	[debugInfo appendString:@"\n"];
	[debugInfo appendString:@"================================\n"];
	[debugInfo appendString:@"Exception Caught:\n"];
	[debugInfo appendString:@"--------------------------------\n"];
	[debugInfo appendFormat:@"Name: %@\n", exception.name];
	[debugInfo appendFormat:@"Reason: %@\n", exception.reason];
	if(exception.userInfo) {
		[debugInfo appendFormat:@"Additional Info: %@\n", exception.userInfo];
	} else {
		[debugInfo appendString:@"No additional information available..\n"];
	}
	[debugInfo appendString:@"--------------------------------\n"];
	[debugInfo appendFormat:@"Run the following command in GDB to view a full stack trace:\n\nshell atos -p %@ %@\n\n", processIdentifier, stackAddresses];
	[debugInfo appendString:@"================================\n"];
	NSLog(@"%@", debugInfo);

	while(1) {
		// Keeps the process alive while you run the command.
	}
}
@end

#endif
