//
//  NotificationKVCKVO.m
//  FirstDemo
//
//  Created by edward on 2020/3/7.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "NotificationKVCKVO.h"
#import "PersonModel.h"
#import "Major.h"
#define MyNotification @"NSNotificationTestName"

@interface NotificationKVCKVO ()
@property(nonatomic,strong)PersonModel *person;
@end

@implementation NotificationKVCKVO

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setup];//◀️使用Notification
//    [self setup2];//◀️使用 KVC 和 KVO
    [self setup3];
    
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
    
    self.person = [[PersonModel alloc]init];
    self.person.major = [[Major alloc]init];
    
    [self.person setValue:@"Sam" forKey:@"myname"];
    [self.person setValue:@"Sam's major" forKeyPath:@"major.myname"];
    
    
    [self.person addObserver:self forKeyPath:@"major.myname" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    //在最后delloc中要释放掉观察值资源，防止资源泄露
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.person setValue:@"Edward's major" forKeyPath:@"major.myname"];
    });
    
    //KVC 高阶消息传递
    
    NSArray *arr = @[@"asm",@"otm",@"ajck"];
    NSArray *newarr = [arr valueForKey:@"uppercaseString"];//取出数组中每个值进行获取uppercaseString的属性再组成新的数组
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"major.myname"]) {
        NSString *oldvalue = [change objectForKey:NSKeyValueChangeOldKey];
        NSString *newvalue = [change objectForKey:NSKeyValueChangeNewKey];
        MLog(@"old:%@...new:%@",oldvalue,newvalue);
    }else if ([keyPath isEqual:@"infomation"]){
//        MLog(@"sax:%@",)
        MLog(@"设置了");
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
// ⏬使用 KVO键值关联
-(void)setup3{
    PersonModel *person = [[PersonModel alloc]init];
    Major *maj = [[Major alloc]init];
    person.major = maj;
    [person addObserver:self forKeyPath:@"infomation" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    maj.sax = @"1313";
    MLog(@"%@",person.infomation);
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
- (void)dealloc
{
    [self.person removeObserver:self forKeyPath:@"major.myname"];
}

@end
