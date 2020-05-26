//
//  YYKViewModel.h
//  YYKPodLib_Sec
//
//  Created by Shenzhi on 2020/5/26.
//  Copyright © 2020 edward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
//#import <MJExtension/MJExtension.h>
NS_ASSUME_NONNULL_BEGIN

@interface YYKViewModel : NSObject
@property (nonatomic, strong) RACSubject<NSError *> *errorSubject;
@end

NS_ASSUME_NONNULL_END
