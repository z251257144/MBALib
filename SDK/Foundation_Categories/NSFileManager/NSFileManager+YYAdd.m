//
//  NSFileManager.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "NSFileManager+YYAdd.h"

@implementation NSFileManager (EasyFile)

- (NSString *)fullFileName:(NSString *)shortFileName
{
    //search the "document" path
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    NSString *file = [documentDirectory stringByAppendingPathComponent:shortFileName];
    return file;
}

- (BOOL)fileIsExists:(NSString *)fileName
{
    NSString *file = [self fullFileName:fileName];
    return [self fileExistsAtPath:file];
}

- (void)createFile:(NSString *)fileName overwrite:(BOOL)shouldOverwrite
{
    //create file directory, include multilayer directory
    NSRange lastTag = [fileName rangeOfString:@"/" options:NSBackwardsSearch];
    if (lastTag.location != NSNotFound && lastTag.location != 0) {
        NSString *shortDir = [fileName substringToIndex:lastTag.location];
        NSString *fullDir = [self fullFileName:shortDir];
        if (![self fileExistsAtPath:fullDir]) {
            [self createDirectoryAtPath:fullDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    NSString *file = [self fullFileName:fileName];
    
    //file not exists or want to overwrite it
    if (shouldOverwrite || ![self fileExistsAtPath:file]) {
        BOOL suc = [self createFileAtPath:file contents:nil attributes:nil];
        NSLog(@"create file(%@) %@", file, suc ? @"successfully" : @"failed");
    }
}

- (void)createFolder:(NSString *)folderName
{
    //create file directory, include multilayer directory
    NSString *fullDir = [self fullFileName:folderName];
    if (![self fileExistsAtPath:fullDir]) {
        NSLog(@"full directory: %@", fullDir);
        [self createDirectoryAtPath:fullDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (NSInteger)deleteAllFilesInFolder:(NSString*)folderName
{
    NSString *fullDir = [self fullFileName:folderName];
    NSArray* files = [self contentsOfDirectoryAtPath:fullDir error:nil];
    
    if (files == nil) return -1;
    
    NSInteger failed = 0;
    
    for(NSString* file in files) {
        NSString* fullPathToFile = [fullDir stringByAppendingPathComponent:file];
        if (![self removeItemAtPath:fullPathToFile error:nil]) failed++;
    }
    
    NSLog(@"清空文件夹: %@, 删除文件数量：%d", fullDir, (int)failed);
    
    return failed;
}

@end