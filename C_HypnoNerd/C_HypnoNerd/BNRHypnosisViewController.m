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

/**
 UITextFieldDelegate 的方法 委托设计模式
 */
- (BOOL)textFieldShouldReturn:(UITextField *) textField
{
    NSLog(@"%@",textField.text);
    [self drawHypnoticMessage:textField.text];
    //清空文本
    textField.text = @"";
    //关闭键盘
    [textField resignFirstResponder];
    return YES;
}

/**
 催眠屏幕中画出文字
 */
- (void)drawHypnoticMessage:(NSString *) message
{
    for(int i = 0;i<20;i++){
        UILabel *messageLabel = [[UILabel alloc] init];
        
        //设置UILable对象的文字和颜色
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        //根据需要显示的文字调整UILabel对象的大小
        [messageLabel sizeToFit];
        
        //获取随机x坐标
        //使UILabel对象的宽度不超出BNRHypnosisViewController的view宽度
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        //获取随机y坐标
        //使UILabel对象的高度不超出BNRHypnosisViewController的view高度
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        //设置UILable对象的frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        //将UILabel对象添加到BNRHypnosisViewController的view中
        [self.view addSubview:messageLabel];
    }
}
@end
