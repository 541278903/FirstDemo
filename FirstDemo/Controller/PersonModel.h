//
//  PersonModel.h
//  FirstDemo
//
//  Created by edward on 2020/3/3.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)int age;
-(void)shout;
-(void)instanceMethod1;
-(void)instanceMethod2;
@end

NS_ASSUME_NONNULL_END
