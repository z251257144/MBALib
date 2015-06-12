//
//  NSFileManager.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

/**
 介绍：
 简单易用的沙盒文件操作类库，提供了一种简单的方式在 iOS 沙盒中创建和覆盖文件。你不用关心文件的根目录是什么，也不用关心文件的上层目录是否存在。
 
 *********************************
 使用方法：
 判断文件是否存在：
 [kFileManager isFileExists:@"my/file/path/info.txt"]；
 
 创建新文件：
 [kFileManager createFile:"my/file/path/info.txt" overwrite:NO];
 
 创建新文件夹：
 [kFileManager createFolder:"my/file/path"];
 
 获取文件或文件夹的完整目录：
 NSString *fullName = [kFileManager fullFileName:"my/file/path/info.txt"];
 
 删除文件夹的所有子文件：
 NSString *fullName = [kFileManager deleteAllFilesInFolder:"my/file"];
 */

#import <Foundation/Foundation.h>

#define kFileManager       [NSFileManager defaultManager]

@interface NSFileManager (EasyFile)

/**
 convert the short file name to full file name. e.g. "mycache/user/icon.png" -> "/Users/zmsouljun/Library/Application Support/iPhone Simulator/7.1/Applications/ABCE2119-E864-4492-A3A9-A238ADA74BE5/Documents/mycache/user/icon.png".
 @return full file name.
 */
- (NSString *)fullFileName:(NSString *)shortFileName;

/**
 test if the file exists.
 @param fileName file path and file name, e.g. "mycache/user/icon.png".
 @return YES if exists, NO otherwise.
 */
- (BOOL)fileIsExists:(NSString *)fileName;

/**
 create a file
 @param fileName fileName file path and file name, e.g. "mycache/user/icon.png".
 @param shouldOverwrite YES:if the file exists then overwirte it, NO:if the file exists then do nothing
 */
- (void)createFile:(NSString *)fileName overwrite:(BOOL)shouldOverwrite;

/**
 create a folder
 @param folder folderName path, e.g. "mycache/user".如果存在就跳过
 */
- (void)createFolder:(NSString *)folderName;

/**
 Deletes all the files inside a given folder.
 
 @param pathToFolder folder to delete
 @return -1 if given folder does not exist or is not a folder.
 0 if either folder is already empty or all the files are successfully deleted.
 N > 0, where N is the number of files that could not be deleted.
 */
- (NSInteger)deleteAllFilesInFolder:(NSString*)folderName;

@end
