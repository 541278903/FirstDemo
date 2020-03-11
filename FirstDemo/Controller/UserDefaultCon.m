//
//  UserDefaultCon.m
//  FirstDemo
//
//  Created by edward on 2020/3/11.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "UserDefaultCon.h"
#import "Major.h"

@interface UserDefaultCon ()

@end

@implementation UserDefaultCon

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setup];// ⏬NSUserDefaults 简单数据快速读写
//    [self setup2];// ⏬属性列表文件存储 并写入沙盒，重点沙盒熟记
//    [self setup3];// ⏬Archive 归档
//    [self setup4];// ⏬Archive 自定义对象归档
    [self setup5];
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
// ⏬Archive 归档
-(void)setup3{

    NSString *homeDictory = NSHomeDirectory();
    NSString *homePath = [homeDictory stringByAppendingPathComponent:@"testAchiver1"];
    /**简单归档写入文件
     NSArray *array = @[@"obj1",@"obj2",@"obj3"];
     BOOL flag = [NSKeyedArchiver archiveRootObject:array toFile:homePath];
     NSArray *unarchivedArray;
     if(flag){
         unarchivedArray = [NSKeyedUnarchiver unarchiveObjectWithFile:homePath];
     }
     */
    /**多对象归档
     */
    NSInteger intVal = 1;
    NSString *strVal = @"string";
    CGPoint pointVal = CGPointMake(1.0, 1.0);
    /**初始化归档工具*/
    NSMutableData *mulData = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:mulData];
    /**归档*/
    [archiver encodeInteger:intVal forKey:@"key_integer"];
    [archiver encodeObject:strVal forKey:@"key_string"];
    [archiver encodeCGPoint:pointVal forKey:@"key_point"];
    /**结束归档*/
    [archiver finishEncoding];
    /**归档的数据写入*/
    [mulData writeToFile:homePath atomically:YES];
    
    /**解归档*/
    NSMutableData *undata = [[NSMutableData alloc]initWithContentsOfFile:homePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:undata];
    CGPoint unpointVal = [unarchiver decodeCGPointForKey:@"key_point"];
    NSString *unstrVal = [unarchiver decodeObjectForKey:@"key_string"];
    NSInteger uninterVal = [unarchiver decodeIntegerForKey:@"key_integer"];
    [unarchiver finishDecoding];
    MLog(@"%@",unstrVal);
}
// ⏬Archive 自定义对象归档
-(void)setup4{
    //实现自定义对象归档要遵守NSCoding协议
    NSString *homeDictory = NSHomeDirectory();
    NSString *homePath = [homeDictory stringByAppendingPathComponent:@"testAchivermyself"];
    Major *major = [[Major alloc]init];
    major.sax = @"nan";
    //方式一，直接存到本地形成文件，最后读取文件再解档
    [NSKeyedArchiver archiveRootObject:major toFile:homePath];
    Major *aftermajor;
    aftermajor = [NSKeyedUnarchiver unarchiveObjectWithFile:homePath];
    
    //方式二，先归档为data类型，然后对data进行存储或转移，发送等操作，最后通过data归档成对象，更加灵活，可以不存在本地文件，可以上传等操作
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:major];
    
    aftermajor = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    MLog(@"%@",aftermajor.sax);
}
-(void)setup5{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        MLog(@"timer");
    }];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
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
