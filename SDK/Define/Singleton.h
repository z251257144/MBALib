//
//  Singleton.h
//  MBALib
//
//  Created by zmsoul on 30/04/2013.
//  Copyright (c) 2013 MBALib. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#define SINGLETON_FOR_HEADER(classname) \
+ (classname *)sharedInstance;

#define SINGLETON_FOR_CLASS(classname) \
 \
    static classname *sharedInstance = nil; \
    static dispatch_once_t onceToken; \
 \
+ (classname *)sharedInstance \
{ \
	@synchronized(self) \
	{ \
        dispatch_once(&onceToken, ^{ \
            sharedInstance = [[classname alloc] init]; \
        }); \
	} \
	 \
	return sharedInstance; \
} \
 \
