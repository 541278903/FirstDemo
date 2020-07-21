#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FMDBTools.h"
#import "MQKey.h"
#import "MQManager.h"
#import "Singleton.h"
#import "YKAudioManager.h"
#import "YKNetWorking.h"
#import "YKRecordUtil.h"
#import "YKTools.h"

FOUNDATION_EXPORT double YK_BaseToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char YK_BaseToolsVersionString[];

