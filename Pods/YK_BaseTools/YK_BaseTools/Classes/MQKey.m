//
//  MQKey.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/17.
//  Copyright © 2020 edward. All rights reserved.
//

#import "MQKey.h"

@interface MQKey()
@property(nonatomic,strong) NSMutableArray *keys;
@end

@implementation MQKey


- (instancetype)initWithKeys:(NSArray *)arr
{
    self = [super init];
    if (self) {
        self.keys = [arr mutableCopy];
        [self.keys addObject:@"*"];
    }
    return self;
}
+(MQKey *)CreateMqKey:(NSArray *)keys
{
    return [[MQKey alloc]initWithKeys:keys];;
}
-(NSString *)GetMqKeyStr
{
    return [self.keys componentsJoinedByString:@"."];
}
-(NSArray *)GetMqKeyArr
{
    return [self.keys copy];
}
- (MQKey * _Nonnull (^)(MQKey * _Nonnull roudingkeys))JoinKey
{
    return ^MQKey *(MQKey *roudingkeys){
        NSMutableArray *arr = [roudingkeys.keys mutableCopy];
        [arr removeObject:@"*"];
        arr = [[arr arrayByAddingObjectsFromArray:[self.keys copy]] mutableCopy];
        self.keys = arr;
        return self;
    };
}
- (NSMutableArray *)keys
{
    if(!_keys)
    {
        NSMutableArray *x = [[NSMutableArray alloc]init];
        _keys = x;
    }
    return _keys;
}

@end
