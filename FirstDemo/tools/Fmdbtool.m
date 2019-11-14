//
//  Fmdbtool.m
//  FirstDemo
//
//  Created by edward on 2019/10/17.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "Fmdbtool.h"
#import <FMDB/FMDB.h>


@interface Fmdbtool()
@property(nonatomic,strong)NSString *filePath;
@property(nonatomic,strong)FMDatabase *db;

@end
static Fmdbtool *fmdbtool = nil;
@implementation Fmdbtool

- (NSString *)filePath
{
    if(!_filePath)
    {
        NSFileManager *filemanager = [NSFileManager defaultManager];
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *file = [NSString stringWithFormat:@"%@/data.db",docPath];
        if(![filemanager fileExistsAtPath:file])
        {
            //如果不存在则创建文件
            [filemanager createFileAtPath:file contents:nil attributes:nil];
        }
        _filePath = file;
    }
    return _filePath;
}
+(instancetype)GetInstance
{
    if(fmdbtool == nil)
    {
        fmdbtool = [[Fmdbtool alloc]init];
    }
    return fmdbtool;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self.db open]) {
            // do something
            NSLog(@"db is opened");
        } else {
            NSLog(@"fail to open database");
        }
    }
    return self;
}
- (FMDatabase *)db
{
    if(!_db)
    {
        _db = [FMDatabase databaseWithPath:self.filePath];
    }
    return _db;
}
-(BOOL)CreateTable
{
    NSString *haveTable = @"select count(*) as count  from sqlite_master where type='table' and name = 't_student'";
    FMResultSet *rs = [self.db executeQuery:haveTable];
    NSLog(@"rs.count ---- %d",[rs columnCount]);
    while ([rs next]) {
        int count = [rs intForColumn:@"count"];
        if(count >= 1)
        {
            return YES;
        }else
        {
            NSString *createTableSqlString = @"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text  NULL, age integer  NULL)";
            return [self.db executeUpdate:createTableSqlString];
        }
    }
    return NO;
}
/// 插入数据
/// @param tablename 表名
/// @param dic 插入的字段和值 如@{@"id":@"2",@"name":@"clasdjfioeow"};
-(BOOL)insertWithTable:(NSString *)tablename argmes:(NSDictionary *)dic
{
    [self CreateTable];
//    NSMutableString *arg = [[NSMutableString alloc]initWithFormat:@"("];
//    NSMutableString *value = [[NSMutableString alloc]initWithFormat:@"("];
    NSMutableArray *arg = [[NSMutableArray alloc]init];
    NSMutableArray *values = [[NSMutableArray alloc]init];
    for (NSString *key in dic.allKeys) {
        [arg addObject:key];
        [values addObject:[NSString stringWithFormat:@"'%@'",dic[key]]];
    }
    NSString *argstr = [NSString stringWithFormat:@"(%@)",[arg componentsJoinedByString:@","]];
    NSString *valuesstr = [NSString stringWithFormat:@"(%@)",[values componentsJoinedByString:@","]];
    NSString *strSql = [NSString stringWithFormat:@"insert into %@ %@ values %@",tablename,argstr,valuesstr];
    return [self.db executeUpdate:strSql];
    
}

/// 查询值
/// @param tablename 表名
/// @param dic 参数 如@{@"id":@"2",@"name":@"clasdjfioeow"};
-(NSArray *)serchTable:(NSString *)tablename argmes:(NSDictionary *)dic
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    NSMutableString *serch = [[NSMutableString alloc] init];
    for (NSString *key in dic) {
        if(!dic)
        {
            break;
        }
        [serch appendFormat:@" and t.%@ = '%@' ",key,dic[key]];
    }
    NSString *strSql = [NSString stringWithFormat:@"select * from %@ t where 1=1 %@",tablename,serch];
    FMResultSet *rs = [self.db executeQuery:strSql];
    if(!rs)
    {
        return nil;
    }
    while ([rs next]) {
        NSMutableDictionary *ad = [[NSMutableDictionary alloc]init];
        for (NSString *key in rs.resultDictionary.allKeys) {
            [ad setObject:rs.resultDictionary[key] forKey:key];
        }
        [result addObject:ad];
        
    }
    if(![rs next])
    {
        return nil;
    }
//    NSLog(@"%@",result);
    return result;
}

/// 根据sql查询数据库
/// @param sql  SQL语句
-(NSArray *)serchBySql:(NSString *)sql
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    FMResultSet *rs = [self.db executeQuery:sql];
    if(!rs)
    {
        return nil;
    }
    while ([rs next]) {
        NSMutableDictionary *ad = [[NSMutableDictionary alloc]init];
        for (NSString *key in rs.resultDictionary.allKeys) {
            [ad setObject:rs.resultDictionary[key] forKey:key];
        }
        [result addObject:ad];
    }
    NSLog(@"%@",result);
    return result;
}




@end
