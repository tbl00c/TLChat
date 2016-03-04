//
//  TLScannerView.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLScannerView : UIView

/**
 *  隐藏扫描指示器，默认NO
 */
@property (nonatomic, assign) BOOL hiddenScannerIndicator;

- (void)startScanner;

- (void)stopScanner;

@end
