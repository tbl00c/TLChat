//
//  TLNetworkStatusManager.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 网络状态
typedef NS_ENUM(NSInteger, TLNetworkStatus) {
    TLNetworkStatusUnknown          = -1,
    TLNetworkStatusNone             = 0,
    TLNetworkStatusWWAN             = 1,
    TLNetworkStatusWIFI             = 2,
};

/// 联网类型
typedef NS_ENUM(NSInteger, TLNetworkType) {
    TLNetworkTypeUnknown = -1,
    TLNetworkTypeNone    = 0,
    TLNetworkTypeWIFI    = 1,
    TLNetworkType2G      = 2,
    TLNetworkType3G      = 3,
    TLNetworkType4g      = 4,
};

/// 详细网络状态
typedef NS_ENUM(NSInteger, TLNetworkDetailType) {
    TLNetworkDetailTypeNOTREACHABLE = -1,
    TLNetworkDetailTypeUNKNOWN = 0,
    TLNetworkDetailTypeGPRS = 1,
    TLNetworkDetailTypeEDGE = 2,
    TLNetworkDetailTypeUMTS = 3,
    TLNetworkDetailTypeCDMA = 4,
    TLNetworkDetailTypeEVDO_0 = 5,
    TLNetworkDetailTypeEVDO_A = 6,
    TLNetworkDetailType1xRTT = 7,
    TLNetworkDetailTypeHSDPA = 8,
    TLNetworkDetailTypeHSUPA = 9,
    TLNetworkDetailTypeHSPA = 10,
    TLNetworkDetailTypeIDEN = 11,
    TLNetworkDetailTypeEVDO_B = 12,
    TLNetworkDetailTypeLTE = 13,
    TLNetworkDetailTypeEHRPD = 14,
    TLNetworkDetailTypeHSPAP = 15,
    TLNetworkDetailTypeGSM = 16,
    TLNetworkDetailTypeTD_SCDMA = 17,
    TLNetworkDetailTypeIWLAN = 18,
    TLNetworkDetailTypeWIFI = 99
};


@interface TLNetworkStatusManager : NSObject

/// 网络状态（Unkown, None, WWAN, WIFI）
@property (nonatomic, assign, readonly) TLNetworkStatus networkStatus;

/// 联网类型（None, Unknown, WIFI, 2/3/4G）
@property (nonatomic, assign, readonly) TLNetworkType networkType;

/// 详细网络状态
@property (nonatomic, assign, readonly) TLNetworkDetailType networkDetailType;


@property (nonatomic, copy) void (^networkChangedBlock)(TLNetworkStatus status);

+ (TLNetworkStatusManager *)sharedInstance;

/**
 * 开始网络状态监控
 */
- (void)startNetworkStatusMonitoring;

/**
 * 停止网络状态监控
 */
- (void)stopNetworkStatusMonitoring;

@end
