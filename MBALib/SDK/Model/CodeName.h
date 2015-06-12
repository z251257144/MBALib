//
//  City.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeName : NSObject

@property (nonatomic, strong) NSString *code;   //编号
@property (nonatomic, strong) NSString *name;   //名称
@property (nonatomic, strong) NSString *value;  //数值

- (void)setCode:(NSString*)code name:(NSString*)name;

+ (CodeName*)codeNameWithCode:(NSString*)code name:(NSString*)name;

@end


@interface NSArray (SearchCode)

- (id)objectForCode:(NSString*)code;

- (NSUInteger)indexOfCode:(NSString*)code;

- (id)objectForName:(NSString*)name;

- (NSUInteger)indexOfName:(NSString*)name;

@end;