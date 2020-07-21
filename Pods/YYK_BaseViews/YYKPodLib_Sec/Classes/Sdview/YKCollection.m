//
//  YKCollection.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/25.
//  Copyright © 2020 edward. All rights reserved.
//

#import "YKCollection.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


typedef void(^DoThing)(NSIndexPath *indexPath);
typedef void(^SetCell)(id cell,NSIndexPath *indexPath);
@interface YKCollection()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,copy) DoThing dothing;
@property(nonatomic,copy) SetCell setCell;
@property(nonatomic,strong) YKCollectionConfig *config;
@end

@implementation YKCollection


+ (instancetype)collectionWithFrame:(CGRect)frame setConfig:(void(^ __nullable)(YKCollectionConfig *config))cellname andSetCell:(void(^ __nonnull)(id cell,NSIndexPath *indexPath))setCell andDoThing:(void(^ __nonnull)(NSIndexPath *indexPath))dothing
{
    
    return [[YKCollection alloc]initWithFrame:frame setConfig:cellname andSetCell:setCell andDoThing:dothing];
}
- (instancetype)initWithFrame:(CGRect)frame setConfig:(void(^ __nonnull)(YKCollectionConfig *config))cellname andSetCell:(void(^ __nonnull)(id cell,NSIndexPath *indexPath))setCell andDoThing:(void(^ __nonnull)(NSIndexPath *indexPath))dothing
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if(cellname)
        {
            cellname(self.config);
        }
        self.setCell = setCell;
        self.dothing = dothing;
        [self setup];
    }
    return self;
}
-(void)setup
{
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(54, 80);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = floorf((SCREEN_WIDTH-30*2-54*4)/3.0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    if (@available(iOS 11.0, *)) {
        //就算你的ScrollView超出了safeAreaInsets，系统不会对你的scrollView.adjustedContentInset做任何事情
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = UIColor.lightGrayColor;
    if(!self.config.cellname)
    {
        self.config.cellname = @"YYKBaseCollectionViewCell";
    }

    [collectionView registerNib:[UINib nibWithNibName:self.config.cellname bundle:nil] forCellWithReuseIdentifier:self.config.cellname];
    [self addSubview:collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numberofcell;
    if(self.config)
    {
        numberofcell = self.config.itemarr.count;
    }else
    {
        numberofcell = 0;
    }
    return numberofcell;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.config.cellname forIndexPath:indexPath];
    if(self.setCell)
    {
        self.setCell(cell, indexPath);
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.dothing)
    {
        self.dothing(indexPath);
    }else
    {
        NSLog(@"/*******请给config设置点击动作*******/");
    }
}

- (YKCollectionConfig *)config
{
    if(!_config)
    {
        YKCollectionConfig *x = [[YKCollectionConfig alloc]init];
        _config = x;
    }
    return _config;
}


@end

@implementation YKCollectionConfig

- (UIImage *)image
{
    if(!_image)
    {
        UIImage * x = [[UIImage alloc]init];
        _image = x;
    }
    return _image;
}



@end
