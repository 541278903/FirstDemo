//
//  BLController.m
//  FirstDemo
//
//  Created by edward on 2019/11/25.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "BLController.h"

#import <BLTNBoard/BLTNBoard.h>
#import <BLTNBoard-Swift.h>
#import "Toast.h"
#import "TButton.h"
@interface BLController ()

@property(nonatomic,strong)BLTNItemManager *blnt;
@property(nonatomic,strong)BLTNPageItem *blitemg;
@end

@implementation BLController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColor.whiteColor];
    TButton *btn = [[TButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = UIColor.redColor;
    [btn addTarget:self action:@selector(Touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(BLTNPageItem *)blitemg
{
    if(!_blitemg)
    {
        BLTNPageItem *blitem = [[BLTNPageItem alloc]initWithTitle:@"弹窗测试"];
        blitem.descriptionText = @"测试Text";
        blitem.actionButtonTitle = @"确定";
        blitem.alternativeButtonTitle = @"取消";
        blitem.dismissable = YES;
        blitem.shouldStartWithActivityIndicator = YES;
        blitem.actionHandler = ^(BLTNActionItem * _Nonnull _item) {
            [[Toast GetInstance] showMessage];
            [_item.manager dismissBulletinAnimated:YES];
        };
        blitem.alternativeHandler = ^(BLTNActionItem * _Nonnull _item) {
            [_item.manager dismissBulletinAnimated:YES];
        };
        blitem.presentationHandler = ^(id<BLTNItem> _Nonnull _item) {
            //延时操作
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_item.manager hideActivityIndicator];
            });
        };
        
        blitem.nextItem = NULL;
        _blitemg = blitem;
    }
    return _blitemg;
}
- (BLTNItemManager *)blnt
{
    if(!_blnt){
        BLTNItemManager *b = [[BLTNItemManager alloc]initWithRootItem:self.blitemg];
        b.backgroundViewStyle = BLTNBackgroundViewStyle.blurredDark;
        _blnt = b;
    }
    return _blnt;
        
}
-(void)Touch
{
    [self.blnt showBulletinAboveViewController:self animated:YES completion:NULL];
}


@end
