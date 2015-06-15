//
//  NSMutableArray+Helper.h
//  Helper
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (Helper)

/** Filters a mutable array to the objects matching the block.

 @param block A single-argument, BOOL-returning code block.
 @see <NSArray(Helper)>reject:
 */
- (void)performSelect:(BOOL (^)(id obj))block;

/** Filters a mutable array to all objects but the ones matching the block,
 the logical inverse to select:.

 @param block A single-argument, BOOL-returning code block.
 @see <NSArray(Helper)>select:
 */
- (void)performReject:(BOOL (^)(id obj))block;

/** Transform the objects in the array to the results of the block.

 This is sometimes referred to as a transform, mutating one of each object:
	[foo performMap:^id(id obj) {
	  return [dateTransformer dateFromString:obj];
	}];

 @param block A single-argument, object-returning code block.
 @see <NSArray(Helper)>map:
 */
- (void)performMap:(id (^)(id obj))block;

@end
