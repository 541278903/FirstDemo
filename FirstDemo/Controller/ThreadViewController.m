//
//  ThreadViewController.m
//  FirstDemo
//
//  Created by edward on 2019/11/30.
//  Copyright © 2019 com.Edward. All rights reserved.
//

//#import "ThreadViewController.h"
//#import "PrefixHeader.pch"

@interface ThreadViewController ()

@property(nonatomic,strong)NSThread *threadA;
@property(nonatomic,strong)NSThread *threadB;
@property(nonatomic,strong)NSThread *threadC;
@property(nonatomic,assign)NSInteger totalCont;

@property(nonatomic,strong)UIImageView *imageview;

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.totalCont = 100;
    [self.view addSubview:self.imageview];
    [NSThread detachNewThreadSelector:@selector(fff) toTarget:self withObject:nil];
}
#pragma mark -多线程显示图片
//http://img4.imgtn.bdimg.com/it/u=3209370120,2008812818&fm=26&gp=0.jpg
-(void)fff{
    NSURL *url = [NSURL URLWithString:@"https://img.ivsky.com/img/tupian/pic/201905/02/chongwumao-010.jpg"];
    NSData *imagedata = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imagedata];
    MLog(@"-----获取图片-----");
    if(!image) return;
    [self performSelectorOnMainThread:@selector(ggg:) withObject:image waitUntilDone:YES];
    MLog(@"-----end--------");
    
}
-(void)ggg:(UIImage *)image{
    self.imageview.image = image;
    MLog(@"-----加载图片-----");
}

- (UIImageView *)imageview{
    if(!_imageview){
        UIImageView *image = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _imageview = image;
    }
    return _imageview;
}
#pragma mark -初始化

-(void)run:(NSString *)param
{
    int i = 0;
    while (i<50) {
        MLog(@"---run---%@",[NSThread currentThread]);
        i++;
    }
}
- (NSThread *)threadA{
    if(!_threadA){
        _threadA = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
        _threadA.name = @"A";
    }
    return _threadA;
}
- (NSThread *)threadB{
    if(!_threadB){
        _threadB = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
        _threadB.name = @"B";
    }
    return _threadB;
}
- (NSThread *)threadC{
    if(!_threadC){
        _threadC = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
        _threadC.name = @"C";
    }
    return _threadC;
}

-(void)saleTicket{
    
    while (1) {
//        锁：必须是全局唯一的（一般使用self）
        @synchronized (self) {
             NSInteger count = self.totalCont;
            if(count>0){
                for(int a = 0;a<10000000;a++){
    //            模拟耗时操作
                }
                self.totalCont = count -1;
                MLog(@"----%@卖了第%ld的票",[NSThread currentThread].name,count);
            }else{
                MLog(@"卖光了");
                break;
            }
        }
    }
}



@end
