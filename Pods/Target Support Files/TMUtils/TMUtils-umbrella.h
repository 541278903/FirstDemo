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

#import "NSArray+TMSafeUtils.h"
#import "NSDictionary+TMSafeUtils.h"
#import "NSString+TMSafeUtils.h"
#import "TMUtils.h"

FOUNDATION_EXPORT double TMUtilsVersionNumber;
FOUNDATION_EXPORT const unsigned char TMUtilsVersionString[];

