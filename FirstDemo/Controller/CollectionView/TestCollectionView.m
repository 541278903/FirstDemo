//
//  TestCollectionView.m
//  FirstDemo
//
//  Created by edward on 2020/5/23.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "TestCollectionView.h"

@interface TestCollectionView ()
@property(nonatomic,strong) NSArray *books;
@end

@implementation TestCollectionView


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
//    YYKBaseButton *btn =
    YYKBaseButtonConfig *config = [[YYKBaseButtonConfig alloc]init];
    config.titleName = @"你好";
    config.image = [UIImage imageNamed:@"1"];
    config.target = @selector(clickSet);
    config.selfViewController = self;
    YYKBaseButton *btn = [[YYKBaseButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100) AndYYKBaseButtonConfig:config];
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view.
}
-(void)clickSet{
    MLog(@"你好");
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
