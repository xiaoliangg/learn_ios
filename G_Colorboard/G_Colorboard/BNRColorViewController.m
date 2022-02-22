//
//  BNRColorViewController.m
//  G_Colorboard
//
//  Created by yl on 2022/2/21.
//

#import "BNRColorViewController.h"

@implementation BNRColorViewController

- (IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeColor:(id)sender
{
    float red = self.redSlider.value;
    float green = self.greenSlider.value;
    float blue = self.blueSlider.value;
    
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.view.backgroundColor = newColor;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //如果颜色已经存在，就移除Done按钮
    if(self.existingColor){
        self.navigationItem.rightBarButtonItem = nil;
    }
}

/**
 新建和查看时会触发此方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *color = self.colorDescription.color;
    //从UIColor中取出RGB颜色分量
    CGFloat red,green,blue;
    [color getRed:&red green:&green blue:&blue alpha:nil];
    //初始化UISlider对象的滑块值
    self.redSlider.value = red;
    self.greenSlider.value = green;
    self.blueSlider.value = blue;
    //初始化view的背景颜色和颜色名称
    [self.view setBackgroundColor:color];
    self.textField.text = self.colorDescription.name;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.colorDescription.name = self.textField.text;
    self.colorDescription.color = self.view.backgroundColor;
}

@end
