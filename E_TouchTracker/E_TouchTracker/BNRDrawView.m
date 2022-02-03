//
//  BNRDrawView.m
//  E_TouchTracker
//
//  Created by yl on 2022/2/3.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView ()

@property (nonatomic,strong) NSMutableDictionary *linesInProgress;
@property (nonatomic,strong) NSMutableArray *finishedLines;

@end
@implementation BNRDrawView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}

#pragma mark - 画线
- (void)strokeLine:(BNRLine *) line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect
{
    // 用黑色绘制已经完成的线条
    [[UIColor blackColor] set];
    for(BNRLine *line in self.finishedLines){
        CGFloat f = [self angleOfLineStart:line.begin LineEnd:line.end];
        CGFloat red = (int)f % 2 ? 1.0:0.0;
        CGFloat green = (int)(f*10) % 2 ? 1.0:0.0;
        CGFloat blue = (int)(f*100) % 2 ? 1.0:0.0;
        UIColor *color = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:1.0];
        [color set];
        [self strokeLine:line];
    }
    
    // 用红色绘制正在画的线条
    [[UIColor redColor] set];
    for(NSValue *key in self.linesInProgress){
        [self strokeLine:self.linesInProgress[key]];
    }
}

#pragma mark - 处理触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 向控制台输出日志，查看触摸事件发生顺序
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        CGPoint location = [t locationInView:self];
        
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 向控制台输出日志，查看触摸事件发生顺序
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{    // 向控制台输出日志，查看触摸事件发生顺序
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 向控制台输出日志，查看触摸事件发生顺序
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

#pragma -mark 其他
//  结果介于[-PI, PI]
- (CGFloat)angleOfLineStart:(CGPoint)lineStart LineEnd:(CGPoint)lineEnd
{
    CGFloat a = lineEnd.x - lineStart.x;
    CGFloat b = lineEnd.y - lineStart.y;
    return atan2(a, b);
}
@end
