//
//  BNRImageStore.h
//  D_Homepwner
//
//  Created by yl on 2022/2/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRImageStore : NSObject
+ (instancetype)sharedStore;
- (void)setImage:(UIImage *)image forKey:(NString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
