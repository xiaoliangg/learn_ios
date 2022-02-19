//
//  BNRItemStore.m
//  D_Homepwner
//
//  Created by yl on 2022/2/2.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore()
@property (nonatomic) NSMutableArray *privateItems;
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
//        _privateItems = [[NSMutableArray alloc] init];
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        // 如果之前没有保存过privateItems,就创建一个新的
        if(!_privateItems){
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if(fromIndex == toIndex){
        return;
    }
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

- (NSString *)itemArchivePath
{
    // 注意第一个参数是 NSDocumentDirectory 而不是 NSDocumentationDirectory
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // 从 documentDirectories 数组获取第一个，也是唯一文档目录路径
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"item.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    NSLog(@"archive file path:%@",path);
    // 如果固化成功就返回YES
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

@end
