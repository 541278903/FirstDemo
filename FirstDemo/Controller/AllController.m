//
//  AllController.m
//  FirstDemo
//
//  Created by edward on 2019/11/25.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "AllController.h"

@implementation AllController
- (instancetype)initWithName:(NSString *)name  Con:(UIViewController *)con
{
    self = [super init];
    if (self) {
        self.ConName = name;
        self.ConView = con;
        self.ConView.title = self.ConName;
    }
    return self;
}

@end
