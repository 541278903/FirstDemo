//
//  TcaishiDB.m
//  FirstDemo
//
//  Created by edward on 2020/3/24.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "TcaishiDB.h"
#import "T_CS_Entity.h"
#import <MJExtension/MJExtension.h>
//#def
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
        [self.maindb CreateTable:@"T_caishi" SQL:@"CREATE TABLE IF NOT EXISTS T_caishi (c_id varchar(50) PRIMARY KEY,c_name varchar(50)  NULL, c_guige varchar(50)  NULL,c_jinhuo varchar(50) NULL,c_shouhuo varchar(50) NULL,c_shuliang varchar(50) NULL)"];
    }
    return self;
}
-(NSArray<T_CS_Entity *> *)GetData:(NSDictionary *)parms
{
    @autoreleasepool {
        NSMutableArray<T_CS_Entity *> *arr = [[NSMutableArray alloc]init];
        NSArray *larr = [self.maindb serchTable:@"T_caishi" argmes:parms];
        arr = [T_CS_Entity mj_objectArrayWithKeyValuesArray:larr];
        return [arr copy];
    }
}
-(void)SetDataWithNetWork{
    [[NetAsk GetInstance]POST:@"http://106.55.12.108/TServer.asmx/GetAllData" parameters:nil isXML:YES resultcom:^(NSDictionary *  _Nullable bl) {
        NSArray *arr = bl[@"Menu"];
        NSMutableArray<T_CS_Entity *> *tcsarr = [[NSMutableArray alloc]init];
        for (id obj in arr) {
            T_CS_Entity *tcs = [[T_CS_Entity alloc]initWithDic:obj];
            [tcsarr addObject:tcs];
        }
        [self SyncData:tcsarr];
        
    }];
}
-(void)SyncData:(NSArray<T_CS_Entity *> *)formData{
    @autoreleasepool {
        NSArray<T_CS_Entity *> *localData = [self GetData:nil];
        NSMutableArray<T_CS_Entity *> *insertData = [[NSMutableArray alloc]init];
        NSMutableArray<T_CS_Entity *> *updateData = [[NSMutableArray alloc]init];
        NSMutableArray<T_CS_Entity *> *delData = [[NSMutableArray alloc]init];
        for (T_CS_Entity *fortcs in formData) {
            T_CS_Entity *loctcs;
            for (T_CS_Entity *localtcs in localData) {
               if([fortcs.c_name isEqualToString:localtcs.c_name] && [fortcs.c_guige isEqualToString:localtcs.c_guige]){
                   //本地存有相同的 则将这模型导入到更新数组中
                   loctcs = localtcs;
               }
            }
            if(loctcs == nil)
            {
                //本地没有 则将这模型导入到插入数组中   无论任何情况都插入了进去（bug）
                [insertData addObject:fortcs];
            }else
            {
                [updateData addObject:loctcs];
            }
        }
        for (T_CS_Entity *insertModel in insertData) {
            [self.maindb insertWithTableByQueue:@"T_caishi" argmes:[self.maindb dicFromObject:insertModel] com:^(BOOL result) {
                if(result)
                {
                    MLog(@"插入成功");
                }
            }];
        }
        for (T_CS_Entity *updateModel in updateData) {
            [self.maindb updateWithTableByQueue:@"T_caishi" argmes:[self.maindb dicFromObject:updateModel] params:@"c_id" parValue:updateModel.c_id com:^(BOOL result) {
                if(result)
                {
                    MLog(@"更新成功");
                }
            }];
        }
    }
    
}
-(void)InstallData:(NSArray<T_CS_Entity *>*)arr completed:(void (^)(BOOL,NSString *))com
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block int errnum = 0;
        [arr enumerateObjectsUsingBlock:^(T_CS_Entity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj.c_id == nil)
            {
                obj.c_id = [[NSUUID UUID] UUIDString];
                [self.maindb insertWithTableByQueue:@"T_caishi" argmes:[self.maindb dicFromObject:obj] com:^(BOOL result) {
                    if(!result)
                    {
                        errnum++;
                    }
                }];
            }else
            {
                [self.maindb updateWithTableByQueue:@"T_caishi" argmes:[self.maindb dicFromObject:obj] params:@"c_id" parValue:obj.c_id com:^(BOOL result) {
                    if(!result)
                    {
                        errnum++;
                    }
                }];
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
