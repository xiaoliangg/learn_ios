//
//  BNRDetailViewController.m
//  D_Homepwner
//
//  Created by yl on 2022/2/3.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;


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
    
    // 根据itemKey，从 BNRImageStore 对象获取照片
    NSString *itemKey = item.itemKey;
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    // 将得到的照片赋给UIImageView对象
    self.imageView.image = imageToDisplay;
    
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

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // 如果设备支持相机，就使用拍照模式
    // 否则让用户从照片库选择照片
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    // 以模态的形式显示 UIImagePickerController 对象
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    // 通过info字典获取选择的照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 以itemKey为键，将照片存入BNRImageStore对象
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    // 将照片放入UIImageView对象
    self.imageView.image = image;
    // 关闭 UIImagePickerController对象
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
