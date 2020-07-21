//
//  YKCollection.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/25.
//  Copyright © 2020 edward. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKCollectionConfig;

NS_ASSUME_NONNULL_BEGIN

@interface YKCollection : UIView

+ (instancetype)collectionWithFrame:(CGRect)frame setConfig:(void(^ __nullable)(YKCollectionConfig *config))cellname andSetCell:(void(^ __nonnull)(id cell,NSIndexPath *indexPath))setCell andDoThing:(void(^ __nonnull)(NSIndexPath *indexPath))dothing;

@end

@interface YKCollectionConfig : NSObject

//按钮图像
@property(nonatomic,strong) UIImage * image;
//标签名称
@property(nonatomic,copy) NSString * titleName;

@property(nonatomic,copy) NSString *cellname;
@property(nonatomic,strong) NSMutableArray * itemarr;

@property(nonatomic,assign) NSInteger numberofcell;


@end

NS_ASSUME_NONNULL_END
