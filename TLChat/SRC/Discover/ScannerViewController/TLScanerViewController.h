//
//  TLScanerViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/24.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"

@interface TLScanerViewController : TLViewController

@property (nonatomic, copy) void (^SYQRCodeCancleBlock) (TLScanerViewController *);//扫描取消
@property (nonatomic, copy) void (^SYQRCodeSuncessBlock) (TLScanerViewController *,NSString *);//扫描结果
@property (nonatomic, copy) void (^SYQRCodeFailBlock) (TLScanerViewController *);//扫描失败

@end
