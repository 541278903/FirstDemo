//
//  MQManager.m
//  NavigationConOC
//
//  Created by Edward on 2019/9/24.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "MQManager.h"
#import <RMQClient/RMQClient.h>
@interface MQManager()<RMQConnectionDelegate>
@property (nonatomic,strong) RMQConnection *conn;
@property (nonatomic,weak) NSString *device;
@end
static MQManager *mainmanager = nil;
//所有 MQ 消息形式 https://www.rabbitmq.com/getstarted.html
@implementation MQManager
+(instancetype)GetInstance{
    if(!mainmanager)
    {
        //获取设备id
        NSString *uuid = [[NSUUID UUID] UUIDString];
        mainmanager = [[MQManager alloc]initWithDevice:uuid];
    }
    return mainmanager;
}
- (instancetype)initWithDevice:(NSString *)device
{
    self = [super init];
    if (self) {
        _device = device;
        self.conn = [[RMQConnection alloc] initWithUri:@"amqp://root:root@jxe9bfqtpi.52http.net:39301" delegate:self];
    }
    return self;
}
-(void)GetMsg{
    [self receiveLogsTopic:@[@"kern.*",@"test.*"]];
}
-(void)GetMsgWith:(NSArray *)routingKeys
{
    [self receiveLogsTopic:routingKeys];
}
-(void)SendMsg:(NSString *)msg{
    
    [self emitLogTopic:msg routingKey:[NSString stringWithFormat:@"test.%@",self.device]];
}

- (void)emitLogTopic:(NSString *)msg routingKey:(NSString *)routingKey {
//    [UIApplication sharedApplication].idleTimerDisabled = YES;
    RMQConnection *con = [[RMQConnection alloc] initWithUri:@"amqp://root:root@jxe9bfqtpi.52http.net:39301" delegate:self];
    [con start];
    id<RMQChannel> ch = [con createChannel];
    /** 创建交换器 */
    RMQExchange *x    = [ch topic:@"exchange"];
    [x publish:[msg dataUsingEncoding:NSUTF8StringEncoding] routingKey:routingKey];
    NSLog(@"Sent '%@'", msg);
    [con close];
}

-(void)receiveLogsTopic:(NSArray *)routingKeys{
    NSLog(@"Attempting to connect to local RabbitMQ broker");
    /** 创建连接 */
    [self.conn start];
    /** 创建信道 */
    id<RMQChannel> ch = [self.conn createChannel];
    /** 创建交换器 */
    RMQExchange *x    = [ch topic:@"exchange"];
    RMQQueue *q       = [ch queue:[NSString stringWithFormat:@"edward_%@",_device] options:RMQQueueDeclareExclusive];
    /** 绑定交换器 */
    for (NSString *routingKey in routingKeys) {
        [q bind:x routingKey:routingKey];
    }
    NSLog(@"Waiting for logs.");
    /** 订阅消息 */
    [q subscribe:^(RMQMessage * _Nonnull message) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertc = [UIAlertController alertControllerWithTitle:message.routingKey message:[[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ac = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertc addAction:ac];
            [[self topMostController] presentViewController:alertc animated:YES completion:nil];
        });
    }];
}
-(UIViewController *) topMostController {
  UIViewController*topController = [UIApplication sharedApplication].keyWindow.rootViewController;
  while(topController.presentedViewController){
    topController=topController.presentedViewController;
  }
  return topController;
}
-(void)dealloc{
    [self.conn close];
}



- (void)channel:(id<RMQChannel>)channel error:(NSError *)error {
    NSLog(@"1_channel::%@",error.localizedDescription);
}

- (void)connection:(RMQConnection *)connection disconnectedWithError:(NSError *)error {
    NSLog(@"2_connection::%@",error.localizedDescription);
}

- (void)connection:(RMQConnection *)connection failedToConnectWithError:(NSError *)error {
    NSLog(@"3_connecion::%@",error.localizedDescription);
}

- (void)recoveredConnection:(RMQConnection *)connection {
    NSLog(@"4_recoveredConnection::%@",connection.description);
}

- (void)startingRecoveryWithConnection:(RMQConnection *)connection {
    
    NSLog(@"5_startingRecoveryWithConnection::%@",connection.description);
}

- (void)willStartRecoveryWithConnection:(RMQConnection *)connection {
    
    NSLog(@"6_willStartRecoveryWithConnection::%@",connection.description);
}

@end
