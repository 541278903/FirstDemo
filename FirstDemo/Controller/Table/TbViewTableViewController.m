//
//  TbViewTableViewController.m
//  FirstDemo
//
//  Created by edward on 2019/10/15.
//  Copyright © 2019 com.Edward. All rights reserved.
//
//#import "PrefixHeader.pch"


#import "CTableViewController.h"

#define XMGTextFont [UIFont systemFontSize:14];
@interface TbViewTableViewController ()<SendMessageControllerDeleage>
@property(nonatomic,strong)NSMutableArray *allcon;

@end

@implementation TbViewTableViewController
-(void)gettextHeight{
    //获取行间字体高度
    NSString *text = @"feo";
    NSDictionary *texxtAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize textsize = CGSizeMake(self.view.bounds.size.width, MAXFLOAT);
    CGFloat hight = [text boundingRectWithSize:textsize options:NSStringDrawingUsesLineFragmentOrigin attributes:texxtAtt context:nil].size.height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refleshdata];
    }];
    //延时操作
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        MLog(@"延时操作");
//    });
    
}
-(void)refleshdata{
    self.allcon = nil;
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - Table view data source

/// 多少组数据
/// @param tableView 代理table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}
///下拉偏移量
/// @param scrollView 代理scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    scrollView.contentOffset.y
//    NSLog(@"%f",scrollView.contentOffset.y);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.allcon.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllController *con = self.allcon[indexPath.row];
    
    [self.navigationController pushViewController:con.ConView animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //每一次创建的控制器都是只有一个，不会重复创建(此处不会重复创建是指上下拖动的时候不会重复创建 )
    /**定义可重用的静态标识符*/
    static NSString *ID = @"tb";
    /**优先使用可复用的cell*/
    UITableViewCell *tbc = [tableView dequeueReusableCellWithIdentifier:ID];
    /**如果复用的cell还没有创建，那么创建一个供之后复用*/
    if(tbc == nil)
    {
        /**新创建的cell并使用id复用符标记*/
        tbc = [[TbCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //cell中的内容不允许在这个创建花括号中填写，因为每个cell的样式可能相同，但是cell中的内容不同会导致cell内容错乱
    }

    AllController *con = self.allcon[indexPath.row];
    /**配置cell数据*/
    tbc.textLabel.text = con.ConName;
    tbc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return tbc;
}
/// 自定义的代理
/// @param con 所存在的控制器
-(void)SetMessageDelegate:(SendMessageController *)con
{
    AllController *firstcon = [[AllController alloc]init];
    [self.allcon addObject:firstcon];
    [self.tableView reloadData];
}
#pragma mark - 首次初始化
- (NSMutableArray *)allcon
{
    if(!_allcon){
        NSMutableArray *all = [[NSMutableArray alloc]init];
        
        AllController *lastcon = [[AllController alloc]initWithName:@"数据库" Con:[[CTableViewController alloc]init]];
        [all addObject:lastcon];
        
        AllController *setincon = [[AllController alloc]initWithName:@"数据持久化" Con:[[UserDefaultCon alloc]init]];
        [all addObject:setincon];
        AllController *twelcon = [[AllController alloc]initWithName:@"图层与动画" Con:[[LayerAndUIView alloc] init ]];
        [all addObject:twelcon];
        AllController *elevcon = [[AllController alloc]initWithName:@"通知机制" Con:[[NotificationKVCKVO alloc]init]];
        [all addObject:elevcon];
        AllController *tencon = [[AllController alloc]initWithName:@"Runtime" Con:[[RunTimeController alloc]init]];
        [all addObject:tencon];
        AllController *nigthcon = [[AllController alloc]initWithName:@"NSOperation" Con:[[OperationViewController alloc] init]];
        [all addObject:nigthcon];
        AllController *eightcon = [[AllController alloc]initWithName:@"拖动试图" Con:[[ScrollerController alloc] init]];
        [all addObject:eightcon];
        AllController *sevencon = [[AllController alloc]initWithName:@"GCD管理" Con:[[GCDViewController alloc]init]];
        [all addObject:sevencon];
        AllController *sixcon = [[AllController alloc]initWithName:@"多线程" Con:[[ThreadViewController alloc]init]];
        [all addObject:sixcon];
        AllController *fifcon = [[AllController alloc]initWithName:@"Toast提示" Con:[[ToastViewController alloc] init]];
        [all addObject:fifcon];
        AllController *forcon = [[AllController alloc]initWithName:@"发送mq消息View" Con: [[SendMessageController alloc]initWithDelegate:self]];
        [all addObject:forcon];
        AllController *thirdcon = [[AllController alloc]initWithName:@"弹窗View" Con: [[BLController alloc]init]];
        [all addObject:thirdcon];
        AllController *seccon = [[AllController alloc]initWithName:@"手势View" Con: [[RecognizerController alloc]init]];
        [all addObject:seccon];
        AllController *firstcon = [[AllController alloc]initWithName:@"空白View" Con: [[ViewController alloc]init]];
        [all addObject:firstcon];
        _allcon = all;
    }
    return _allcon;
}
//navigationShouldPopOnBackButt
@end
