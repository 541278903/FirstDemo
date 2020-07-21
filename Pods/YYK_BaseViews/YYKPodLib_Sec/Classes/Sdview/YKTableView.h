//
//  YKTableView.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/26.
//  Copyright © 2020 edward. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YKTableView : UIView

@end

@interface YKTableViewConfig :NSObject


//cell数组
@property(nonatomic,strong) NSMutableArray *cells;

//数据源数组
//@property(nonatomic,strong) NSMutableArray *itemarr;
@property(nonatomic,strong) NSMutableDictionary *itemdic;


@end

NS_ASSUME_NONNULL_END
