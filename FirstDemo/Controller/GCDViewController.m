//
//  GCDViewController.m
//  FirstDemo
//
//  Created by edward on 2019/12/4.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "PrefixHeader.pch"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
}

#pragma mark - 初始化

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    开启线程的条件，函数是异步函数，队列不在主队列中
//    同步函数无论在任何队列中  1、不开启线程2、串行执行
//    在主队列中无论同步还是异步都是 1、不开启线程2、串行执行
    [self onceAndafter];
    
}
-(void)onceAndafter{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MLog(@"once");
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MLog(@"after");
    });
}
-(void)asyncconcurrent{
//    开启多条线程 并且并发队列中任务异步执行
    dispatch_queue_t queue = dispatch_queue_create("com.mashiro", DISPATCH_QUEUE_CONCURRENT);
    MLog(@"-start-");
    dispatch_async(queue, ^{
        MLog(@"-download1-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MLog(@"-download2-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MLog(@"-download3-%@",[NSThread currentThread]);
    });
    NSLog(@"-end-");
}
-(void)asyncseriac{
//    异步函数在串行队列中，会开线程，开一条线程，队列中的任务是串行执行（在新开的那条线程中）。
    dispatch_queue_t queue = dispatch_queue_create("com.mashiro2", DISPATCH_QUEUE_SERIAL);
    MLog(@"-start-");
    dispatch_async(queue, ^{
        MLog(@"-download1-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MLog(@"-download2-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MLog(@"-download3-%@",[NSThread currentThread]);
    });
    NSLog(@"-end-");
}
-(void)syncCONCURENT{
    dispatch_queue_t queue = dispatch_queue_create("com.mashiro3", DISPATCH_QUEUE_SERIAL);
//    同步函数无论在并行还是串行队列中都只不会开线程和只会串行执行
    MLog(@"-start-");
    dispatch_sync(queue, ^{
       MLog(@"-download1-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
       MLog(@"-download2-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
       MLog(@"-download3-%@",[NSThread currentThread]);
    });
    NSLog(@"-end-");
}
-(void)deadthlock{
    dispatch_queue_t queue = dispatch_get_main_queue();
//    造成死锁：主线程等待本方法结束后再执行队列中新增的方法，但方法中等同步函数等待主线程执行完自己的函数才释放。
    MLog(@"-start-");
    dispatch_sync(queue, ^{
       MLog(@"-download1-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
       MLog(@"-download2-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
       MLog(@"-download3-%@",[NSThread currentThread]);
    });
    NSLog(@"-end-");
    
}
@end
