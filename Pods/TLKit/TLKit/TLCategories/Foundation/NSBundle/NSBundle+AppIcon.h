//
//  NSBundle+AppIcon.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSBundle (AppIcon)

@property (nonatomic, strong, readonly) NSString *appIconPath;

@property (nonatomic, strong, readonly) UIImage *appIcon;

@end
