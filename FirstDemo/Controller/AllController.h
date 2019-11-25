//
//  AllController.h
//  FirstDemo
//
//  Created by edward on 2019/11/25.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllController : NSObject

@property(nonatomic,strong)NSString *ConName;
@property(nonatomic,strong)UIViewController *ConView;
- (instancetype)initWithName:(NSString *)name  Con:(UIViewController *)con;
@end

NS_ASSUME_NONNULL_END
