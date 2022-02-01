//
//  BNRItemStore.m
//  D_Homepwner
//
//  Created by yl on 2022/2/2.
//

#import "BNRItemStore.h"

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
    return self;
}

@end
