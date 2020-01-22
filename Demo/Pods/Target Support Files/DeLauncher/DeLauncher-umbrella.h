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

#import "DeLauncher.h"
#import "DeLauncherManager.h"

FOUNDATION_EXPORT double DeLauncherVersionNumber;
FOUNDATION_EXPORT const unsigned char DeLauncherVersionString[];

