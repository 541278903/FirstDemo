//
//  MQmanager.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/14.
//  Copyright © 2020 edward. All rights reserved.
//

#import "MQManager.h"
#import <RMQClient/RMQConnection.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef void(^Func)(NSString *s);

static MQManager *manager;

@interface MQManager()<RMQConnectionDelegate>
@property (nonatomic,strong) RMQConnection *conn;
@property(nonatomic,copy) NSString *path;
@property(nonatomic,copy) Func func;
@property(nonatomic,strong) MQKey *routingkey;
@property(nonatomic,strong) RACCommand *errorCommmand;
@end

@implementation MQManager

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.errorSubject
    }
    return self;
}

- (instancetype)initWith:(NSString *)path
                andRoutingKey:(MQKey *)routingkey
                andFun:(void(^)(NSString *s))func
{
    self = [super init];
    if (self) {
        self.path = path;
        self.routingkey = routingkey;
        self.func = func;
        self.conn = [[RMQConnection alloc] initWithUri:[NSString stringWithFormat:@"amqp://root:root@%@",self.path] delegate:self];
        [self setup];
    }
    return self;
}
+ (instancetype)managerWithPath:(NSString *)path
                andRoutingKey:(MQKey *)routingkey
                andFun:(void(^)(NSString *s))func
{
    if(!manager)
    {
        manager = [[MQManager alloc]initWith:path andRoutingKey:routingkey andFun:func];
    }
    return manager;
}
-(void)setup{
    @weakify(self);
    [self.errorCommmand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        UIAlertController *alertc = [UIAlertController alertControllerWithTitle:@"警告" message:x preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self endConnection];
        }];
        UIAlertAction *restart = [UIAlertAction actionWithTitle:@"重连" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self GetMsg];
        }];
        [alertc addAction:restart];
        [alertc addAction:cancel];
        
        [[self topMostController] presentViewController:alertc animated:YES completion:nil];
    }];
}
-(void)GetMsg{
    if(manager != nil)
    {
        [manager receiveLogsTopic];
    }else
    {
        NSLog(@"/*****请先初始化MQManager*****/");
    }
}

+(void)GetMsg{
    if(manager != nil)
    {
        [manager receiveLogsTopic];
    }else
    {
        NSLog(@"/*****请先初始化MQManager*****/");
    }
}
+(void)SendMsg:(NSString *)msg AndKey:(MQKey *)key{
    [manager emitLogTopic:msg sendKey:key];
}
-(void)emitLogTopic:(NSString *)msg sendKey:(MQKey *)sendKey {
//    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    if(manager !=nil)
    {
        RMQConnection *con = [[RMQConnection alloc] initWithUri:[NSString stringWithFormat:@"amqp://root:root@%@",self.path] delegate:self];
        [con start];
        id<RMQChannel> ch = [con createChannel];
        /** 创建交换器 */
        RMQExchange *x    = [ch topic:@"exchange"];
        [x publish:[msg dataUsingEncoding:NSUTF8StringEncoding] routingKey:[sendKey GetMqKeyStr]];
        
//        [con close];
    }else
    {
        NSLog(@"/*****请先初始化MQManager*****/");
    }
    
}

-(void)receiveLogsTopic{
//    NSLog(@"Attempting to connect to local RabbitMQ broker");
    /** 创建连接 */
//    if(![self.conn isOpen])
//    {
    if(self.conn == nil)
    {
        self.conn = [[RMQConnection alloc] initWithUri:[NSString stringWithFormat:@"amqp://root:root@%@",self.path] delegate:self];
    }

    [self.conn start];
    /** 创建信道 */
    id<RMQChannel> ch = [self.conn createChannel];
    /** 创建交换器 */
    RMQExchange *x    = [ch topic:@"exchange"];
    RMQQueue *q       = [ch queue:[NSString stringWithFormat:@"ios_%@",[[NSUUID UUID] UUIDString]] options:RMQQueueDeclareExclusive];
    /** 绑定交换器 */
    [q bind:x routingKey:[self.routingkey GetMqKeyStr]];
    NSLog(@"Waiting for logs.");
    /** 订阅消息 */
    @weakify(self);
    [q subscribe:^(RMQMessage * _Nonnull message) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.func)
            {
                self.func([[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding]);
            }
        });
    }];
    
}
-(void)endConnection
{
    [self.conn close];
    self.conn = nil;
}
+ (BOOL)conisClosd
{
    if(manager != nil)
    {
        return manager.conn == nil;
        
    }else
    {
        return NO;
    }
}

#pragma mark error


- (void)channel:(id<RMQChannel>)channel error:(NSError *)error {
    [self.errorCommmand execute:error.localizedDescription];
}

- (void)connection:(RMQConnection *)connection disconnectedWithError:(NSError *)error {
    
    [self.errorCommmand execute:error.localizedDescription];
}

- (void)connection:(RMQConnection *)connection failedToConnectWithError:(NSError *)error {
    
    [self.errorCommmand execute:error.localizedDescription];
}

- (void)recoveredConnection:(RMQConnection *)connection {
    
}

- (void)startingRecoveryWithConnection:(RMQConnection *)connection {
    
}


- (void)willStartRecoveryWithConnection:(RMQConnection *)connection {
    
}



#pragma mark set/get
- (MQKey *)routingkey
{
    if(!_routingkey)
    {
        _routingkey = [[MQKey alloc]init];;
    }
    return _routingkey;
}
- (RACCommand *)errorCommmand
{
    if(!_errorCommmand)
    {
        @weakify(self);
        _errorCommmand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _errorCommmand;
}

-(UIViewController *) topMostController {
  UIViewController*topController = [UIApplication sharedApplication].keyWindow.rootViewController;
  while(topController.presentedViewController){
    topController=topController.presentedViewController;
  }
  return topController;
}
@end

