//
//  YKBannerViewCell.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/9/15.


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YKBannerViewCell : UICollectionViewCell
-(void)loadViewModel:(NSString *)imageName indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
