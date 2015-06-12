//
//  NSSet+Helper.h
//  Helper
//

#import <Foundation/Foundation.h>

@interface NSSet (Helper)

/** Loops through a set and executes the given block with each object.

 @param block A single-argument, void-returning code block.
 */
- (void)each:(void (^)(id obj))block;

/** Enumerates through a set concurrently and executes
 the given block once for each object.

 Enumeration will occur on appropriate background queues. This
 will have a noticeable speed increase, especially on dual-core
 devices, but you *must* be aware of the thread safety of the
 objects you message from within the block.

 @param block A single-argument, void-returning code block.
 */
- (void)apply:(void (^)(id obj))block;

/** Loops through a set to find the object matching the block.

 match: is functionally identical to select:, but will stop and return
 on the first match.

 @param block A single-argument, BOOL-returning code block.
 @return Returns the object if found, `nil` otherwise.
 @see select:
 */
- (id)match:(BOOL (^)(id obj))block;

/** Loops through a set to find the objects matching the block.

 @param block A single-argument, BOOL-returning code block.
 @return Returns a set of the objects found.
 @see match:
 */
- (NSSet *)select:(BOOL (^)(id obj))block;

/** Loops through a set to find the objects not matching the block.

 This selector performs *literally* the exact same function as select, but in reverse.

 This is useful, as one may expect, for removing objects from a set:
	 NSSet *new = [reusableWebViews reject:^BOOL(id obj) {
	   return ([obj isLoading]);
	 }];

 @param block A single-argument, BOOL-returning code block.
 @return Returns an array of all objects not found.
 */
- (NSSet *)reject:(BOOL (^)(id obj))block;

/** Call the block once for each object and create a set of the return values.

 This is sometimes referred to as a transform, mutating one of each object:
	 NSSet *new = [mimeTypes map:^id(id obj) {
	   return [@"x-company-" stringByAppendingString:obj]);
	 }];

 @param block A single-argument, object-returning code block.
 @return Returns a set of the objects returned by the block.
 */
- (NSSet *)map:(id (^)(id obj))block;

/** Arbitrarily accumulate objects using a block.

 The concept of this selector is difficult to illustrate in words. The sum can
 be any NSObject, including (but not limited to) a string, number, or value.

 You can also do something like summing the count of an item:
	 NSUInteger numberOfBodyParts = [[bodyList reduce:nil withBlock:^id(id sum, id obj) {
	   return @([sum integerValue] + obj.numberOfAppendages);
	 }] unsignedIntegerValue];

 @param initial The value of the reduction at its start.
 @param block A block that takes the current sum and the next object to return the new sum.
 @return An accumulated value.
 */
- (id)reduce:(id)initial withBlock:(id (^)(id sum, id obj))block;

/** Loops through a set to find whether any object matches the block.

 This method is similar to the Scala list `exists`. It is functionally
 identical to match: but returns a `BOOL` instead. It is not recommended
 to use any: as a check condition before executing match:, since it would
 require two loops through the array.

 @param block A single-argument, BOOL-returning code block.
 @return YES for the first time the block returns YES for an object, NO otherwise.
 */
- (BOOL)any:(BOOL (^)(id obj))block;

/** Loops through a set to find whether no objects match the block.

 This selector performs *literally* the exact same function as all: but in reverse.

 @param block A single-argument, BOOL-returning code block.
 @return YES if the block returns NO for all objects in the set, NO otherwise.
 */
- (BOOL)none:(BOOL (^)(id obj))block;

/** Loops through a set to find whether all objects match the block.

 @param block A single-argument, BOOL-returning code block.
 @return YES if the block returns YES for all objects in the set, NO otherwise.
 */
- (BOOL)all:(BOOL (^)(id obj))block;

@end
