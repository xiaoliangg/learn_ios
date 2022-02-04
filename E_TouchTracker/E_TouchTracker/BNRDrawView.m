//
//  BNRDrawView.m
//  E_TouchTracker
//
//  Created by yl on 2022/2/3.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIPanGestureRecognizer *moveRecognizer;
@property (nonatomic,strong) NSMutableDictionary *linesInProgress;
@property (nonatomic,strong) NSMutableArray *finishedLines;
// 单击选择的线条；弱引用
@property (nonatomic,weak) BNRLine *selectedLine;
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
        
        // 添加双击手势
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        // 避免双击的第一下点击出现小圆点儿
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];
        
        // 添加单击手势
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        // 确定不是双击，才识别单击
        // 避免双击时，触发单击手势
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        // 添加长按手势
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        
        // 添加拖动手势
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
    }
    return self;
}

#pragma mark - 画线
- (void)strokeLine:(BNRLine *) line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = line.width;
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
        [self strokeLine:line];
    }
    
    // 用红色绘制正在画的线条
    [[UIColor redColor] set];
    for(NSValue *key in self.linesInProgress){
        [self strokeLine:self.linesInProgress[key]];
    }
    
    // 用绿色绘制选中线条
    if(self.selectedLine){
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
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
        
        CGFloat speed = [self getSpeedX:(line.end.x-line.begin.x) getSpeedY:(line.end.y-line.begin.y)];
        line.width = speed*speed;
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

#pragma mark - 手势识别

- (void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tap");
    
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Tap");
    
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if(self.selectedLine){
        // 使视图成为UIMenuItem动作消息的目标
        // 对应的UIView对象必须是当前UIWindow的第一响应对象
        [self becomeFirstResponder];
        // 获取UIMenuController对象
        UIMenuController *menu = [UIMenuController sharedMenuController];
        // 创建一个新的标题为“Delete”的UIMenuItem对象
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        // 先为UIMenuController对象设置显示区域，然后将其设置为可见
        [menu showMenuFromView:self rect:CGRectMake(point.x, point.y, 2, 2)];
//        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
//        [menu setMenuVisible:YES animated:YES];
    }else{
        // 如果没有选中的线条，就隐藏UIMenuController对象
//        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
        [[UIMenuController sharedMenuController] hideMenuFromView:self];
    }
    [self setNeedsDisplay];
}

/**
 找到离p点最近点线条
 */
- (BNRLine *)lineAtPoint:(CGPoint)p
{
    // 找出离p最近的BNRLine对象
    for (BNRLine *l in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        // 检查线条的若干点
        for (float t = 0.0; t<=1.0; t += 0.5) {
            float x = start.x + t*(end.x - start.x);
            float y = start.y + t*(end.y - start.y);
            // 如果线条的某个点和p的距离中20点以内，就返回响应的BNRLine对象
            if(hypot(x-p.x, y-p.y) < 20.0){
                return l;
            }
        }
    }
    // 如果没能找到符合条件的线条，就返回nil，代表不选择任何线条
    return nil;
}

/**
 覆盖方法并返回YES
 */
- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void)deleteLine:(id)sender
{
    // 从已经完成的线条中删除选中的线条
    [self.finishedLines removeObject:self.selectedLine];
    
    [self setNeedsDisplay];
}

- (void)longPress:(UIGestureRecognizer *)gr
{
    if(gr.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        
        if(self.selectedLine){
            [self.linesInProgress removeAllObjects];
        }
    }else if(gr.state == UIGestureRecognizerStateEnded){
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if(gestureRecognizer == self.moveRecognizer){
        return YES;
    }
    return NO;
}

- (void)moveLine:(UIPanGestureRecognizer *) gr
{
    // 如果没有选中的线条就直接返回
    if(!self.selectedLine){
        return;
    }
    
    // 如果UIPanGestureRecognizer 对象处于“变化后”的状态
    if(gr.state == UIGestureRecognizerStateChanged){
        // 获取手指的拖移距离
        CGPoint translation = [gr translationInView:self];
        // 将拖移距离加至选中的线条的起点和终点
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        // 为选中的线条设置新的起点和终点
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        
        [self setNeedsDisplay];
        
        // 增量报告拖移距离 见P259
        [gr setTranslation:CGPointZero inView:self];
    }
}

- (CGFloat)getSpeedX:(CGFloat)x getSpeedY:(CGFloat)y
{
    NSDate *currentDate = [[NSDate alloc] init];
    CGFloat currentTime = [currentDate timeIntervalSince1970] * 1000;
          
    static CGFloat oldTime;
    CGFloat speed;
    if(oldTime){
        CGFloat time = currentTime - oldTime;
        CGFloat length = sqrt(x*x + y*y);
        speed = length/time;
    }
    oldTime = currentTime;
    NSLog(@"speed:%f",speed);
    return speed;
}
@end

