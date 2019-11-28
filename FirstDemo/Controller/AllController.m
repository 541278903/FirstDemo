//
//  AllController.m
//  FirstDemo
//
//  Created by edward on 2019/11/25.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "AllController.h"
#import "ViewController.h"

@implementation AllController
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

@end
