//
//  TbViewTableViewController.m
//  FirstDemo
//
//  Created by edward on 2019/10/15.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "TbViewTableViewController.h"
#import "TbCell.h"
#define XMGTextFont [UIFont systemFontSize:14];
@interface TbViewTableViewController ()

@end

@implementation TbViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 3;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"你好";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"ffefae";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"tb";
    UITableViewCell *tbc = [tableView dequeueReusableCellWithIdentifier:ID];
    if(tbc == nil)
    {
        tbc = [[TbCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        tbc.textLabel.text = @"123";
        tbc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    return tbc;
}

@end
