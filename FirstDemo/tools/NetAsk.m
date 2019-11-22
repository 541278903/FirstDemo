//
//  NetAsk.m
//  FirstDemo
//
//  Created by edward on 2019/11/22.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "NetAsk.h"
#import <AFNetworking/AFNetworking.h>
@interface NetAsk()
@property(nonatomic,strong)AFNetworkReachabilityManager *AfManager;
@end
static NetAsk *netasking = nil;
@implementation NetAsk

+(instancetype)GetInstance
{
    if(!netasking)
    {
        netasking = [[NetAsk alloc]init];
    }
    return netasking;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.AfManager = [AFNetworkReachabilityManager sharedManager];
    }
    return self;
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
                NSLog(@"wilan");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
            default:
                break;
        }
    }];
    [self.AfManager startMonitoring];
}


@end
