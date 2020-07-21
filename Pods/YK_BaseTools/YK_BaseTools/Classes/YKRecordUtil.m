//
//  YKRecordUtil.m
//
//  Created by Edward 
//

#import "YKRecordUtil.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface YKRecordUtil()<AVAudioRecorderDelegate>

@property (nonatomic, strong) NSURL *urlPlay;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSString *timeInterval;
@property (nonatomic, assign) NSTimeInterval voiceSize;

@property (nonatomic, strong) NSURL *recodingPath;
@property(nonatomic,assign) BOOL isfirst;
@end

@implementation YKRecordUtil
singleton_implementation(YKRecordUtil)  //取消单例模式
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isfirst = YES;
    }
    return self;
}

- (void)startWithHighQuality:(BOOL)isHigh
{
    self.isfirst = NO;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setActive:YES error:nil];
    //录音设置
    NSMutableDictionary * recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式
    [recordSetting  setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率（HZ）
    [recordSetting setValue:[NSNumber numberWithFloat:isHigh ? 11025 : 4000] forKey:AVSampleRateKey];
    //录音通道数
    [recordSetting setValue:[NSNumber  numberWithInt:isHigh ? 2 : 1] forKey:AVNumberOfChannelsKey];
    //线性采样位数
    [recordSetting  setValue:[NSNumber numberWithInt:isHigh ? 16 : 8] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting  setValue:[NSNumber numberWithInt:isHigh ? AVAudioQualityMax : AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    //获取沙盒路径 作为存储录音文件的路径
    NSString * strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    LMLog(@"path = %@",strUrl);
    //创建url
    NSString *timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.aac",strUrl,timestamp]];
    self.urlPlay = url;
    self.recodingPath = url;
    NSError * error ;
    //初始化AVAudioRecorder
    self.recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量监测
    self.recorder.meteringEnabled = YES;
    self.recorder.delegate = self;
    if(error){
//        LMLog(@"创建录音对象时发生错误，错误信息：%@",error.localizedDescription);
    }
    if([_recorder prepareToRecord]){
        //开始
        [_recorder record];
//        LMLog(@"开始录音");
    }
}

- (void)start
{
    if(!self.isfirst)
    {
        [self.recorder record];
    }else
    {
        [self startWithHighQuality:NO];
    }
}
- (void)pause
{
    [self.recorder pause];
}
- (void)record
{
    [self.recorder record];
    
}

- (void)cancel
{
    [self.recorder deleteRecording];
    if ([AVAudioSession sharedInstance].category != AVAudioSessionCategoryPlayback) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
    [_recorder stop];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:false];
}

- (NSString *)end {
    //获取当前录音时长
    NSTimeInterval voiceSize = self.recorder.currentTime;
    
//    LMLog(@"录音时长 = %lf",voiceSize);
    
    self.timeInterval = [NSString stringWithFormat:@"%.0f",voiceSize];
    self.voiceSize = voiceSize;
    
    NSString *message;
    if(voiceSize < 1){
        [self.recorder deleteRecording];
        message = @"时长小于1秒，重新录制";
    }else if (voiceSize > 60){
//        [self.recorder deleteRecording];
//        message = @"时长大于1分钟，重新录制";
    }
    if ([AVAudioSession sharedInstance].category != AVAudioSessionCategoryPlayback) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
    [self.recorder stop];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:false];
    
    return message;
}
-(void)joint{
    NSFileManager *fmanager = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *arrf = [fmanager contentsOfDirectoryAtPath:documentPath error:nil];
    NSMutableArray *reslutarr = [[NSMutableArray alloc]init];
    arr = [[arrf sortedArrayUsingComparator:^(NSString *url1, NSString *url2)
            {

        NSDictionary *fileAttributes1 = [fmanager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",documentPath,url1]
                                                                   error:nil];

        NSDictionary *fileAttributes2 = [fmanager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",documentPath,url2]
                                                                   error:nil];
        NSDate *date1 = [fileAttributes1 objectForKey:NSFileCreationDate] ;

        NSDate *date2 = [fileAttributes2 objectForKey:NSFileCreationDate] ;
        return [date1 compare:date2];
    }] mutableCopy];
    for (NSString *file in arr) {
        if([[file pathExtension] isEqualToString:@"aac"] || [[file pathExtension] isEqualToString:@"m4a"])
        {
            [reslutarr addObject:[documentPath stringByAppendingPathComponent:file]];

        }
    }
    NSError *error = nil;
    CMTime newTime = kCMTimeZero;

    AVMutableComposition *composition = [AVMutableComposition composition];
    for (NSString *url in reslutarr) {
        AVURLAsset *audioAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:url]];

        AVMutableCompositionTrack *audioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
        AVAssetTrack *audioAssetTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
        BOOL success = [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:audioAssetTrack atTime:newTime error:&error];
        if(!success)
        {
//            LMLog(@"%@",error.description);
        }
        newTime = CMTimeAdd(newTime, audioAsset.duration);
    }
        AVAssetExportSession *session = [[AVAssetExportSession alloc]initWithAsset:composition presetName:AVAssetExportPresetAppleM4A];

        NSString *newpath = [NSString stringWithFormat:@"%@/new.m4a",documentPath];
        if([[NSFileManager defaultManager] fileExistsAtPath:newpath])
        {
            BOOL success = [[NSFileManager defaultManager] removeItemAtPath:newpath error:nil];
        }
        session.outputURL = [NSURL fileURLWithPath:newpath];
        session.outputFileType = AVFileTypeAppleM4A; //与上述的`present`相对应
        session.shouldOptimizeForNetworkUse = YES;   //优化网络
    @weakify(fmanager);
    @weakify(self);
        [session exportAsynchronouslyWithCompletionHandler:^{
            if (session.status == AVAssetExportSessionStatusCompleted) {
                @strongify(fmanager);
                @strongify(self);
                for (NSString *file in reslutarr) {
                    if([file isEqualToString:newpath])
                    {
                        continue;
                    }
                    BOOL res=[fmanager removeItemAtPath:file error:nil];
                    if(res)
                    {
//                        LMLog(@"合并成功");
                    }
                }
            } else {
                // 其他情况, 具体请看这里`AVAssetExportSessionStatus`.
            }
        }];
}

@end
