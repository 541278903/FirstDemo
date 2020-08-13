//
//  YKNetWorking.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/21.
//  Copyright © 2020 edward. All rights reserved.
//

#import "YKNetWorking.h"
#import "YKNetWorkingRequest.h"
#import <ReactiveObjC/ReactiveObjC.h>


@interface YKNetWorking()

@property(nonatomic,strong)AFNetworkReachabilityManager *AfManager;
@property(nonatomic,strong)AFHTTPSessionManager *manager;

/** 上传/下载进度 */
@property (nonatomic, copy) void(^progressBlock)(float progress);

/** 请求地址 */
@property (nonatomic, copy) NSString *urlStr;
@property(nonatomic,strong) NSMutableDictionary *param;
@property(nonatomic,copy)NSString *methodStr;

@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;
@end

@implementation YKNetWorking
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.AfManager = [AFNetworkReachabilityManager sharedManager];
        
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //设置参数类型ContentTypes，在后面的array中添加形式即可，最终会转成nsset
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain",@"text/xml",@"application/octet-stream",@"multipart/form-data"]];
        
    }
    return self;
}


- (YKNetWorking * _Nonnull (^)(YKNetworkRequestMethod))method
{
    return ^YKNetWorking *(YKNetworkRequestMethod method){
        switch (method) {
            case YKNetworkRequestMethodGET:
                self.methodStr = @"GET";
                break;
            case YKNetworkRequestMethodPOST:
                self.methodStr = @"POST";
                break;
            case YKNetworkRequestMethodDELETE:
                self.methodStr = @"DELETE";
                break;
            case YKNetworkRequestMethodPUT:
                self.methodStr = @"PUT";
                break;
            case YKNetworkRequestMethodPATCH:
                self.methodStr = @"PATCH";
                break;
            default:
                self.methodStr = @"GET";
                break;
        }
        return self;
    };
}
- (YKNetWorking * _Nonnull (^)(NSString * _Nonnull))url
{
    return ^YKNetWorking *(NSString *url){
        
        NSString *utf8Url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        
        self.urlStr = utf8Url;
        
        return self;
    };
}
- (YKNetWorking * _Nonnull (^)(NSDictionary * _Nonnull))params
{
    return ^YKNetWorking *(NSDictionary *params){
        self.param = [params copy];
        return self;
    };
}
- (YKNetWorking * _Nonnull (^)(NSData * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))uploadData
{
    return ^YKNetWorking *(NSData *data,NSString *filename,NSString * mimeType){
        
        return self;
    };
}
- (YKNetWorking * _Nonnull (^)(void (^ _Nonnull)(float)))progress
{
    return ^YKNetWorking *(void(^progressBlock)(float progress)) {
        self.progressBlock = progressBlock;
        return self;
    };
}
- (RACSignal *)executeSignal
{
    @weakify(self);
    RACSignal *singal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        [[self.manager dataTaskWithHTTPMethod:self.methodStr URLString:self.urlStr parameters:self.param headers:nil uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"🔥:%f",downloadProgress.fractionCompleted);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error.debugDescription);
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }] resume];
        self.methodStr = nil;
        self.urlStr = nil;
        self.param = nil;
        return nil;
    }];
    return singal;
}
#pragma mark get/set
- (AFHTTPSessionManager *)manager{
    if(!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSMutableDictionary *)param
{
    if(!_param)
    {
        NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
        _param = mdic;
    }
    return _param;
}
@end
