//
//  BNRPaletteViewController.m
//  G_Colorboard
//
//  Created by yl on 2022/2/22.
//

#import "BNRPaletteViewController.h"
#import "BNRColorViewController.h"
#import "BNRColorDescription.h"

@interface BNRPaletteViewController()

@property (nonatomic) NSMutableArray *colors;

@end

@implementation BNRPaletteViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.colors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell_yl" forIndexPath:indexPath];
    BNRColorDescription *color = self.colors[indexPath.row];
    cell.textLabel.text = color.name;
    return cell;
}

- (NSMutableArray *)colors
{
    if(!_colors){
        _colors = [NSMutableArray array];
        BNRColorDescription *cd = [[BNRColorDescription alloc] init];
        [_colors addObject:cd];
    }
    return _colors;
}

/**
 segue 可以拿到 destinationViewController 的引用，并修改其属性，以达到传参的目的
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"NewColor"]){
        //如果是添加新颜色
        //就创建一个BNRColorDescription对象并将其添加到colors数组中
        BNRColorDescription *color = [[BNRColorDescription alloc] init];
        [self.colors addObject:color];
        
        //通过 UIStoryboardSegue 对象
        //设置 BNRColorViewController 对象的颜色 (colorDescription 属性)
        UINavigationController *nc = (UINavigationController *) segue.destinationViewController;
        BNRColorViewController *mvc = (BNRColorViewController *)[nc topViewController];
        mvc.colorDescription = color;
    }else if([segue.identifier isEqualToString:@"ExistingColor"]){
        //对于 push 样式的 UIStoryboardSegue 对象，sender是 UITableViewCell 对象
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        BNRColorDescription *color = self.colors[ip.row];
        
        //设置 BNRColorViewController 对象的颜色
        //同时设置其existingColor属性为YES(该颜色已经存在)
        BNRColorViewController *cvc = (BNRColorViewController *)segue.destinationViewController;
        cvc.colorDescription = color;
        cvc.existingColor = YES;
    }
}
@end
