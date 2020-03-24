//
//  TcaishiDB.m
//  FirstDemo
//
//  Created by edward on 2020/3/24.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "TcaishiDB.h"
#import "T_CS_Entity.h"
@interface TcaishiDB()
@property(nonatomic,strong)Fmdbtool *maindb;
@property(nonatomic,strong)T_CS_Entity *t_cs_entity;
@end

static TcaishiDB *caishidb;

@implementation TcaishiDB

- (Fmdbtool *)maindb
{
    if (!_maindb) {
        Fmdbtool *db = [Fmdbtool GetInstance];
        _maindb = db;
    }
    return _maindb;
}
+ (instancetype)alloc
{
    if(caishidb)
    {
        NSException *ecs = [NSException exceptionWithName:@"error" reason:@"can not create a danli" userInfo:nil];
        [ecs raise];
    }
    return [super alloc];
}
+(instancetype)GetInstance
{
    if(!caishidb)
    {
        caishidb = [[TcaishiDB alloc]init];
    }
    return caishidb;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.maindb CreateTable:@"T_caishi" SQL:@"CREATE TABLE IF NOT EXISTS T_caishi (c_id varchar(50) PRIMARY KEY,c_name varchar(50)  NULL, c_guige varchar(50)  NULL,c_jinhuo float NULL,c_shouhuo float NULL,c_shuliang float NULL)"];
    }
    return self;
}
-(NSArray<T_CS_Entity *> *)GetData:(NSDictionary *)parms
{
    NSMutableArray<T_CS_Entity *> *arr = [[NSMutableArray alloc]init];
    arr = (NSMutableArray<T_CS_Entity *> *)[self.maindb serchTable:@"T_caishi" argmes:parms];
    return [arr copy];
}
-(void)InstallData:(NSArray<T_CS_Entity *>*)arr completed:(void (^)(BOOL,NSString *))com
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block int errnum = 0;
        [arr enumerateObjectsUsingBlock:^(T_CS_Entity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj.c_id == nil)
            {
                obj.c_id = [[NSUUID UUID] UUIDString];
                [self.maindb insertWithTableByQueue:@"T_caishi" argmes:[obj dicFromObject:obj] com:^(BOOL * _Nonnull result) {
                    if(!result)
                    {
                        errnum++;
                    }
                }];
            }else
            {
               //TODO:编写更新
            }
            
        }];
        if(errnum > 0)
        {
            com(NO,@"插入失败");
        }else{
            com(YES,@"插入成功");
        }
    });
}

@end
