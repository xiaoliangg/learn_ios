//
//  BNRDetailViewController.m
//  D_Homepwner
//
//  Created by yl on 2022/2/3.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation BNRDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    
    // 创建 NSDateFormatter 对象，用于将 NSDate 对象转换成简单的日期字符串
    static NSDateFormatter *dateFormatter = nil;
    if(!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    //将转换后的日期字符串设置为dateLabel的标题
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 取消当前的第一响应对象
    [self.view endEditing:YES];
    
    // 将修改保存至BNRItem
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

/**
 在视图设置item属性时，同时设置导航栏标题
 */
- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}
@end
