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
-(BOOL)insertWithTable:(NSString *)tablename argmes:(NSArray *)dic
{
    [self CreateTable];
    NSMutableString *arg = [[NSMutableString alloc]initWithFormat:@"("];
    NSMutableString *value = [[NSMutableString alloc]initWithFormat:@"("];;
    for (int i = 0; i<=dic.count-1; i++) {
        NSDictionary *d = dic[i];
        [arg appendString:d[@"key"]];
        [value appendFormat:@"'%@'",d[@"value"]];
        if(i < dic.count-1)
        {
            [arg appendString:@","];
            [value appendString:@","];
        }
        else{
            [arg appendString:@")"];
            [value appendString:@")"];
        }
    }
    NSString *strSql = [NSString stringWithFormat:@"insert into %@ %@ values %@",tablename,arg,value];
    return [self.db executeUpdate:strSql];
}
-(NSArray *)serchTable:(NSString *)tablename argmes:(NSArray *)dic
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    NSMutableString *serch = [[NSMutableString alloc] init];
    for (NSDictionary *d in dic) {
        if(!d)
        {
            break;
        }
        [serch appendFormat:@"and t.%@ = '%@'",d[@"key"],d[@"value"]];
    }
    NSString *strSql = [NSString stringWithFormat:@"select * from %@ t where 1=1 %@",tablename,serch];
    FMResultSet *rs = [self.db executeQuery:strSql];
    while ([rs next]) {
        NSMutableDictionary *ad = [[NSMutableDictionary alloc]init];
        for (NSString *key in rs.resultDictionary.allKeys) {
            [ad setObject:rs.resultDictionary[key] forKey:key];
        }
        [result addObject:ad];
        
    }
//    NSLog(@"%@",result);
    return result;
}




@end
