//
//  BNRHypnosisView.m
//  B_Hpnosister
//
//  Created by yl on 2022/1/28.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        // 设置 BNRHypnosisView对象的背景颜色为透明
        self.backgroundColor = [UIColor clearColor];
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
    
    // 根据视图宽和高中的较小值计算圆形的半径
    float radius = (MIN(bounds.size.width,bounds.size.height)/2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // 定义路径
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI*2.0 clockwise:NO];
    
    // 设置线条颜色
    [[UIColor lightGrayColor] setStroke];
    
    // 设置线条宽度为10
    path.lineWidth = 10.0;
    
    // 绘制路径
    [path stroke];
}


@end
