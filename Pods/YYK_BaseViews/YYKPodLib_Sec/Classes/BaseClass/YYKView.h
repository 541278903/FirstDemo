//
//  YYKView.h
//  YYKPodLib_Sec
//
//  Created by Shenzhi on 2020/5/26.
//  Copyright © 2020 edward. All rights reserved.
//

#import <UIKit/UIKit.h>


//#import "YYKViewModel.h"
#import "YYKViewModel.h"
//@class YYKViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface YYKView : UIView

//@property(nonatomic,strong) YYKViewModel *viewModel;
//- (instancetype)initWithViewModel:(YYKViewModel *)viewModel;
- (void)loadDataWithViewModel:(YYKViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
