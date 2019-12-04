//
//  GCDViewController.m
//  FirstDemo
//
//  Created by edward on 2019/12/4.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "PrefixHeader.pch"

@interface GCDViewController ()
//@property(nonatomic,strong)

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
}

#pragma mark -初始化

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //开启线程的条件，函数是异步函数，队列不在主队列中
    //同步函数无论在任何队列中  1、不开启线程2、串行执行
    //在主队列中无论同步还是异步都是 1、不开启线程2、串行执行
    [self asyncseriac];
}
-(void)asyncconcurrent{
    // 开启多条线程 并且队列中任务异步执行
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

@end
