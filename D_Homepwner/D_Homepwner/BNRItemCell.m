//
//  BNRItemCell.m
//  D_Homepwner
//
//  Created by yl on 2022/2/19.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

/**
 点击缩略图显示全尺寸图片
 */
- (IBAction)showImage:(id)sender
{
    // 调用block对象之前要检查block对象是否存在
    if(self.actionBlock){
        self.actionBlock();
    }
}

@end
