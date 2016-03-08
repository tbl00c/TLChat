//
//  TLQRCodeViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"

@interface TLQRCodeViewController : TLViewController

@property (nonatomic, strong) NSString *avatarURL;

@property (nonatomic, strong) NSString *avatarPath;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *subTitle;

@property (nonatomic, strong) NSString *introduction;

@property (nonatomic, strong) NSString *qrCode;

+ (void)createQRCodeImageForString:(NSString *)str ans:(void (^)(UIImage *ansImage))ans;

@end
