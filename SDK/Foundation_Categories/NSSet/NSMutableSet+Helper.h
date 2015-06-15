//
//  NSMutableSet+Helper.h
//  Helper
//

#import <Foundation/Foundation.h>

@interface NSMutableSet (Helper)

/** Filters a mutable set to the objects matching the block.

 @param block A single-argument, BOOL-returning code block.
 @see <NSSet(Helper)>reject:
 */
- (void)performSelect:(BOOL (^)(id obj))block;

/** Filters a mutable set to all objects but the ones matching the block,
 the logical inverse to select:.

 @param block A single-argument, BOOL-returning code block.
 @see <NSSet(Helper)>select:
 */
- (void)performReject:(BOOL (^)(id obj))block;

/** Transform the objects in the set to the results of the block.

 This is sometimes referred to as a transform, mutating one of each object:
	[controllers map:^id(id obj) {
	  return [obj view];
	}];

 @param block A single-argument, object-returning code block.
 @see <NSSet(Helper)>map:
 */
- (void)performMap:(id (^)(id obj))block;

@end
