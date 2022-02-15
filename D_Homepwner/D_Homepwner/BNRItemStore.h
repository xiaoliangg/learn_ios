//
//  BNRItemStore.h
//  D_Homepwner
//
//  Created by yl on 2022/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// @class指令解释 这里只用到了BNRItem的声明，没有用到BNRItem的方法、属性等，故使用@class
// 优点:当 BNRItem.h 发生变化时，此文件无需重新编译
@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic,readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;
@end

NS_ASSUME_NONNULL_END
