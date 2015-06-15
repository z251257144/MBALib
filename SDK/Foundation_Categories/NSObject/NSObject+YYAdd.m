//
//  NSObject+Add.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSObject+YYAdd.h"
#import "YYKitMacro.h"
#import <objc/runtime.h>

DUMMY_CLASS(NSObject_YYAdd)

//*****************************线程相关定义
#pragma mark - 线程相关定义
FOUNDATION_EXTERN void BACK_RUN(void (^block)(void))
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        ((void (^)())block)();
    });
}
FOUNDATION_EXTERN void MAIN_RUN(void (^block)(void))
{
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        ((void (^)())block)();
    });
}


@implementation NSObject (YYAdd)

- (NSArray*)arrayValue {
	return [NSArray arrayWithObject:self];
}

- (NSMutableArray*)mutableArrayValue {
	return [NSMutableArray arrayWithObject:self];
}

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (NSString *)className {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

-(NSString *)autoDescribe:(Class)classType
{
    id instance = self;
    
    unsigned int count;
    objc_property_t *propList = class_copyPropertyList(classType, &count);
    NSMutableString *propPrint = [NSMutableString string];
    
    for ( int i = 0; i < count; i++ )
    {
        if (i > 0) {
            [propPrint appendString:@"\n"];
        }
        
        objc_property_t property = propList[i];
        
        const char *propName = property_getName(property);
        NSString *propNameString =[NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
        
        if(propName)
        {
            @try {
                id value = [instance valueForKey:propNameString];
                [propPrint appendString:[NSString stringWithFormat:@"%@=%@", propNameString, value]];
            }
            @catch (NSException *exception) {
                [propPrint appendString:[NSString stringWithFormat:@"Can't get value for property %@ through KVO", propNameString]];
            }
        }
    }
    free(propList);
    
    
    // Now see if we need to map any superclasses as well.
    Class superClass = class_getSuperclass( classType );
    if ( superClass != nil && ! [superClass isEqual:[NSObject class]] )
    {
        NSString *superString = [instance autoDescribe:superClass];
        [propPrint appendString:@"\n"];
        [propPrint appendString:superString];
    }
    
    return propPrint;
}

-(NSString *)autoDescribe
{
	// Don't try to autoDescribe NSManagedObject subclasses (Core Data does this already)
    if ([self isKindOfClass:NSClassFromString(@"NSManagedObject")]) {
        return [self description];
    }
	
	Class classType = [self class];
    return [self autoDescribe:classType];
}


@end


@implementation NSObject (BlockTimer)

- (void)logTimeToRunBlock:(void (^)(void)) block withPrefix:(NSString*)prefixString
{
	double a = CFAbsoluteTimeGetCurrent();
	block();
	double b = CFAbsoluteTimeGetCurrent();
	
	unsigned int m = ((b-a) * 1000.0f); // convert from seconds to milliseconds
	
	NSLog(@"%@: %d ms", prefixString ? prefixString : @"Time taken", m);
}

@end
