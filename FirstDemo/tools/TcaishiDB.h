//
//  TcaishiDB.h
//  FirstDemo
//
//  Created by edward on 2020/3/24.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "Fmdbtool.h"
@class T_CS_Entity;

NS_ASSUME_NONNULL_BEGIN

@interface TcaishiDB:NSObject
+(instancetype)GetInstance;
-(NSArray<T_CS_Entity *> *)GetData:(NSDictionary *)parms;
-(void)InstallData:(NSArray<T_CS_Entity *>*)arr completed:(void (^)(BOOL,NSString *))com;
@end

NS_ASSUME_NONNULL_END
