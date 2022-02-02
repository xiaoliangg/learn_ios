//
//  BNRItemStore.m
//  D_Homepwner
//
//  Created by yl on 2022/2/2.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore()
// 二维数组，用于是否大于50美元进行分组
@property (nonatomic) NSMutableArray *twoGroupItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
    //判断是否需要创建一个sharedStore对象
    if(!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

// 如果使用init，提示使用 [BNRItemStore sharedStore]
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

// 真正都初始化方法。未在 .h 中声明，方法未私有方法
- (instancetype)initPrivate
{
    self = [super init];
    if(self){
        _twoGroupItems = [[NSMutableArray alloc] init];
        _twoGroupItems[0] = [[NSMutableArray alloc] init];
        _twoGroupItems[1] = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return self.twoGroupItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    if(item.valueInDollars > 50){
        [self.twoGroupItems[1] addObject:item];
    }else{
        [self.twoGroupItems[0] addObject:item];
    }
    return item;
}
@end
