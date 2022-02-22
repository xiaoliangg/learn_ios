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
@end
