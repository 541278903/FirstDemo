//
//  OperationViewController.m
//  FirstDemo
//
//  Created by edward on 2019/12/26.
//  Copyright © 2019 com.Edward. All rights reserved.
//


#import "PersonModel.h"
#import "SonModel.h"
@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
//    [self Setup];
    PersonModel *per = [[PersonModel alloc]init];
    PersonModel *son = [[SonModel alloc]init];
    [per shout];
    [son shout];
}
-(void)Demo{
    
    //通过谓词对象查找数组中模型的东西 其中Person模型有name和age两个属性
    NSArray *objectArray = [[NSArray alloc]initWithObjects:@"Person模型",@"",@"", nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age > 10 && age <20"];
    NSArray *newArray = [objectArray filteredArrayUsingPredicate:predicate];
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
    [serqueue addOperationWithBlock:^{    //<-通讯外的队列不能为主队列
        //线程间通讯
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            MLog(@"%@",[NSThread currentThread]);
        }];
    }];
    if (self._IQDescription) {
        MLog(@"1.....%@",self._IQDescription);
    }
}

@end
