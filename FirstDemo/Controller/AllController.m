//
//  AllController.m
//  FirstDemo
//
//  Created by edward on 2019/11/25.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "AllController.h"
#import "ViewController.h"
@interface AllController()


@end

@implementation AllController


@synthesize name = theName;//自定义变量名，执行完次代码后，内存中_name将被theName代替
- (NSString *)name{
    if(theName){}
    return theName;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.ConName = @"未初始化";
        self.ConView = [[ViewController alloc]init];
        self.ConView.title = self.ConName;
    }
    return self;
}
- (instancetype)initWithName:(NSString *)name  Con:(UIViewController *)con{
    self = [super init];
    if (self) {
        self.ConName = name;
        self.ConView = con;
        self.ConView.title = self.ConName;
    }
    return self;
}
-(BOOL)isNull{
    return self.ConView == NULL;
}
- (void)eat2
{
    MLog(@"AllController吃了东西")
}

@end
