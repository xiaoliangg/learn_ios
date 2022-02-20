//
//  BNRImageViewController.m
//  D_Homepwner
//
//  Created by yl on 2022/2/20.
//

#import "BNRImageViewController.h"

@implementation BNRImageViewController

- (void)loadView
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [super viewWillAppear:animated];
    //必须将view转换为UIImageView对象，以便向其发送setImage消息
    UIImageView *imageView = (UIImageView *)self.view;
    imageView.image = self.image;
}
@end
