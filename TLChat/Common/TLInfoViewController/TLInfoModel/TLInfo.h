//
//  TLInfo.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TLInfoType) {
    TLInfoTypeDefault,
    TLInfoTypeTitleOnly,
    TLInfoTypeImages,
    TLInfoTypeMutirow,
    TLInfoTypeButton,
    TLInfoTypeOther,
};

@interface TLInfo : NSObject

@property (nonatomic, assign) TLInfoType type;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *subTitle;

@property (nonatomic, strong) NSMutableArray *subImageArray;

@property (nonatomic, strong) id userInfo;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *buttonColor;

@property (nonatomic, strong) UIColor *buttonHLColor;

@property (nonatomic, strong) UIColor *buttonBorderColor;

/**
 *  是否显示箭头（默认YES）
 */
@property (nonatomic, assign) BOOL showDisclosureIndicator;

+ (TLInfo *)createInfoWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end
