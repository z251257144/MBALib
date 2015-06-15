//
//  UIControl+YYAdd.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "YYKitMacro.h"


@interface UIControl (YYAdd)

// Removes all targets and actions for a particular event (or events) from an internal dispatch table.
- (void)removeAllTargets;

/**
 Adds or replaces a target and action for a particular event (or events) to an internal dispatch table.
 
 @param target The target object—that is, the object to which the action message is sent. If this is nil, the responder chain is searched for an object willing to respond to the action message.
 @param action A selector identifying an action message. It cannot be NULL.
 @param controlEvents A bitmask specifying the control events for which the action message is sent.
 */
- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 Adds a block for a particular event (or events) to an internal dispatch table.
 
 @param block The block which is invoked then the action message is sent. It cannot be nil.
 @param controlEvents A bitmask specifying the control events for which the action message is sent.
 */
- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/**
 Adds or replaces a block for a particular event (or events)
 to an internal dispatch table.
 
 @param block The block which is invoked then the action message is sent. It cannot be nil.
 @param controlEvents A bitmask specifying the control events for which the action message is sent.
 */
- (void)setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/**
 Adds or replaces a block for UIControlEventTouchUpInside event to an internal dispatch table.
 
 @param block The block which is invoked then the action message is sent. It cannot be nil.
 */
- (void)setTouchUpInsideBlock:(void (^)(id sender))block;

/**
 Removes all blocks for a particular event (or events) from an internal dispatch table.
 
 @param controlEvents A bitmask specifying the control events for which the action message is sent.
 */
- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;


@end
