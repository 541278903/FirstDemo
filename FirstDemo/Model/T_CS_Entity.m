//
//  T_CS_Entity.m
//  FirstDemo
//
//  Created by edward on 2020/3/24.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "T_CS_Entity.h"
@interface T_CS_Entity()

@end

@implementation T_CS_Entity

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"<#format string#>", <#arguments#>];
//}
- (NSString *)description
{
   return [NSString stringWithFormat:@"{\"c_name\":\"%@\",\"c_guige\":\"%@\",\"c_jinhuo\":\"%@\",\"c_shouhuo\":\"%@\",\"c_shuliang\":\"%@\"}",self.c_name,self.c_guige,self.c_jinhuo,self.c_shouhuo,self.c_shuliang];

}
-(void)update:(NSString *)entity
{
    [[NetAsk GetInstance]POST:@"http://106.55.12.108/TServer.asmx/SaveMenuData" parameters:@{@"entity":entity} isXML:YES resultcom:^(id  _Nullable bl) {
        MLog(@"%@",bl);
    }];
}
@end
