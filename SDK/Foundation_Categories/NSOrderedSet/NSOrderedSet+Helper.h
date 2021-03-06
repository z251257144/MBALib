//
//  NSOrderedSet+Helper.h
//  Helper
//

#import <Foundation/Foundation.h>
#import "NSMutableOrderedSet+Helper.h"

@interface NSOrderedSet (Helper)

/** Loops through an ordered set and executes the given block with each object.

 @param block A single-argument, void-returning code block.
 */
- (void)each:(void (^)(id obj))block;

/** Enumerates through an ordered set concurrently and executes the given block
 once for each object.

 Enumeration will occur on appropriate background queues. This will have a
 noticeable speed increase, especially on multi-core devices, but you *must*
 be aware of the thread safety of the objects you message from within the block.
 Be aware that the order of objects is not necessarily the order each block will
 be called in.

 @param block A single-argument, void-returning code block.
 */
- (void)apply:(void (^)(id obj))block;

/** Loops through an ordered set to find the object matching the block.

 match: is functionally identical to select:, but will stop and return
 on the first match.

 @param block A single-argument, `BOOL`-returning code block.
 @return Returns the object, if found, or `nil`.
 @see select:
 */
- (id)match:(BOOL (^)(id obj))block;

/** Loops through an ordered set to find the objects matching the block.

 @param block A single-argument, BOOL-returning code block.
 @return Returns an ordered set of the objects found.
 @see match:
 */
- (NSOrderedSet *)select:(BOOL (^)(id obj))block;

/** Loops through an ordered set to to find the objects not matching the block.

 This selector performs *literally* the exact same function as select: but in
 reverse.

 This is useful, as one may expect, for removing objects from an ordered set to.
	 NSOrderedSet *new = [computers reject:^BOOL(id obj) {
		 return ([obj isUgly]);
	 }];

 @param block A single-argument, BOOL-returning code block.
 @return Returns an ordered set of all objects not found.
 */
- (NSOrderedSet *)reject:(BOOL (^)(id obj))block;

/** Call the block once for each object and create an ordered set of the return
 values.

 This is sometimes referred to as a transform, mutating one of each object:
	 NSOrderedSet *new = [stringArray map:^id(id obj) {
		 return [obj stringByAppendingString:@".png"]);
	 }];

 @param block A single-argument, object-returning code block.
 @return Returns an ordered set of the objects returned by the block.
 */
- (NSOrderedSet *)map:(id (^)(id obj))block;

/** Arbitrarily accumulate objects using a block.

 The concept of this selector is difficult to illustrate in words. The sum can
 be any NSObject, including (but not limited to) a string, number, or value.

 For example, you can concentate the strings in an ordered set:
	 NSString *concentrated = [stringArray reduce:@"" withBlock:^id(id sum, id obj) {
		 return [sum stringByAppendingString:obj];
	 }];

 You can also do something like summing the lengths of strings in an ordered set:
	 NSUInteger value = [[[stringArray reduce:nil withBlock:^id(id sum, id obj) {
		 return @([sum integerValue] + obj.length);
	 }]] unsignedIntegerValue];

 @param initial The value of the reduction at its start.
 @param block A block that takes the current sum and the next object to return the new sum.
 @return An accumulated value.
 */
- (id)reduce:(id)initial withBlock:(id (^)(id sum, id obj))block;

/** Loops through an ordered set to find whether any object matches the block.

 This method is similar to the Scala list `exists`. It is functionally
 identical to match: but returns a `BOOL` instead. It is not recommended
 to use any: as a check condition before executing match:, since it would
 require two loops through the ordered set.

 For example, you can find if a string in an ordered set starts with a certain
 letter:

	 NSString *letter = @"A";
	 BOOL containsLetter = [stringArray any:^(id obj) {
		 return [obj hasPrefix:@"A"];
	 }];

 @param block A single-argument, BOOL-returning code block.
 @return YES for the first time the block returns YES for an object, NO otherwise.
 */
- (BOOL)any:(BOOL (^)(id obj))block;

/** Loops through an ordered set to find whether no objects match the block.

 This selector performs *literally* the exact same function as all: but in reverse.

 @param block A single-argument, BOOL-returning code block.
 @return YES if the block returns NO for all objects in the ordered set, NO
 otherwise.
 */
- (BOOL)none:(BOOL (^)(id obj))block;

/** Loops through an ordered set to find whether all objects match the block.

 @param block A single-argument, BOOL-returning code block.
 @return YES if the block returns YES for all objects in the ordered set, NO
 otherwise.
 */
- (BOOL)all:(BOOL (^)(id obj))block;

/** Tests whether every element of this ordered set relates to the corresponding
 element of another array according to match by block.

 For example, finding if a list of numbers corresponds to their sequenced string values;

	 NSArray *numbers = @[ @(1), @(2), @(3) ];
	 NSArray *letters = @[ @"1", @"2", @"3" ];
	 BOOL doesCorrespond = [numbers corresponds:letters withBlock:^(id number, id letter) {
		 return [[number stringValue] isEqualToString:letter];
	 }];

 @param list An array of objects to compare with.
 @param block A two-argument, BOOL-returning code block.
 @return Returns a BOOL, true if every element of the ordered set relates to
 corresponding element in another ordered set.
 */
- (BOOL)corresponds:(NSOrderedSet *)list withBlock:(BOOL (^)(id obj1, id obj2))block;
@end
