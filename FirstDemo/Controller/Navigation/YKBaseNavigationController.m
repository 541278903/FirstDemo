//
//  YKBaseNavigationController.m
//  FirstDemo
//
//  Created by edward on 2020/9/2.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "YKBaseNavigationController.h"

@interface YKBaseNavigationController ()

@end

@implementation YKBaseNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (YES) {
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [self.view.layer addAnimation:transition forKey:kCATransition];
    }
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (YES) {
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromBottom;
        [self.view.layer addAnimation:transition forKey:kCATransition];
    }
    return [super popViewControllerAnimated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
