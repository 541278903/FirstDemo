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

@protocol SendMessageControllerDeleage <NSObject>

@required
-(void)SetMessageDelegate:(SendMessageController *)con;


@end
@interface SendMessageController : UIViewController

@property(nonatomic,weak)id<SendMessageControllerDeleage> delegate;
@end

NS_ASSUME_NONNULL_END
