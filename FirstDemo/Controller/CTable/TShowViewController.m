//
//  TShowViewController.m
//  FirstDemo
//
//  Created by edward on 2020/5/13.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "TShowViewController.h"

@interface TShowViewController ()

@end

@implementation TShowViewController

- (T_CS_Entity *)entity{
    if(!_entity){
        _entity = [[T_CS_Entity alloc]init];
    }
    return _entity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    MLog(@"%@",self.entity.c_name);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
