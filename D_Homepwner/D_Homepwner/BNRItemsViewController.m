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
@end
