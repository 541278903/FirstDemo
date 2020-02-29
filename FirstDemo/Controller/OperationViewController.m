//
//  OperationViewController.m
//  FirstDemo
//
//  Created by edward on 2019/12/26.
//  Copyright © 2019 com.Edward. All rights reserved.
//


@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self Setup];
}
-(void)Setup{
    
    NSOperationQueue *queue = [NSOperationQueue currentQueue];//主队列（串行队列）
    NSOperationQueue *serqueue = [[NSOperationQueue alloc]init];//非主队列（同时具备并发和串行）
    
    //创建操作
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        MLog(@"blockOperation");
    }];
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        MLog(@"blockOperation2");
    }];
    [blockOperation2 addDependency:blockOperation];//线程依赖 2依赖1 1完成后才执行2

    //操作内追加任务
    [blockOperation addExecutionBlock:^{
        MLog(@"one add operation");
    }];
    [queue addOperation:blockOperation2];
    
    [queue addOperation:blockOperation];
    
    [queue addOperationWithBlock:^{
        MLog(@"queue add operation");
    }];
}

@end
