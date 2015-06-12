//
//  NSInvocation+Helper.h
//  Helper
//

#import <Foundation/Foundation.h>

/** Helper extensions for NSInvocation. */
@interface NSInvocation (Helper)

/** Generates a forwarding `NSInvocation` instance for a given method call
 encapsulated by the given block.

	NSInvocation *invocation = [NSInvocation invocationWithTarget:target block:^(id myObject) {
		[myObject someMethodWithArg:42.0];
	}];

 This returns an invocation with the appropriate target, selector, and arguments
 without creating the buffers yourself. It is only recommended to call a method
 on the argument to the block only once. More complicated forwarding machinery
 can be accomplished by the A2DynamicDelegate family of classes included in
 Helper.

 @param target The object to "grab" the block invocation from.
 @param block A code block.
 @return A fully-prepared instance of NSInvocation ready to be invoked.
 */
+ (NSInvocation *)invocationWithTarget:(id)target block:(void (^)(id target))block;

@end
