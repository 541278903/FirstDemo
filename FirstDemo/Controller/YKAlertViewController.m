//
//  YKAlertViewController.m
//  FirstDemo
//
//  Created by edward on 2020/7/22.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "YKAlertViewController.h"
#import <UserNotifications/UserNotifications.h>


@interface YKAlertViewController ()

@end

@implementation YKAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"测试iOS10定时推送本地通知";
    content.subtitle = @"subTitle";
    content.badge = @1;
    content.body = @"test body";
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"testdata":@"xxxxx"};
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
    UNNotificationRequest *request =[UNNotificationRequest requestWithIdentifier:@"testID" content:content trigger:trigger];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加推送成功");
    }];
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
