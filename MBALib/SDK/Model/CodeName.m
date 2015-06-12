//
//  CodeName
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "CodeName.h"

@implementation CodeName

@synthesize code = _code;
@synthesize name = _name;
@synthesize value = _value;

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}


- (void)setCode:(NSString*)code name:(NSString*)name
{
    self.code = code;
    self.name = name;
}

+ (CodeName*)codeNameWithCode:(NSString*)code name:(NSString*)name
{
    CodeName *codeName = [[CodeName alloc] init];
    [codeName setCode:code name:name];
    return codeName;
}

#pragma mark - 重载
- (BOOL)isEqual:(id)object
{
    if (object == self) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    CodeName *codeName = (CodeName *)object;
    return [codeName.code isEqualToString:self.code] || [codeName.name isEqualToString:self.name];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"code=%@, name=%@, value=%@", _code, _name, _value];
}

@end


@implementation NSArray (SearchCode)

- (id)objectForCode:(NSString*)code
{
    NSUInteger index = [self indexOfCode:code];
    if (NSNotFound == index) {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

- (NSUInteger)indexOfCode:(NSString*)code
{
    if (!code) {
        return NSNotFound;
    }
    
    if (self.count==0) {
        return NSNotFound;
    }
    Class class = [[self objectAtIndex:0] class];
    CodeName *tempCodeName = [[class alloc] init];
    tempCodeName.code = code;
    return [self indexOfObject:tempCodeName];
}

- (id)objectForName:(NSString*)name
{
    NSUInteger index = [self indexOfName:name];
    if (NSNotFound == index) {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

- (NSUInteger)indexOfName:(NSString*)name
{
    if (!name) {
        return NSNotFound;
    }
    
    if (self.count==0) {
        return NSNotFound;
    }
    Class class = [[self objectAtIndex:0] class];
    CodeName *tempCodeName = [[class alloc] init];
    tempCodeName.name = name;
    return [self indexOfObject:tempCodeName];
}

@end
