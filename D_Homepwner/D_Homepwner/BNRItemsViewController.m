//
//  BNRItemsViewController.m
//  D_Homepwner
//
//  Created by yl on 2022/2/1.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemsViewController

// 实现两个初始化方法，确保无论使用哪一个，初始化对象都是 UITableViewStylePlain 风格
/**
 新增init方法
 */
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        for(int i=0;i<5;i++){
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}
/**
 覆盖父类初始化方法
 */
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

/**
 UITableViewDataSource 方法实现
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

/**
 UITableViewDataSource 方法实现
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建UITableViewCell对象，风格使用默认的 UITableViewCellStyleDefault
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    //获取allItems的第n个BNRItem对象，
    //然后将该BNRItem对象的描述信息赋给UITableViewCell对象的textLabel
    //这里的n是该UITableViewCell对象所对应的表格行索引
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    return cell;
}



@end
