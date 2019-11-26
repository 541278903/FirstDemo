//
//  TbViewTableViewController.m
//  FirstDemo
//
//  Created by edward on 2019/10/15.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "TbViewTableViewController.h"
#import "TbCell.h"
#import "AllController.h"
#import "ViewController.h"
#import "RecognizerController.h"
#import "BLController.h"
#import "SendMessageController.h"
#define XMGTextFont [UIFont systemFontSize:14];
@interface TbViewTableViewController ()<SendMessageControllerDeleage>
@property(nonatomic,strong)NSMutableArray *allcon;

@end

@implementation TbViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
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
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"你好";
//}
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return @"ffefae";
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllController *con = self.allcon[indexPath.row];
    
    [self.navigationController pushViewController:con.ConView animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"tb";
    UITableViewCell *tbc = [tableView dequeueReusableCellWithIdentifier:ID];
    if(tbc == nil)
    {
        tbc = [[TbCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        AllController *con = self.allcon[indexPath.row];
        tbc.textLabel.text = con.ConName;
        tbc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return tbc;
}
- (NSMutableArray *)allcon
{
    if(!_allcon){
        NSMutableArray *all = [[NSMutableArray alloc]init];
        AllController *firstcon = [[AllController alloc]initWithName:@"空白View" Con: [[ViewController alloc]init]];
        [all addObject:firstcon];
        AllController *seccon = [[AllController alloc]initWithName:@"手势View" Con: [[RecognizerController alloc]init]];
        [all addObject:seccon];
        AllController *thirdcon = [[AllController alloc]initWithName:@"弹窗View" Con: [[BLController alloc]init]];
        [all addObject:thirdcon];
        SendMessageController *forth = [[SendMessageController alloc]init];
        //设置将代理传进去
        forth.delegate = self;
        AllController *forcon = [[AllController alloc]initWithName:@"发送mq消息View" Con: forth];
        [all addObject:forcon];
        _allcon = all;
        
    }
    return _allcon;
}
-(void)SetMessageDelegate:(SendMessageController *)con
{
    AllController *firstcon = [[AllController alloc]initWithName:@"空白View" Con: [[ViewController alloc]init]];
    [self.allcon addObject:firstcon];
    [self.tableView reloadData];
}
@end
