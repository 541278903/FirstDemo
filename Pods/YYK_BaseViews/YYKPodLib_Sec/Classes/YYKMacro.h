//
//  YYKMacro.h
//  YYKPodLib_Sec
//
//  Created by Shenzhi on 2020/5/26.
//  Copyright © 2020 edward. All rights reserved.
//

#ifndef YYKMacro_h
#define YYKMacro_h



/*** 沙盒 ***/
#define YYKHomePath        NSHomeDirectory()
#define YYKTempPath        NSTemporaryDirectory()
#define YYKDocumentPath    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/*** 是否自动简繁体转换 */
//#define YYK_AUTO_TOLOCAL

#define YYKScale (IS_IPAD ? 1.5 : 1)

/*** 日志 ***/
#ifdef DEBUG // 调试
#define YYKLog(...) NSLog(@"%s 第%d行 %@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else // 发布
#define YYKLog(...)
#endif

/*** 颜色 ***/
#define YYKRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define YYKHEXCOLOR(hexColor) [UIColor yk_colorWithHexString:hexColor]

/*** UserDefaults ***/
//#define YYKSetUserDefault(key,value) [[NSUserDefaults standardUserDefaults] setObject:(value) forKey:(key)]
//#define YYKGetUserDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:(key)]

/*** KeyedArchive ***/
//#define YYKDocumentFilePath(name) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",(name)]]
//#define YYKCacheFilePath(name) [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",(name)]]
//#define YYKKeyedArchive(fileName,obj) [NSKeyedArchiver archiveRootObject:(obj) toFile:YYKDocumentFilePath(fileName)]
//#define YYKKeyedUnArchive(fileName) [NSKeyedUnarchiver unarchiveObjectWithFile:YYKDocumentFilePath(fileName)]
//#define YYKKeyedArchiveFileDelete(filename) {\
//NSFileManager *defaultManager = [NSFileManager defaultManager];\
//if ([defaultManager isDeletableFileAtPath:YYKDocumentFilePath(filename)]) {\
//[defaultManager removeItemAtPath:YYKDocumentFilePath(filename) error:nil];\
//}\
//}

/*** Notification ***/
#define YYKSendNotification(name,sendObject,info) [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:name object:sendObject userInfo:info]];

/*** 常用 ***/
#define YYKScreenW [UIScreen mainScreen].bounds.size.width
#define YYKScreenH [UIScreen mainScreen].bounds.size.height
#define YYKScreenBounds [UIScreen mainScreen].bounds

// 状态栏高度
//#define KSTATUSBAR_HEIGHT (IS_IPHONE_X ? 30 : 20)

// TabBar高度
#define KTabBar_HEIGHT (IS_IPHONE_X ? 83 : 49)

// 顶部高度
#define KTOP_MARGIN (IS_IPHONE_X ? 88 : 64)

#define KNAV_HEIGHT self.navigationController.navigationBar.height
#define KSTATUSBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define KSTATUSBAR_HEIGHT_13 [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame.size.height
#define KBottom_HEIGHT (IS_IPHONE_X ? 34 : 0)

#define YYKLoadViewFromNib [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
#define YYKLoadViewFromNibWithIndex(index) [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][index];

#define YYKDeprecated(instead) __attribute__((deprecated(instead)))

#define YYKNonnullString(str) ((str && [str isKindOfClass:[NSString class]] && str.length) ? str : @"")
#define YYKNullableString(str) ((str && [str isKindOfClass:[NSString class]] && str.length) ? str : nil)

// 当前版本
#define YYK_SYSTEM_VERSION          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define YYK_APP_NAME                ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
#define YYK_APP_VERSION             ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define YYK_APP_BUILD               ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
#define YYK_APP_BUNDLE_ID           ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"])

/*** 错误 ***/
#define YYKDomain YYK_APP_BUNDLE_ID

//#define YYKError(errorMessage) [NSError errorWithDomain:YYKDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:errorMessage}]
//
//#define YYKError_(errorMessage,errorCode) [NSError errorWithDomain:YYKDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey:errorMessage}]

// 当前语言
#define YYKCURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

// 是否高于IOS X
#define YYK_isHigherIOS(version)    [[[UIDevice currentDevice]systemVersion]floatValue] > version

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 手机型号
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_X [UIDevice isIPhoneXSeries]

// x & xs
#define YYK_ISiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define YYK_ISPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define YYK_ISPhoneXsMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//#define YYK_ISiPhoneX_Series (IsiPhoneX || IsiPhoneXr || IsiPhoneXsMax)


#endif /* YYKMacro_h */

