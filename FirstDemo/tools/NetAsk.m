//
//  NetAsk.m
//  FirstDemo
//
//  Created by edward on 2019/11/22.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "NetAsk.h"
#import "GDataXMLNode.h"
#import <AFNetworking/AFNetworking.h>
//#import "PrefixHeader.pch"
@interface NetAsk()
@property(nonatomic,strong)AFNetworkReachabilityManager *AfManager;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end
static NetAsk *netasking = nil;
@implementation NetAsk

+(instancetype)GetInstance
{
    //单例
    if(!netasking)
    {
        netasking = [[NetAsk alloc]init];
    }
    return netasking;
}
+ (instancetype)alloc{
    if(netasking){
        NSException *ecs = [NSException exceptionWithName:@"错误" reason:@"can not create a danli" userInfo:NULL];
        [ecs raise];
    }
    return [super alloc];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化网络请求管理器manager
        self.AfManager = [AFNetworkReachabilityManager sharedManager];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //设置参数类型ContentTypes，在后面的array中添加形式即可，最终会转成nsset
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain",@"text/xml"]];
    }
    return self;
}


//POST请求
-(void)POST:(NSString *)URL parameters:(id)parameters isXML:(BOOL)isXML resultcom:(void (^)(NSDictionary *bl))comp{
    [self.manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = nil;
        if(isXML)
        {
            result = [self GetNodelist:responseObject];
        }else
        {
            result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }
        //转成JSON
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        comp(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.debugDescription);
    }];
}
//GET请求
-(void)GET:(NSString *)URL parameters:(id)parameters isXML:(BOOL)isXML resultcom:(void (^)(NSDictionary *bl))comp{
    [self.manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = nil;
        if(isXML)
        {
            result = [self GetNodelist:responseObject];
        }else
        {
            result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }
        //转成JSON
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        comp(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.debugDescription);
    }];
}

-(NSString *)GetNodelist:(NSData *)xmlstring{
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlstring error:nil];
    GDataXMLElement *rootXMLElement = [doc rootElement];
    NSString* xmlresult = [rootXMLElement stringValue];
    return xmlresult;
}
- (AFHTTPSessionManager *)manager{
    if(!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

-(void)IsNetWorking
{
    [self.AfManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"wilan");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"wifi");
                break;
            default:
                break;
        }
    }];
    [self.AfManager startMonitoring];
}
@end
