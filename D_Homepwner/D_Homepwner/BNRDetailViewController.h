//
//  BNRDetailViewController.h
//  D_Homepwner
//
//  Created by yl on 2022/2/3.
//

#import <UIKit/UIKit.h>
@class BNRItem;
NS_ASSUME_NONNULL_BEGIN

@interface BNRDetailViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (nonatomic,strong) BNRItem *item;
@end

NS_ASSUME_NONNULL_END
