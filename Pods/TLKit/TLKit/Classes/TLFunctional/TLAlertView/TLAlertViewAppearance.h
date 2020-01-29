//
//  TLAlertViewAppearance.h
//  TLKit
//
//  Created by 李伯坤 on 2020/1/28.
//

#import <Foundation/Foundation.h>

@interface TLAlertViewAppearance : NSObject

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *separatorColor;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *messageFont;
@property (nonatomic, strong) UIColor *messageColor;

@property (nonatomic, strong) UIFont *itemTitleFont;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIColor *destructiveItemTitleColor;
@property (nonatomic, strong) UIColor *cancelItemTitleColor;

@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat minViewHeight;
@property (nonatomic, assign) CGFloat itemHeight;

+ (instancetype)appearance;

@end
