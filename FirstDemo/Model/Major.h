//
//  Major.h
//  FirstDemo
//
//  Created by edward on 2020/3/7.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Major : NSObject<NSCoding>  //实现自定义对象归档要遵守NSCoding协议
@property(nonatomic,copy)NSString *sax;
//@property()
@end

NS_ASSUME_NONNULL_END
