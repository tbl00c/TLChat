//
//  TLScanViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/24.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIkit.h>

@interface TLScanViewController : UIViewController

@property (nonatomic, strong) void (^scannerSuncessBlock) (TLScanViewController *, NSString *);

@property (nonatomic, strong) void (^scannerFailedBlock) (TLScanViewController *);

- (void)startCodeReading;

- (void)stopCodeReading;

@end
