//
//  TLWebViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface TLWebViewController : UIViewController <WKNavigationDelegate, WKUIDelegate>

/// 是否使用网页标题作为nav标题，默认YES
@property (nonatomic, assign) BOOL useMPageTitleAsNavTitle;

/// 是否显示加载进度，默认YES
@property (nonatomic, assign) BOOL showLoadingProgress;

// 是否禁止历史记录，默认NO
@property (nonatomic, assign) BOOL disableBackButton;

@property (nonatomic, strong) NSString *url;

@end
