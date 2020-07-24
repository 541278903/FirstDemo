//
//  YKNetWorking.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/21.
//  Copyright © 2020 edward. All rights reserved.
//

//#import ".h"

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>

#define get(urlStr) url(urlStr).method(YKNetworkRequestMethodGET)
#define post(urlStr) url(urlStr).method(YKNetworkRequestMethodPOST)
#define put(urlStr) url(urlStr).method(YKNetworkRequestMethodPUT)
#define patch(urlStr) url(urlStr).method(YKNetworkRequestMethodPATCH)
#define delete(urlStr) url(urlStr).method(YKNetworkRequestMethodDELETE)

#define GET(urlStr,...)       url(urlStr).method(YKNetworkRequestMethodGET).params(NSDictionaryOfVariableBindings(__VA_ARGS__))
#define POST(urlStr,...)      url(urlStr).method(YKNetworkRequestMethodPOST).params(NSDictionaryOfVariableBindings(__VA_ARGS__))
#define PUT(urlStr,...)       url(urlStr).method(YKNetworkRequestMethodPUT).params(NSDictionaryOfVariableBindings(__VA_ARGS__))
#define DELETE(urlStr,...)    url(urlStr).method(YKNetworkRequestMethodPATCH).params(NSDictionaryOfVariableBindings(__VA_ARGS__))
#define PATCH(urlStr,...)     url(urlStr).method(YKNetworkRequestMethodDELETE).params(NSDictionaryOfVariableBindings(__VA_ARGS__))

#define kNoCacheErrorCode -10992

typedef NS_ENUM(NSInteger, YKNetworkRequestMethod) {
    YKNetworkRequestMethodGET                  = 0,
    YKNetworkRequestMethodPOST,
    YKNetworkRequestMethodPUT,
    YKNetworkRequestMethodPATCH,
    YKNetworkRequestMethodDELETE,
};

NS_ASSUME_NONNULL_BEGIN

@interface YKNetWorking : NSObject
/** 上传/下载进度 */
@property (nonatomic, copy,readonly) void(^progressBlock)(float progress);
/** 请求地址 */
@property (nonatomic, copy,readonly) NSString *urlStr;

- (YKNetWorking * (^)(YKNetworkRequestMethod metohd))method;

- (YKNetWorking * (^)(NSString *url))url;

- (YKNetWorking * (^)(NSDictionary *params))params;

- (YKNetWorking * (^)(NSData *data,NSString *fileName,NSString *mimeType))uploadData;

/** 文件上传/下载进度 */
- (YKNetWorking * (^)(void(^handleProgress)(float progress)))progress;

- (RACSignal *)executeSignal;
@end


NS_ASSUME_NONNULL_END
