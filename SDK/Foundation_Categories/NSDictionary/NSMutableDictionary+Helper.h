//
//  NSMutableDictionary+Helper.h
//  Helper
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Helper)

/** Filters a mutable dictionary to the key/value pairs matching the block.

 @param block A BOOL-returning code block for a key/value pair.
 @see <NSDictionary(Helper)>reject:
 */
- (void)performSelect:(BOOL (^)(id key, id obj))block;

/** Filters a mutable dictionary to the key/value pairs not matching the block,
 the logical inverse to select:.

 @param block A BOOL-returning code block for a key/value pair.
 @see <NSDictionary(Helper)>select:
 */
- (void)performReject:(BOOL (^)(id key, id obj))block;

/** Transform each value of the dictionary to a new value, as returned by the
 block.

 @param block A block that returns a new value for a given key/value pair.
 @see <NSDictionary(Helper)>map:
 */
- (void)performMap:(id (^)(id key, id obj))block;

@end
