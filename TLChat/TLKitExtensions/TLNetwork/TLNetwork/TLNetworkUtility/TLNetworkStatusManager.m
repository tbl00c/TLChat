//
//  TLNetworkStatusManager.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLNetworkStatusManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface TLNetworkStatusManager ()

@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@end

@implementation TLNetworkStatusManager
@synthesize networkStatus = _networkStatus;

+ (TLNetworkStatusManager *)sharedInstance
{
    static TLNetworkStatusManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TLNetworkStatusManager alloc] init];
    });
    return manager;
}

- (id)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:CTRadioAccessTechnologyDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - # Public Methods
- (void)startNetworkStatusMonitoring
{
    [self.manager startMonitoring];
}

- (void)stopNetworkStatusMonitoring
{
    [self.manager stopMonitoring];
}

- (void)setNetworkChangedBlock:(void (^)(TLNetworkStatus))networkChangedBlock
{
    _networkChangedBlock = networkChangedBlock;
    @weakify(self);
    [self.manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        @strongify(self);
        if (self.networkChangedBlock) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    self.networkStatus = TLNetworkStatusNone;
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    self.networkStatus = TLNetworkStatusWIFI;
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    self.networkStatus = TLNetworkStatusWWAN;
                    break;
                default:
                    self.networkStatus = TLNetworkStatusUnknown;
                    break;
            }
            self.networkChangedBlock(self.networkStatus);
        }
    }];
}

- (void)setNetworkStatus:(TLNetworkStatus)networkStatus
{
    _networkStatus = networkStatus;
}

#pragma mark - # Event Response
- (void)networkStatusChanged:(NSNotification *)notification
{
    if (notification && notification.name && [notification.name isEqualToString:CTRadioAccessTechnologyDidChangeNotification]) {
        NSString *netInfo = notification.object;
        if ([netInfo isEqualToString:CTRadioAccessTechnologyGPRS]) {
            _networkDetailType = TLNetworkDetailTypeGPRS;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyEdge]) {
            _networkDetailType = TLNetworkDetailTypeEDGE;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyWCDMA]) {
            _networkDetailType = TLNetworkDetailTypeUMTS;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyHSDPA]) {
            _networkDetailType = TLNetworkDetailTypeHSDPA;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyHSUPA]) {
            _networkDetailType = TLNetworkDetailTypeHSUPA;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
            _networkDetailType = TLNetworkDetailTypeCDMA;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
            _networkDetailType = TLNetworkDetailTypeEVDO_0;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
            _networkDetailType = TLNetworkDetailTypeEVDO_A;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
            _networkDetailType = TLNetworkDetailTypeEVDO_B;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyeHRPD]) {
            _networkDetailType = TLNetworkDetailTypeEHRPD;
        }
        else if ([netInfo isEqualToString:CTRadioAccessTechnologyLTE]) {
            _networkDetailType = TLNetworkDetailTypeLTE;
        }
        else {
            _networkDetailType = TLNetworkDetailTypeUNKNOWN;
        }
    }
}

#pragma mark - # Getters
- (AFNetworkReachabilityManager *)manager
{
    if (!_manager) {
        _manager = [AFNetworkReachabilityManager manager];
    }
    return _manager;
}

- (TLNetworkType)networkType
{
    if (self.networkStatus == TLNetworkStatusNone) {
        return TLNetworkTypeNone;
    }
    else if (self.networkStatus == TLNetworkStatusWIFI) {
        return TLNetworkTypeWIFI;
    }
    
    switch (self.networkDetailType) {
        case TLNetworkDetailTypeNOTREACHABLE:
            return TLNetworkTypeNone;
        case TLNetworkDetailTypeEDGE:
        case TLNetworkDetailTypeGPRS:
        case TLNetworkDetailTypeCDMA:
            return TLNetworkType2G;
        case TLNetworkDetailTypeHSDPA:
        case TLNetworkDetailTypeUMTS:
        case TLNetworkDetailTypeHSUPA:
        case TLNetworkDetailTypeEVDO_0:
        case TLNetworkDetailTypeEVDO_A:
        case TLNetworkDetailTypeEVDO_B:
        case TLNetworkDetailTypeEHRPD:
            return TLNetworkType3G;
        case TLNetworkDetailTypeLTE:
            return TLNetworkType4g;
        case TLNetworkDetailTypeWIFI:
            return TLNetworkTypeWIFI;
        default:
            break;
    }
    return TLNetworkTypeUnknown;
}

@end
