#import <Foundation/Foundation.h>

#import "DDLog.h"

/**
 * 发送日志语句到苹果的日志系统，以便它们显示在Console.app上
 * This class provides a logger for the Apple System Log facility.
 * 
 * As described in the "Getting Started" page,
 * the traditional NSLog() function directs it's output to two places:
 * 
 * - Apple System Log
 * - StdErr (if stderr is a TTY) so log statements show up in Xcode console
 * 
 * To duplicate NSLog() functionality you can simply add this logger and a tty logger.
 * However, if you instead choose to use file logging (for faster performance),
 * you may choose to use a file logger and a tty logger.
**/

@interface DDASLLogger : DDAbstractLogger <DDLogger>

+ (instancetype)sharedInstance;

@end
