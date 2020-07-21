//
//  LMAudioManager.h
//  LingHitMaster
//


#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "Singleton.h"
#import <CoreMedia/CMTime.h>

typedef enum : NSUInteger { // 顺序不要改
    LMCellVoicePlayStatusNeverPlaying, // 还没播放过
    LMCellVoicePlayStatusPlaying, // 正在播放中
    LMCellVoicePlayStatusPause, // 暂停
    LMCellVoicePlayStatusFinish, // 播放结束了
} LMCellVoicePlayStatus;

@class LMCommonStrategyData;

NS_ASSUME_NONNULL_BEGIN

static NSString *kTimerNotificationName = @"LMCellTimerNotification";
static NSString *kPlayErrorNotificationName = @"LMPlayErrorNotificationName";

@interface YKAudioManager : NSObject
singleton_interface

@property (nonatomic,assign,readonly) CGFloat progress;
@property (nonatomic,copy,readonly) NSString *restTime;
@property (nonatomic,copy,readonly) NSString *total;
@property (nonatomic,copy,readonly) NSString *playingId;
@property (nonatomic,strong,readonly) RACSubject<RACTuple *> *statusChangeSubject;

/** 帖子的id不是唯一的 只有type拼接上id才是唯一的 但是这里只处理type为11的数据 所以只要传Id就行了 */
/** 这个方法初始化所有的播放状态为0 */
- (void)registerPlayStatusWithId:(NSString *)Id audioUrl:(NSString *)audio;

/** 标记正在播放音频的ID */
- (void)markPlayingId:(NSString *)Id;
/** 标记正在播放音频的ID 重复点击直接停止 */
- (void)markPlayingId:(NSString *)Id pauseToStop:(BOOL)pauseToStop;

/** 标记播放结束音频的ID 会停止当前音频的播放，跟你调用endplay是同个样 */
- (void)markStopPlayingId:(NSString *)Id;

/** 返回播放状态 */
- (LMCellVoicePlayStatus)playStatusWithId:(NSString *)Id;

/** 滑动到指定时间 */
- (void)seekToTime:(CMTime)time Id:(NSString *)Id;

/** 结束播放 */
- (void)endPlay;
/** 定时器启动开始 经过的时间 */
@property (nonatomic, assign,readonly) NSInteger currentDuration;


@end

NS_ASSUME_NONNULL_END
