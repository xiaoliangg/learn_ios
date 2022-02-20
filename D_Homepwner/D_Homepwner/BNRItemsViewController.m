//
//  BNRItemsViewController.m
//  D_Homepwner
//
//  Created by yl on 2022/2/1.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"
#import "BNRItemCell.h"

@implementation BNRItemsViewController

// 实现两个初始化方法，确保无论使用哪一个，初始化对象都是 UITableViewStylePlain 风格
/**
 新增init方法
 */
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
//        for(int i=0;i<5;i++){
//            [[BNRItemStore sharedStore] createItem];
//        }
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"MyHomepwner";
        
        // 创建新的UIBarButtonItem对象
        // 将其目标对象设置为当前对象，将其动作方法设置为addNewItem
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        // 为UINavigation对象的rightBarButtonItem属性赋值
        // 指向新创建的UIBarButtonItem对象
        navItem.rightBarButtonItem = bbi;
        
        //只需一行代码就实现了编辑功能
        navItem.leftBarButtonItem = self.editButtonItem;
        
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
    // 创建或重用 UITableViewCell 对象
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    BNRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItemCell" forIndexPath:indexPath];

    //获取allItems的第n个BNRItem对象，
    //然后将该BNRItem对象的描述信息赋给UITableViewCell对象的textLabel
    //这里的n是该UITableViewCell对象所对应的表格行索引
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
//    cell.textLabel.text = [item description];
    //根据BNRItem对象设置BNRItemCell对象
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d",item.valueInDollars];
    cell.imageView.image = item.thumbnail;
    cell.actionBlock = ^{
        NSLog(@"Going to show Image for:%@",item);
    };
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // 创建UINib对象，该对象代表包含了BNRItemCell的NIB文件
    UINib *nib = [UINib nibWithNibName:@"BNRItemCell" bundle:nil];
    
    // 通过UINib对象注册相应的NIB文件
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BNRItemCell"];
}

- (IBAction)addNewItem:(id)sender
{
    // 创建NSIndexPath对象，代表的位置上：第一个表格段，最后一个表格行。会报错
//    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    
    // 创建新的BNRItem对象并将其加入BNRItemStore对象
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    // 获取新创建的对象在allItems数组中的索引
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];

    // 将新行插入UITableView对象
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    // yltodo 严重 点击新增页面的Done后没有新增一项
//    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:YES];
//    detailViewController.item = newItem;
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
//    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)toggleEditngMode:(id)sender
{
    // 如果当前的视图控制对象已经处在编辑模式
    if(self.isEditing){
        // 修改按钮文字，提示用户当前的表格状态
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        // 关闭编辑模式
        [self setEditing:NO animated:YES];
    }else{
        // 修改按钮文字，提示用户当前的表格状态
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        // 开启编辑模式
        [self setEditing:YES animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果UITableView对象请求确认的是删除操作
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        //还要删除表格视图中的相应表格行(带动画效果)
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/**
 选中某个UITableviewCell对象时，会触发此消息。
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    detailViewController.item = selectedItem;
    
    //将新创建的BNRDetailViewController对象压入UINavigationController对象的栈
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
@end
