//
//  TLQRCodeViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"

@interface TLQRCodeViewController : TLViewController

/// 信息页面元素 —— 头像URL (若为nil，会尝试根据Path设置)
@property (nonatomic, strong) NSString *avatarURL;

/// 信息页面元素 —— 头像Path
@property (nonatomic, strong) NSString *avatarPath;

/// 信息页面元素 —— 用户名
@property (nonatomic, strong) NSString *username;

/// 信息页面元素 —— 副标题（如地址）
@property (nonatomic, strong) NSString *subTitle;

/// 信息页面元素 —— 底部说明
@property (nonatomic, strong) NSString *introduction;

/// 信息页面元素 —— 二维码字符串
@property (nonatomic, strong) NSString *qrCode;

/**
 *  根据str创建二维码
 *
 *  @param str 字符串
 *  @param ans 创建完成的回调（异步）
 */
+ (void)createQRCodeImageForString:(NSString *)str ans:(void (^)(UIImage *ansImage))ans;

/**
 *  将二维码信息页面保存到系统相册
 */
- (void)saveQRCodeToSystemAlbum;

@end
