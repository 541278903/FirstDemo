//
//  PersonModel.m
//  FirstDemo
//
//  Created by edward on 2020/3/3.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "PersonModel.h"
@interface PersonModel()

@property(nonatomic,strong)NSString *sex;
@end

@implementation PersonModel
-(void)shout{
    MLog(@"...");
}
+ (BOOL)resolveClassMethod:(SEL)sel{
    NSString *str = NSStringFromSelector(sel);
    if([str isEqualToString:@"eat"]){
        IMP imp = method_getImplementation(class_getInstanceMethod(self, @selector(shout)));
        class_addMethod(self, @selector(eat), imp, "");
    }
    return [super resolveClassMethod:sel];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    NSString *str = NSStringFromSelector(sel);
    if([str isEqualToString:@"eat"]){
        IMP imp = method_getImplementation(class_getInstanceMethod(self, @selector(shout)));
        class_addMethod(self, @selector(eat), imp, "");
    }
    return [super resolveInstanceMethod:sel];
}
@end
