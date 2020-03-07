//
//  NotificationKVCKVO.m
//  FirstDemo
//
//  Created by edward on 2020/3/7.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "NotificationKVCKVO.h"
#define MyNotification @"NSNotificationTestName"

@interface NotificationKVCKVO ()

@end

@implementation NotificationKVCKVO

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MLog(@"all ");
    [self setup];
}
- (void)viewDidAppear:(BOOL)animated{
//    MLog(@"viewapper");
}
// ⏬使用Notification
-(void)setup{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotification) name:MyNotification object:nil];
    MLog(@"即将发出通知");
    
    
    //Delegate 和 Notification的区别在于前者是一对一且可以回调，而消息则是一对多但不可以回调
    /**
    // ⏬使用 同步消息通知机制  消息通知默认是在主线程中默认是同步的
     [[NSNotificationCenter defaultCenter] postNotificationName:MyNotification object:nil];
     */
    
    /**

     // ⏬使用 异步消息通知机制
     //方法一
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
         [[NSNotificationCenter defaultCenter] postNotificationName:MyNotification object:nil];
     });
     //方法二  将通知放到通知异步缓冲队列里
     NSNotification *notification = [NSNotification notificationWithName:MyNotification object:nil];
     [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostASAP];
          
     */
    
    MLog(@"处理完通知");
    
    
}

// ⏬使用 KVC 和 KVO
-(void)setup2{
    
}
-(void)testNotification{
    sleep(2);//模拟延迟操作
    MLog(@"this is the testnotification");
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
