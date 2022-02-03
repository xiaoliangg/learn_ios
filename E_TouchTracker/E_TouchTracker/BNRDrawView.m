//
//  BNRDrawView.m
//  E_TouchTracker
//
//  Created by yl on 2022/2/3.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView ()

@property (nonatomic,strong) BNRLine *currentLine;
@property (nonatomic,strong) NSMutableArray *finishedLines;

@end
@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

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
        [self strokeLine:line];
    }
    
    if(self.currentLine){
        // 用红色绘制正在画的线条
        [[UIColor redColor] set];
        [self strokeLine:self.currentLine];
    }
}
@end
