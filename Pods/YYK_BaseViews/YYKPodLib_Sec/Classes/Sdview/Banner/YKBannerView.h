//
//  YMNewBannerView.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/9/15.


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class YKBannerView;
NS_ASSUME_NONNULL_BEGIN

@protocol YKBannerViewDelegate <NSObject>

@required
-(void)clipBanner:(YKBannerView *)bannerView andMessage:(NSString *)message;

@end


@interface YKBannerView : UIView

@property (nonatomic, copy) NSArray *images;

@property(nonatomic,weak,nullable) id<YKBannerViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
