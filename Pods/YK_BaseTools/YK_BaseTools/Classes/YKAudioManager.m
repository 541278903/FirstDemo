
//
//  YKAudioManager.m
//  LingHitMaster
//
//  Created by Arclin on 2018/11/27.
//  Copyright © 2018 广东灵机文化传播有限公司（本内容仅限于广东灵机文化传播有限公司内部传阅，禁止外泄以及用于其他的商业目的）. All rights reserved.
//

#import "YKAudioManager.h"
//#import "LMMacro.h"
#import <AVFoundation/AVFoundation.h>

@interface YKAudioManager()
{
    BOOL isObserving;
}
/** 定时器启动开始 经过的时间 */
@property (nonatomic, assign) NSInteger currentDuration;

/** 记录播放状态 */
@property (nonatomic, strong) NSMutableDictionary *playStatusDic;

/** 记录播放的url */
@property (nonatomic, strong) NSMutableDictionary *audioUrlDic;

/** 正在播放的id */
@property (nonatomic, copy) NSString *playingId;

@property (nonatomic, strong) AVPlayer *audioPlay;

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy) NSString *restTime;
@property (nonatomic, copy) NSString *total;

@property (nonatomic, strong) id  timeObserve;
@property (nonatomic, strong) RACDisposable *disposeable;
@property (nonatomic, strong) RACSubject *statusChangeSubject;
@end

@implementation YKAudioManager
singleton_implementation(YKAudioManager)

- (void)registerPlayStatusWithId:(NSString *)Id audioUrl:(NSString *)audio
{
    if (!Id || !audio) return;
    if ( [audio hasPrefix:@"file:///"] ) {
        // 本地url
        audio = [audio stringByReplacingOccurrencesOfString:@"file:///" withString:@""];
    }
//    if (audio.lastPathComponent.pathExtension.length == 0) {
//        audio = [audio stringByAppendingPathExtension:@"aac"];
//    }
    [self.playStatusDic setObject:@(LMCellVoicePlayStatusNeverPlaying) forKey:Id];
    [self.audioUrlDic setObject:audio forKey:Id];
}

- (void)markPlayingId:(NSString *)Id pauseToStop:(BOOL)pauseToStop
{
    if(self.playingId && ![self.playingId isEqualToString:Id]) {
        // 若当前正在播放的id不是传入的id,先将当前的id播放状态置为停止
        self.playStatusDic[self.playingId] = @(LMCellVoicePlayStatusFinish); // 播放停止
        // 重置进度
        [self endPlay];
    } else if (self.playingId && [self.playingId isEqualToString:Id]) {
        // 传入的id就是当前播放的id
        if ( [self.playStatusDic[Id] integerValue] == LMCellVoicePlayStatusPause){
            // 当前状态是停止的就改为继续播放
            self.playStatusDic[Id] = @(LMCellVoicePlayStatusPlaying);
            [self.audioPlay play];
        }else if ( [self.playStatusDic[Id] integerValue] == LMCellVoicePlayStatusPlaying){
            if (pauseToStop) {
                // 当前状态是播放的就改为停止
                self.playStatusDic[Id] = @(LMCellVoicePlayStatusFinish);
                self.progress = 0;
                [self endPlay];
            } else {
                // 当前状态是播放的就改为暂停
                self.playStatusDic[Id] = @(LMCellVoicePlayStatusPause);
                [self.audioPlay pause];
            }
        }else{
            // 其他状态的就改为播放结束
            self.playStatusDic[Id] = @(LMCellVoicePlayStatusFinish);
            self.playingId = nil;
            
        }
        [self.statusChangeSubject sendNext:RACTuplePack(self.playStatusDic[Id],Id)];
        
        return;
    }
    
    self.playStatusDic[Id] = @(LMCellVoicePlayStatusPlaying); // 播放开始
    self.playingId = Id;
    [self playAudioWithId:self.playingId];
    [self.statusChangeSubject sendNext:RACTuplePack(self.playStatusDic[Id],Id)];
    
}

- (void)markPlayingId:(NSString *)Id
{
    [self markPlayingId:Id pauseToStop:NO];
}

- (void)markStopPlayingId:(NSString *)Id
{
    if (Id && [self.playStatusDic.allKeys containsObject:Id]) {
        self.playStatusDic[Id] = @(LMCellVoicePlayStatusFinish);
    }
    if (self.playingId) {
        self.playStatusDic[self.playingId] = @(LMCellVoicePlayStatusFinish);
        self.playingId = nil;
    }
    [self endPlay];
}

- (LMCellVoicePlayStatus)playStatusWithId:(NSString *)Id
{
    return [self.playStatusDic[Id] integerValue];
}

/*
 * 播放完毕
 */
- (void)endPlay {
    if (self.audioPlay == nil) return;
    [self.audioPlay pause];
    self.playingId = @"";
    //移除监控
    [self removeObserver];
    
    //重置进度
    self.progress = 0.f;
}

- (void)playAudioWithId:(NSString *)Id {
    NSString *soundPath = self.audioUrlDic[Id];
    NSURL *soundUrl;
    if (!soundPath) return;
    if ([soundPath hasPrefix:@"http://"] || [soundPath hasPrefix:@"https://"]) {
        soundUrl = [NSURL URLWithString:soundPath];
    } else {
        soundUrl = [NSURL fileURLWithPath:soundPath];
    }
    @try {
        if (self.audioPlay) {
            [self removeObserver];
        }
        AVPlayerItem *songItem = [[AVPlayerItem alloc] initWithURL:soundUrl];
        self.audioPlay = [[AVPlayer alloc]initWithPlayerItem:songItem];
        float total = CMTimeGetSeconds(songItem.duration);
        self.total = @(total).stringValue;
        self.restTime = @"0";
        [self.audioPlay replaceCurrentItemWithPlayerItem:songItem];
        [self.audioPlay addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
        isObserving = YES;
        @weakify(self);
         self.timeObserve = [self.audioPlay addPeriodicTimeObserverForInterval:CMTimeMake(1, 60) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            @strongify(self);
            float current = CMTimeGetSeconds(time);
            float total = CMTimeGetSeconds(songItem.duration);
            //        SuLog(@"%f, %f",current, total);
             CGFloat progress = CMTimeGetSeconds(self.audioPlay.currentItem.currentTime) / CMTimeGetSeconds(self.audioPlay.currentItem.duration);
             //在这里截取播放进度并处理
            if (current) {
                self.progress = progress;
    //            current / total;
                NSString *playTime = [NSString stringWithFormat:@"%.f",current];
                self.restTime = @(total - current).stringValue;
                self.total = @(total).stringValue;
//                LMLog(@"%@----%@",playTime,self.restTime);
            }
        }];
        
        [self.disposeable dispose];
        self.disposeable = [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
            // 其他状态的就改为播放结束
            self.playStatusDic[Id] = @(LMCellVoicePlayStatusFinish);
            self.progress = 0;
            self.playingId = nil;
            [self.statusChangeSubject sendNext:RACTuplePack(self.playStatusDic[Id],Id)];
        }];
    } @catch (NSException *exception) {
        NSLog(@"音频播放发生错误：%@",exception);
    }
}


//MARK: 滑动到指定的时间
- (void)seekToTime:(CMTime)time Id:(NSString *)Id
{
    if(self.playingId && self.playingId != Id) {
        // 播放对应的音频
        [self markPlayingId:Id];
    }
    
    // 当前状态是播放的就改为暂停
    self.playStatusDic[Id] = @(LMCellVoicePlayStatusPause);
    [self.audioPlay pause];
    
    @weakify(self);
    if (self.audioPlay.status == AVPlayerStatusReadyToPlay) {
        [self.audioPlay seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
            @strongify(self);
            self.playingId = Id;
            [self.audioPlay play];
            self.playStatusDic[Id] = @(LMCellVoicePlayStatusPlaying);
        }];
    }
}

// MARK:KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[@"new"] integerValue];
        NSLog(@"现在的播放器状态是 %zd",status);
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:  // 1
            {
                // 开始播放
                [self.audioPlay play];
            }
                break;
            case AVPlayerItemStatusFailed: // 2
            {
                NSLog(@"加载失败");
                [[NSNotificationCenter defaultCenter] postNotificationName:kPlayErrorNotificationName object:nil userInfo:@{@"msg":@"加载失败"}];
            }
                break;
            case AVPlayerItemStatusUnknown: // 0
            {
                NSLog(@"未知资源");
                [[NSNotificationCenter defaultCenter] postNotificationName:kPlayErrorNotificationName object:nil userInfo:@{@"msg":@"资源不存在"}];
            }
                break;
            default:
                break;
        }
    }
}

// 移除监听
- (void)removeObserver {
    if (self.timeObserve) {
        [self.audioPlay removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
    
    if (isObserving) {
        [self.audioPlay removeObserver:self forKeyPath:@"status"];
        isObserving = NO;
    }
    [self.audioPlay replaceCurrentItemWithPlayerItem:nil];
}

- (NSMutableDictionary *)playStatusDic
{
    if (!_playStatusDic) {
        _playStatusDic = [NSMutableDictionary dictionary];
    }
    return _playStatusDic;
}

- (NSMutableDictionary *)audioUrlDic
{
    if (!_audioUrlDic) {
        _audioUrlDic = [NSMutableDictionary dictionary];
    }
    return _audioUrlDic;
}

- (RACSubject<RACTuple *> *)statusChangeSubject
{
    if (!_statusChangeSubject){
        _statusChangeSubject = [RACSubject subject];
    }
    return _statusChangeSubject;
}

@end
