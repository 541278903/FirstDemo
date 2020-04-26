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
@property(nonatomic,strong)FMDatabaseQueue *dbqueue;

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
+ (instancetype)alloc{
    if(fmdbtool){
        NSException *ecs = [NSException exceptionWithName:@"error" reason:@"can not create a danli" userInfo:nil];
        [ecs raise];
    }
    return [super alloc];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self.db open]) {
            // do something
            
            NSLog(@"db is opened dbpath : %@",self.filePath);
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
- (FMDatabaseQueue *)dbqueue
{
    if(!_dbqueue)
    {
        _dbqueue = [FMDatabaseQueue databaseQueueWithPath:self.filePath];
    }
    return _dbqueue;
}
-(BOOL)CreateTable:(NSString *)TableName SQL:(NSString *)CreatTableSQL
{
    NSString *haveTable = [NSString stringWithFormat:@"select count(*) as count  from sqlite_master where type='table' and name = '%@'",TableName];
    FMResultSet *rs = [self.db executeQuery:haveTable];
    while ([rs next]) {
        int count = [rs intForColumn:@"count"];
        if(count >= 1)
        {
            return YES;
        }else
        {
            return [self.db executeUpdate:CreatTableSQL];
        }
    }
    return NO;
}

-(void)insertWithTableByQueue:(NSString *)tablename argmes:(NSDictionary *)dic com:(void (^)(BOOL))com
{
    if(tablename == nil)
    {
        com(NO);
    }
    NSMutableArray *arg = [[NSMutableArray alloc]init];
    NSMutableArray *values = [[NSMutableArray alloc]init];
    for (NSString *key in dic.allKeys) {
        if(dic[key] == nil)
        {
            continue;
        }
        [arg addObject:key];
        [values addObject:[NSString stringWithFormat:@"'%@'",dic[key]]];
    }
    NSString *argstr = [NSString stringWithFormat:@"(%@)",[arg componentsJoinedByString:@","]];
    NSString *valuesstr = [NSString stringWithFormat:@"(%@)",[values componentsJoinedByString:@","]];
    NSString *strSql = [NSString stringWithFormat:@"insert into %@ %@ values %@",tablename,argstr,valuesstr];
    [self.dbqueue inDatabase:^(FMDatabase * _Nonnull dbd) {
        if ([dbd executeUpdate:strSql]) {
            com(YES);
        }else
        {
            com(NO);
        }
    }];
}

-(BOOL)insertWithTable:(NSString *)tablename argmes:(NSDictionary *)dic
{
    if(tablename == nil){
        return NO;
    }
        NSMutableArray *arg = [[NSMutableArray alloc]init];
        NSMutableArray *values = [[NSMutableArray alloc]init];
        for (NSString *key in dic.allKeys) {
            if(dic[key] == nil)
            {
                continue;
            }
            [arg addObject:key];
            [values addObject:[NSString stringWithFormat:@"'%@'",dic[key]]];
        }
        NSString *argstr = [NSString stringWithFormat:@"(%@)",[arg componentsJoinedByString:@","]];
        NSString *valuesstr = [NSString stringWithFormat:@"(%@)",[values componentsJoinedByString:@","]];
        NSString *strSql = [NSString stringWithFormat:@"insert into %@ %@ values %@",tablename,argstr,valuesstr];
        return [self.db executeUpdate:strSql];
}
-(BOOL)updateWithTable:(NSString *)tablename argmes:(NSDictionary *)dic params:(NSString *)par parValue:(NSString *)value
{
    if(par == nil || value == nil)
    {
        return NO;
    }
    NSMutableArray *arg = [[NSMutableArray alloc]init];
    for (NSString *key in dic.allKeys) {
        if([key isEqualToString:par])
        {
            continue;
        }
        if(dic[key] == nil)
        {
            continue;
        }
        [arg addObject:[NSString stringWithFormat:@" %@ = '%@' ",key,dic[key]] ];
    }
    NSString *argstr = [arg componentsJoinedByString:@","];
    NSString *strSql = [NSString stringWithFormat:@"update %@ set %@ where %@ = '%@'",tablename,argstr,par,value];
    return [self.db executeUpdate:strSql];
}
- (void)updateWithTableByQueue:(NSString *)tablename argmes:(NSDictionary *)dic params:(NSString *)par parValue:(NSString *)value com:(void (^)(BOOL))com{
    if(par == nil || value == nil || tablename == nil)
    {
        com(NO);
    }
    NSMutableArray *arg = [[NSMutableArray alloc]init];
    for (NSString *key in dic.allKeys) {
        if([key isEqualToString:par])
        {
            continue;
        }
        if(dic[key] == nil)
        {
            continue;
        }
        [arg addObject:[NSString stringWithFormat:@" %@ = '%@' ",key,dic[key]] ];
    }
    NSString *argstr = [arg componentsJoinedByString:@","];
    NSString *strSql = [NSString stringWithFormat:@"update %@ set %@ where %@ = '%@'",tablename,argstr,par,value];
    [self.dbqueue inDatabase:^(FMDatabase * _Nonnull dbd) {
        if ([dbd executeUpdate:strSql]) {
            com(YES);
        }else
        {
            com(NO);
        }
    }];
}

/// 查询值
/// @param tablename 表名
/// @param dic 参数 如@{@"id":@"2",@"name":@"clasdjfioeow"};
-(NSArray *)serchTable:(NSString *)tablename argmes:(NSDictionary *)dic
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    NSMutableString *serch = [[NSMutableString alloc] init];
    for (NSString *key in dic) {
        if(!dic) break;
        [serch appendFormat:@" and t.%@ = '%@' ",key,dic[key]];
    }
    NSString *strSql = [NSString stringWithFormat:@"select * from %@ t where 1=1 %@",tablename,serch];
    FMResultSet *rs = [self.db executeQuery:strSql];
    if(!rs) return nil;
    while ([rs next]) {
        NSMutableDictionary *ad = [[NSMutableDictionary alloc]init];
        for (NSString *key in rs.resultDictionary.allKeys) {
            [ad setObject:rs.resultDictionary[key] forKey:key];
        }
        [result addObject:ad];
        
    }
    return result;
}

/// 根据sql查询数据库
/// @param sql  SQL语句
-(NSArray *)serchBySql:(NSString *)sql
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    FMResultSet *rs = [self.db executeQuery:sql];
    if(!rs) return nil;
    while ([rs next]) {
        NSMutableDictionary *ad = [[NSMutableDictionary alloc]init];
        for (NSString *key in rs.resultDictionary.allKeys) {
            [ad setObject:rs.resultDictionary[key] forKey:key];
        }
        [result addObject:ad];
    }
    return result;
}

/// 执行操作语句
/// @param sql  SQL语句
-(BOOL)ExecSQL:(NSString *)sql
{
    return [self.db executeUpdate:sql];
}


- (void)dealloc
{
    if(![self.db close]){
        NSException *ecs = [NSException exceptionWithName:@"error" reason:@"can not close db" userInfo:nil];
        [ecs raise];
    }
}

- (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
        {
            [dic setObject:value forKey:name];

        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //字典或字典
            [dic setObject:[self arrayOrDicWithObject:(NSArray*)value] forKey:name];

        } else if (value == nil || value == NULL) {
            //null
//            [dic setObject:nil forKey:name];//这行可以注释掉?????
            continue;

        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
//        [dic setObject:value forKey:name];
    }
    
    return [dic copy];
}
- (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
                
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
        
        return [array copy];
        
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        //字典
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
                
            } else {
                //model
                [dic setObject:[self dicFromObject:object] forKey:key];
            }
        }
        
        return [dic copy];
    }
    
    return [NSNull null];
}

@end
