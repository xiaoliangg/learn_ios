//
//  BNRColorDescription.m
//  G_Colorboard
//
//  Created by yl on 2022/2/22.
//

#import "BNRColorDescription.h"

@implementation BNRColorDescription

- (instancetype) init
{
    self = [super init];
    if(self){
        _color = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        _name = @"Blue";
    }
    return self;
}
@end
