//
//  BNRImageStore.m
//  D_Homepwner
//
//  Created by yl on 2022/2/3.
//

#import "BNRImageStore.h"


@interface BNRImageStore()
@property (nonatomic,strong) NSMutableDictionary *dictionnary;
@end

@implementation BNRImageStore

// 单例模式实现
+ (instancetype)sharedStore
{
    static BNRImageStore *sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

// 不允许直接使用 init方法
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    if(self){
        _dictionnary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(id)key
{
//    [self.dictionnary setObject:image forKey:key];
    self.dictionnary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
//    return [self.dictionnary objectForKey:key];
    return self.dictionnary[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if(!key){
        return;
    }
    [self.dictionnary removeObjectForKey:key];
}
@end
