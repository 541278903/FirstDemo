//
//  CTableViewController.m
//  FirstDemo
//
//  Created by edward on 2020/5/13.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "CTableViewController.h"

#import "TShowViewController.h"
@interface CTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray<T_CS_Entity *> *datalist;


@end

@implementation CTableViewController
- (NSArray<T_CS_Entity *> *)datalist{
    if(!_datalist){
        _datalist = [[TcaishiDB GetInstance]GetData:nil];
    }
    return _datalist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refleshdata];
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)refleshdata{
    [[TcaishiDB GetInstance]SetDataWithNetWork];
    self.datalist = [[TcaishiDB GetInstance]GetData:nil];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.datalist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //每一次创建的控制器都是只有一个，不会重复创建(此处不会重复创建是指上下拖动的时候不会重复创建 )
    /**定义可重用的静态标识符*/
    static NSString *ID = @"tb";
    /**优先使用可复用的cell*/
    UITableViewCell *tbc = [tableView dequeueReusableCellWithIdentifier:ID];
    /**如果复用的cell还没有创建，那么创建一个供之后复用*/
    if(tbc == nil)
    {
        /**新创建的cell并使用id复用符标记*/
        tbc = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //cell中的内容不允许在这个创建花括号中填写，因为每个cell的样式可能相同，但是cell中的内容不同会导致cell内容错乱
    }
    T_CS_Entity *entity = self.datalist[indexPath.row];
    tbc.textLabel.text = [NSString stringWithFormat:@"商品名称:%@   商品规格:%@",entity.c_name,entity.c_guige];
    
    
    
    
    return tbc;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TShowViewController *tshowcontroller = [[TShowViewController alloc]init];
    tshowcontroller.entity = self.datalist[indexPath.row];
//    [self.navigationController popToViewController:tshowcontroller animated:YES];
    [self.navigationController pushViewController:tshowcontroller animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
