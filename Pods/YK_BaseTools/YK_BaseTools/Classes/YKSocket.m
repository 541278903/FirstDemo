//
//  YKSocket.m
//  YK_BaseTools
//
//  Created by edward on 2020/8/12.
//  Copyright © 2020 Edward. All rights reserved.
//

#import "YKSocket.h"
#import <SocketRocket/SocketRocket.h>

@interface YKSocket()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *socket;

//socket地址
@property(nonatomic,strong) NSURL *url;

//收到信息调用block
@property(nonatomic,copy) void (^actionBlock)(id message);

//出现错误调用block
@property(nonatomic,copy) void (^erroractionBlock)(NSError *error);

@end

//static YKSocket *socketed = nil;

//https://www.jianshu.com/p/470310a87858
@implementation YKSocket



- (instancetype)initWithUrl:(NSURL *)url withaction:(nullable void (^)(id message))action witherroraction:(nullable void (^)(NSError *error))erroraction
{
    self = [super init];
    if (self) {
        self.url = url;
        self.actionBlock = action;
        self.erroractionBlock = erroraction;
        self.socket.delegate = self;
    }
    return self;
}
-(void)open{
    if(self.socket)
    {
        [self.socket open];
    }
}
- (SRWebSocket *)socket
{
    if(!_socket)
    {
        SRWebSocket *x = [[SRWebSocket alloc]initWithURLRequest:[NSURLRequest requestWithURL:self.url]];
        _socket = x;
    }
    return _socket;
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    if(webSocket == self.socket)
    {
        if(self.erroractionBlock)
        {
            self.erroractionBlock(error);
        }
        
    }
}
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    if(webSocket == self.socket)
    {
#if DEBUG
        NSLog(@"-----socket 连接成功------");
#else
#endif
    }
}

-(void)sentData:(NSString *)data{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __weak typeof(self) weakself = self;
        if (weakself.socket != nil) {
        // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
        
            if (weakself.socket.readyState == SR_OPEN) {
                [weakself.socket send:data];    // 发送数据
                
            } else if (weakself.socket.readyState == SR_CONNECTING) {
                
                
            } else if (weakself.socket.readyState == SR_CLOSING || weakself.socket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
            }
        }
    });
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
    if(webSocket == self.socket)
    {
        if(self.actionBlock)
        {
            self.actionBlock(message);
        }
    }
    
}

@end
