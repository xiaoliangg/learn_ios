//
//  BNRHypnosisViewController.m
//  C_HypnoNerd
//
//  Created by yl on 2022/1/31.
//
#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@implementation BNRHypnosisViewController

- (void)loadView
{
    // 创建一个BNRHypnosisView对象
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc]initWithFrame:textFieldRect];
    // 设置UITextField对象的边框样式，便于查看它在屏幕上的位置
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    // delegate属性需要实现 UITextFieldDelegate 协议，否则会报warning
    textField.delegate = self;
    [backgroundView addSubview:textField];

    // 将 BNRHypnosisView 对象赋给视图控制器的view属性
    self.view = backgroundView;
}

// init 方法会调用此方法，两个传参均为nil
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        // 设置标签项的标题
        self.tabBarItem.title = @"Hypnotize";
        
        // 从图像文件创建一个UIImage对象
        // 在Retia显示屏上会加载Hypno@2x.png，而不是Hypno.png
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        
        // 将UIImage对象赋给标签项的image属性
        self.tabBarItem.image = i;
        
//        //UISegmentedControl
//        //参考:https://www.jianshu.com/p/7d9e4d4368c8
//        //先生成存放标题的数据
//        NSArray *array = [NSArray arrayWithObjects:@"红",@"绿",@"蓝", nil];
//        //初始化UISegmentedControl
//        UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
//        //设置frame
//        segment.frame = CGRectMake(80.0, 80.0, self.view.frame.size.width-5.0, 150.0);
//        //根据内容定分段宽度
//        segment.apportionsSegmentWidthsByContent = YES;
//        // 设置指定索引选项的宽度(设置下标为2的分段宽度)
//        [segment setWidth:70.0 forSegmentAtIndex:1];
//        // 设置分段中标题的位置(0,0点为中心)
//        [segment setContentOffset:CGSizeMake(10,10) forSegmentAtIndex:1];
//        //控件渲染色(也就是外观字体颜色)
//        segment.tintColor = [UIColor redColor];
//        //添加事件
//        [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
//        //添加到视图
//        [self.view addSubview:segment];
        
    }
    return self;
}
 // 检查视图控制器的视图是否已经加载
- (void)viewDidLoad
{
    // 必须调用父类的 viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"BNRHypnosisViewController loaded its view.");
}

- (BOOL)textFieldShouldReturn:(UITextField *) textField
{
    NSLog(@"%@",textField.text);
    
}
@end
