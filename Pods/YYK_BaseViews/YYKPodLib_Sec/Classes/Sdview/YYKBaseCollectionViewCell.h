//
//  YYKBaseCollectionViewCell.h
//  YYKPodLib_Sec
//
//  Created by Shenzhi on 2020/5/26.
//  Copyright © 2020 edward. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYKBaseCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
