//
//  UserDefaultCon.m
//  FirstDemo
//
//  Created by edward on 2020/3/11.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "UserDefaultCon.h"

@interface UserDefaultCon ()

@end

@implementation UserDefaultCon

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setup];// ⏬NSUserDefaults 简单数据快速读写
    [self setup2];
}
// ⏬NSUserDefaults 简单数据快速读写
-(void)setup{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"data" forKey:@"key1"];
    [defaults setDouble:3.1415926 forKey:@"double1"];
    [defaults setBool:YES forKey:@"bool1"];
    [defaults removeObjectForKey:@"bool1"];
    MLog(@"%@",[defaults objectForKey:@"bool1"]);
}
// ⏬属性列表文件存储 并写入沙盒，重点沙盒熟记
-(void)setup2{
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"]];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/demo.plist"];
    [mdic writeToFile:filePath atomically:YES];
    
    NSMutableDictionary *mdic2 = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    MLog(@"%@",mdic2);
    
    
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
