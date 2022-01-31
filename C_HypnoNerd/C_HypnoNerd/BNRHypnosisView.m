//
//  BNRHypnosisView.m
//  B_Hpnosister
//
//  Created by yl on 2022/1/28.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()
@property (strong,nonatomic) UIColor *circleColor;
@end

@implementation BNRHypnosisView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        // 设置 BNRHypnosisView对象的背景颜色为透明
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
//        [self setCircleColor:[UIColor lightGrayColor]];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    
    // 根据bounds计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width/2.0;
    center.y = bounds.origin.y + bounds.size.height/2.0;
    
    // 使最外层圆形成为视图的外接圆
    float maxRadius = hypot(bounds.size.width, bounds.size.height)/2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // 定义路径
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        // 移除横线:抬起笔移动到下一个圆的起始处
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI*2.0 clockwise:YES];
    }
    
    // 设置线条颜色
    [self.circleColor setStroke];
    
    // 设置线条宽度为10
    path.lineWidth = 10.0;
    
    // 绘制路径
    [path stroke];
    
}

// BNRHypnosisView 被触摸时会收到该消息
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched",self);
    
    // 获取三个0到1之间的数字
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
    [self setNeedsDisplay];
}
@end
