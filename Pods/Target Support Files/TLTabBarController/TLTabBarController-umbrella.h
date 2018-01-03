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

#import "TLBadge.h"
#import "TLTabBar.h"
#import "UITabBarItem+TLPrivateExtension.h"
#import "TLTabBarController.h"
#import "TLTabBarControllerProtocol.h"
#import "UITabBar+TLExtension.h"
#import "UITabBarItem+TLExtension.h"

FOUNDATION_EXPORT double TLTabBarControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char TLTabBarControllerVersionString[];

