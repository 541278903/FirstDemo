//
//  YYKBaseCollectionView.h
//  YYKPodLib_Sec
//
//  Created by Shenzhi on 2020/5/26.
//  Copyright © 2020 edward. All rights reserved.
//

#import "YYKView.h"
@class YYKBaseCollectionViewModel;
#import "YYKBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^setCell) (YYKBaseCollectionViewCell *cell,YYKBaseCollectionViewModel *model);

@interface YKCollectionView : YYKView

@property(nonatomic,copy) NSString *cellName;
@property(nonatomic,copy) setCell setThisCell;

@property(nonatomic,strong) NSMutableArray *itemArr;

- (instancetype)initWithFrame:(CGRect)frame AndCellName:(NSString *)cellname;

@end

@interface YYKBaseCollectionViewModel : YYKViewModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageStr;


//@property(nonatomic,copy)succ succeff;
@end
NS_ASSUME_NONNULL_END
