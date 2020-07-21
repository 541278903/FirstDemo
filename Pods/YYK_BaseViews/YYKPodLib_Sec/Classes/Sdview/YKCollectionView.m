//
//  YYKBaseCollectionView.m
//  YYKPodLib_Sec
//
//  Created by Shenzhi on 2020/5/26.
//  Copyright © 2020 edward. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YKCollectionView.h"
#import "UIView+YYK.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

@interface YKCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@end


@implementation YKCollectionView

- (instancetype)initWithFrame:(CGRect)frame AndCellName:(NSString *)cellname
{
    self = [self initWithFrame:frame];
    if (self) {
        self.cellName = cellname;
        [self setup];
    }
    return self;
}


-(void)setup{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(54, 80);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = floorf((SCREEN_WIDTH-30*2-54*4)/3.0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    if (@available(iOS 11.0, *)) {
        //就算你的ScrollView超出了safeAreaInsets，系统不会对你的scrollView.adjustedContentInset做任何事情
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    collectionView.dataSource = self;
    collectionView.backgroundColor = UIColor.whiteColor;
    collectionView.contentInset = UIEdgeInsetsMake(15, 30, 0, 30);
    //分别代表着上边界，左边界，底边界，右边界，扩展出去的值。
//    [collectionView registerNib:[self.cell defaultNib] forCellWithReuseIdentifier:[self.cell defaultIdentifier]];
    if(!self.cellName)
    {
        
        [collectionView registerNib:YYKBaseCollectionViewCell.defaultNib forCellWithReuseIdentifier:YYKBaseCollectionViewCell.defaultIdentifier];
    }else
    {
        [collectionView registerNib:[UINib nibWithNibName:self.cellName bundle:nil] forCellWithReuseIdentifier:self.cellName];
    }
    [self addSubview:collectionView];
}
- (void)loadDataWithViewModel:(YYKViewModel *)viewModel
{
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYKBaseCollectionViewCell *dcell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellName forIndexPath:indexPath];
    YYKBaseCollectionViewModel *itemModel = [self.itemArr objectAtIndex:indexPath.row];
    self.setThisCell(dcell, itemModel);
    return dcell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYKBaseCollectionViewModel *itemModel = [self.itemArr objectAtIndex:indexPath.row];
    NSLog(@"%@",itemModel.imageStr);
}
#pragma mark doDelegate

#pragma mark get/set
- (NSMutableArray *)itemArr
{
    if(!_itemArr)
    {
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}

- (NSString *)cellName
{
    if(!_cellName)
    {
        _cellName = @"YYKBaseCollectionViewCell";
    }
    return _cellName;
}

@end
@implementation YYKBaseCollectionViewModel


@end
