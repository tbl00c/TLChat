//
//  TLNetwork.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#ifndef TLNetwork_h
#define TLNetwork_h

#define TLNetworkErrorTip  @"网络异常,请稍后重试..."

#pragma mark - # 网络请求
#import "TLBaseRequest.h"
#import "TLResponse.h"

#pragma mark - # 网络工具
#import "TLNetworkStatusManager.h"

#pragma mark - # 网络图片
#import "UIImageView+TLWebImage.h"
#import "UIButton+TLWebImage.h"
#import "TLImageDownloader.h"

#pragma mark - # Common
#import "NSString+TLNetwork.h"
#import "NSURL+TLNetwork.h"

#pragma mark - # LoadMore
#import "TLRefresh.h"

#endif /* TLNetwork_h */
