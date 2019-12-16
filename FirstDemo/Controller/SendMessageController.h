//
//  SendMessageController.h
//  FirstDemo
//
//  Created by edward on 2019/11/25.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SendMessageController;

//添加代理
@protocol SendMessageControllerDeleage <NSObject>
@required
//添加代理方法
-(void)SetMessageDelegate:(SendMessageController *)con;
@end


@interface SendMessageController : UIViewController

- (instancetype)initWithDelegate:(id)delegate;
@property(nonatomic,weak)id<SendMessageControllerDeleage> delegate;
@end

NS_ASSUME_NONNULL_END
