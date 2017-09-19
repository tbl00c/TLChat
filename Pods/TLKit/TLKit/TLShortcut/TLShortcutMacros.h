//
//  TLShortcutMacros.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#ifndef TLShortcutMacros_h
#define TLShortcutMacros_h

#pragma mark - # SIZE
#define     SIZE_SCREEN                 [UIScreen mainScreen].bounds.size
#define     WIDTH_SCREEN                SIZE_SCREEN.width
#define     HEIGHT_SCREEN               SIZE_SCREEN.height
#define     HEIGHT_STATUSBAR            20.0f
#define     HEIGHT_TABBAR               49.0f
#define     HEIGHT_NAVBAR               44.0f
#define     HEIGHT_SEARCHBAR            44.0f
#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#pragma mark - # Default
/// 广播中心
#define     TLNotificationCenter        [NSNotificationCenter defaultCenter]
/// 用户自定义数据
#define     TLUserDefaults              [NSUserDefaults standardUserDefaults]
/// URL
#define     TLURL(urlString)            [NSURL URLWithString:urlString]
/// 图片
#define     TLImage(imageName)          (imageName ? [UIImage imageNamed:imageName] : nil)
#define     TLPNG(X)                    [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"png"]]
#define     TLJPG(X)                    [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"jpg"]]
/// 字符串
#define     TLNoNilString(str)          (str.length > 0 ? str : @"")
/// 方法名
#define     TLStirngFormSelector(s)     [[NSString alloc] initWithUTF8String:sel_getName(s)]
/// 颜色
#define     TLColor(r, g, b, a)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

/// 国际化
#define     LOCSTR(str)                 NSLocalizedString(str, nil)
/// Push
#define     PushVC(vc)                  {\
    [vc setHidesBottomBarWhenPushed:YES];\
    [self.navigationController pushViewController:vc animated:YES];\
}

/// 方法交换
#define     TLExchangeMethod(oldSEL, newSEL)\
            Method oldMethod = class_getInstanceMethod(self, oldSEL);\
            Method newMethod = class_getInstanceMethod(self, newSEL);\
            method_exchangeImplementations(oldMethod, newMethod);

#pragma mark - # Thread
#define     TLBackThread(block)         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define     TLMainThread(block)         dispatch_async(dispatch_get_main_queue(), block)
#define     TLMainBarrier(block)        dispatch_barrier_async(dispatch_get_main_queue(), block)
#define     TLMainAfter(x, block)       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_main_queue(), block);

/// 循环引用消除
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object)     autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object)     autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object)     try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object)     try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object)   autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object)   autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object)   try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object)   try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif
#define     TLWeakSelf(type)            __weak typeof(type) weak##type = type;
#define     TLStrongSelf(type)          __strong typeof(type) strong##type = type;

#pragma mark - # XCode
#define     XCODE_VERSION_8_LATER       __has_include(<UserNotifications/UserNotifications.h>)

#pragma mark - # Device
#define     SCREEN_IPHONE6P             (([[UIScreen mainScreen] bounds].size.height) >= 736)
#define     SCREEN_IPHONE6              (([[UIScreen mainScreen] bounds].size.height) >= 667)
#define     SCREEN_IPHONE5              (([[UIScreen mainScreen] bounds].size.height) >= 568)
#define     SCREEN_IPHONE4              (([[UIScreen mainScreen] bounds].size.height) >= 480)

#pragma mark - # System
#define     SYSTEM_VERSION_EQUAL(x)             ([[[UIDevice currentDevice] systemVersion] doubleValue] == x)
#define     SYSTEM_VERSION_GREATER(x)           ([[[UIDevice currentDevice] systemVersion] doubleValue] >= x)
#define     SYSTEM_VERSION_GREATER_IOS10        ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0f)
#define     SYSTEM_VERSION_GREATER_IOS9         ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0f)
#define     SYSTEM_VERSION_GREATER_IOS8         ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0f)
#define     SYSTEM_VERSION_GREATER_IOS7         ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0f)
#define     SYSTEM_VERSION_GREATER_IOS6         ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 6.0f)

#endif /* TLShortcutMacros_h */
