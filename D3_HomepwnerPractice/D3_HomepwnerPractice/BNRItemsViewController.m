//
//  BNRItemsViewController.m
//  D_Homepwner
//
//  Created by yl on 2022/2/1.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()
@property (nonatomic,strong) IBOutlet UIView *headerView;
@end

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    //获取allItems的第n个BNRItem对象，
    //然后将该BNRItem对象的描述信息赋给UITableViewCell对象的textLabel
    //这里的n是该UITableViewCell对象所对应的表格行索引
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    //设置表头视图
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
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

- (UIView*)headerView
{
    // 如果还没有载入headerVIew
    if(!_headerView){
        // 载入HeaderView.xib
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
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
 只要实现此方法，就会显示换行控件
 */
- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [BNRItemStore.sharedStore moveItemAtIndex:sourceIndexPath.row
                                      toIndex:destinationIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}
@end
