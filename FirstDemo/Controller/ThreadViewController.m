//
//  ThreadViewController.m
//  FirstDemo
//
//  Created by edward on 2019/11/30.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "ThreadViewController.h"
#import "PrefixHeader.pch"

@interface ThreadViewController ()

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    thread.name = @"a";
    thread.threadPriority = 0.1;
    [thread start];
    NSThread *threadb = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    threadb.name = @"b";
    threadb.threadPriority = 1.0;
    [threadb start];
}
-(void)run:(NSString *)param
{
    int i = 0;
    while (i<50) {
        MLog(@"---run---%@",[NSThread currentThread]);
        i++;
    }
}



@end
