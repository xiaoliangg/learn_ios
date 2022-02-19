//
//  BNRImageStore.m
//  D_Homepwner
//
//  Created by yl on 2022/2/3.
//

#import "BNRImageStore.h"


@interface BNRImageStore()
@property (nonatomic,strong) NSMutableDictionary *dictionnary;
- (NSString *)imagePathForKey:(NSString *)key;
@end

@implementation BNRImageStore

// 单例模式实现
+ (instancetype)sharedStore
{
    static BNRImageStore *sharedStore = nil;
//    if(!sharedStore){
//        sharedStore = [[self alloc] initPrivate];
//    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
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
        //将自身注册为通知中心的观察者,观察内存过低警告
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(id)key
{
//    [self.dictionnary setObject:image forKey:key];
    self.dictionnary[key] = image;
    
    //获取保存图片到路径
    NSString *imagePath = [self imagePathForKey:key];
    //从图片提取JPEG格式的数据
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
//    NSData *data = UIImagePNGRepresentation(image);
    //将JPEG格式的数据写入文件
    [data writeToFile:imagePath atomically:YES];
    
}

- (UIImage *)imageForKey:(NSString *)key
{
//    return [self.dictionnary objectForKey:key];
//    return self.dictionnary[key];
    //先尝试通过字典对象获取图片
    UIImage *result = self.dictionnary[key];
    if(!result){
        NSString *imagePath = [self imagePathForKey:key];
        //通过文件创建UIImage对象
        result = [UIImage imageWithContentsOfFile:imagePath];
        //如果能够通过文件创建图片，就将其放入缓存
        if(result){
            self.dictionnary[key] = result;
        }else{
            NSLog(@"Error: unnable to find:%@",[self imagePathForKey:key]);
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)key
{
    if(!key){
        return;
    }
    [self.dictionnary removeObjectForKey:key];
    
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docomentDirectory = [documentDirectories firstObject];
    return [docomentDirectory stringByAppendingPathComponent:key];
}

-(void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing %lu images out of the cache",[self.dictionnary count]);
    [self.dictionnary removeAllObjects];
}
@end
