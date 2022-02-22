//
//  BNRColorViewController.h
//  G_Colorboard
//
//  Created by yl on 2022/2/21.
//

#import <UIKit/UIKit.h>
#import "BNRColorDescription.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNRColorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@property (nonatomic) BOOL existingColor;
@property (nonatomic) BNRColorDescription *colorDescription;
@end

NS_ASSUME_NONNULL_END
