//
//  NSMutableIndexSet+Helper.h
//  Helper
//

#import <Foundation/Foundation.h>


@interface NSMutableIndexSet (Helper)

/** Filters a mutable index set to the indexes matching the block.

 @param block A single-argument, BOOL-returning code block.
 @see <NSIndexSet(Helper)>reject:
 */
- (void)performSelect:(BOOL (^)(NSUInteger index))block;

/** Filters a mutable index set to all indexes but the ones matching the block,
 the logical inverse to select:.

 @param block A single-argument, BOOL-returning code block.
 @see <NSIndexSet(Helper)>select:
 */
- (void)performReject:(BOOL (^)(NSUInteger index))block;

/** Transform each index of the index set to a new index, as returned by the
 block.

 @param block A block that returns a new index for a index.
 @see <NSIndexSet(Helper)>map:
 */
- (void)performMap:(NSUInteger (^)(NSUInteger index))block;


@end
