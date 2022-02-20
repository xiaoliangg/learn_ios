//
//  BNRItemsViewController.h
//  D_Homepwner
//
//  Created by yl on 2022/2/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRItemsViewController : UITableViewController <UIPopoverControllerDelegate>

@property (nonatomic,strong) UIPopoverController *imagePopover;

@end

NS_ASSUME_NONNULL_END
