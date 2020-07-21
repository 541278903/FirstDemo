//
//  YKRecordUtil.h
//
//  Created by Edward 
//

#import <Foundation/Foundation.h>
#import "Singleton.h"   //取消单例模式

NS_ASSUME_NONNULL_BEGIN

@interface YKRecordUtil : NSObject
singleton_interface  //取消单例模式

@property (nonatomic, strong, readonly) NSURL *urlPlay;

@property (nonatomic, strong, readonly) NSString *timeInterval;

@property (nonatomic, assign, readonly) NSTimeInterval voiceSize;

@property (nonatomic, strong, readonly) NSURL *recodingPath;

- (void)start;

- (void)startWithHighQuality:(BOOL)isHigh;

- (void)cancel;

- (NSString *)end;

- (void)pause;

- (void)record;

@end

NS_ASSUME_NONNULL_END
