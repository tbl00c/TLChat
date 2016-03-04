//
//  TLScannerButton.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLScannerButton : UIButton

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *iconPath;

@property (nonatomic, strong) NSString *iconHLPath;

@property (nonatomic, assign) TLScannerType type;

@property (nonatomic, assign) NSUInteger msgNumber;

- (id) initWithType:(TLScannerType)type title:(NSString *)title iconPath:(NSString *)iconPath iconHLPath:(NSString *)iconHLPath;

@end
