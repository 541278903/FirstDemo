//
//  BaseAlertCenter.h
//


#import "YKAlertCenter.h"
#import <pthread.h>


static const NSInteger kMMC_AlertLoading_Tag = 888;
static const NSInteger kMMC_AlertMessage_Tag = 889;

@implementation YKAlertCenter

+ (void)showMessage:(NSString *)message inView:(UIView *)view {
    // 1.0.2版本取消了该逻辑
    // 某某 da shi 请求block、回调block分离，依靠 + showMessage: 移除 loading。取消该功能后，其loading无法正常移除
    // 这里加个先删除Loading吧
    [self dissLoading];
    if (message.length == 0) {
        return;
    }
    
    // 删除旧的先
    UIView *beforeView = [view viewWithTag:kMMC_AlertMessage_Tag];
    if (beforeView) {
        [beforeView removeFromSuperview];
        beforeView = nil;
    }
    
    BOOL isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    CGFloat showW = isPad?200:150;
    CGFloat showH = isPad?45:25;
    CGFloat spacX = isPad?10:10;
    
    UIFont *showFont = [UIFont systemFontOfSize:isPad?24:16];
    CGSize theStringSize = [message boundingRectWithSize:CGSizeMake(showW-spacX*2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: showFont} context:nil].size;
    if (theStringSize.height<showH) {
        theStringSize.height = showH;
    }
    
    // 背景
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showW, theStringSize.height+spacX*2)];
    showView.tag = kMMC_AlertMessage_Tag;
    showView.alpha = 0;
    showView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    showView.layer.cornerRadius = isPad?10:7;
    showView.layer.masksToBounds = YES;
    showView.center = CGPointMake(CGRectGetWidth(view.frame)/2, CGRectGetHeight(view.frame)/2);
    [view addSubview:showView];
    
    // 内容
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(spacX, spacX, showW-spacX*2, theStringSize.height)];
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.numberOfLines = 0;
    showLabel.text = message;
    showLabel.textColor = [UIColor whiteColor];
    showLabel.backgroundColor = [UIColor clearColor];
    showLabel.font = showFont;
    [showView addSubview:showLabel];
    
    // 动画
    __block UIView *tempView = showView;
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [tempView removeFromSuperview];
        tempView = nil;
    }];
    CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    keyAnim.values = @[@0,@1,@1,@0];
    keyAnim.keyTimes = @[@0,@0.1,@0.9,@1];
    keyAnim.duration = 2;
    keyAnim.repeatCount = 1;
    [showView.layer addAnimation:keyAnim forKey:nil];
    [CATransaction commit];
    
}

+ (void)showMessage:(NSString *)message {
    
    [[self class] showMessage:message inView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showLoading:(NSString *)message {
    
    // 可能使用者不清楚重复使用了，那就先删除旧的，再出现新的
    [self dissLoading];
    
    BOOL isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    CGFloat showW = isPad?200:150;
    CGFloat showH = isPad?45:25;
    CGFloat spacX = isPad?10:10;
    CGFloat activityW = 20;
    
    UIFont *showFont = [UIFont systemFontOfSize:isPad?24:16];
    CGSize theStringSize = [message boundingRectWithSize:CGSizeMake(showW-spacX*2-activityW, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: showFont} context:nil].size;
    
    if (theStringSize.height < showH) {
        theStringSize.height = showH;
    }
    
    UIView *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(keyWindow.frame), CGRectGetHeight(keyWindow.frame))];
    bgView.alpha = 0;
    bgView.tag = kMMC_AlertLoading_Tag;
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    if (message.length > 0) {
        
    } else {
        showW = theStringSize.height + spacX * 2;
    }
    
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showW, theStringSize.height + spacX * 2)];
    showView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    showView.layer.cornerRadius = isPad?10:7;
    showView.layer.masksToBounds = YES;
    showView.center = CGPointMake(CGRectGetWidth(keyWindow.frame)/2, CGRectGetHeight(keyWindow.frame)/2);
    [bgView addSubview:showView];
    
    // 内容
    if (message.length > 0) {
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(spacX+activityW, spacX, showW-spacX*2-activityW, theStringSize.height)];
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.numberOfLines = 0;
        showLabel.text = message;
        showLabel.textColor = [UIColor whiteColor];
        showLabel.backgroundColor = [UIColor clearColor];
        showLabel.font = showFont;
        [showView addSubview:showLabel];
    }
    
    // 状态
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    if (message.length > 0) {
        activityView.center = CGPointMake(spacX+activityW/2, showView.frame.size.height/2);
    } else {
        activityView.center = CGPointMake(showView.frame.size.width/2.0f, showView.frame.size.height/2.0f);
    }
    
    [activityView startAnimating];
    [showView addSubview:activityView];
    
    // 动画
    [UIView animateWithDuration:0.2 animations:^{
        bgView.alpha = 1;
    }];
}

+ (void)dissLoading {
    if (pthread_main_np()) {
        UIView *tempView = [[UIApplication sharedApplication].keyWindow viewWithTag:kMMC_AlertLoading_Tag];
        [tempView removeFromSuperview];
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            UIView *tempView = [[UIApplication sharedApplication].keyWindow viewWithTag:kMMC_AlertLoading_Tag];
            [tempView removeFromSuperview];
        });
    }
}

@end
