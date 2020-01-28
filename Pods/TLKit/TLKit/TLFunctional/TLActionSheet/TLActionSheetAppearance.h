//
//  TLActionSheetAppearance.h
//  TLKit
//
//  Created by 李伯坤 on 2020/1/27.
//

#import <UIKit/UIKit.h>

@interface TLActionSheetAppearance : NSObject

@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *separatorColor;

@property (nonatomic, strong) UIFont *headerTitleFont;
@property (nonatomic, strong) UIColor *headerTitleColor;

@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIColor *itemBackgroundColor;

@property (nonatomic, strong) UIFont *itemTitleFont;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIColor *destructiveItemTitleColor;
@property (nonatomic, strong) UIColor *cancelItemTitleColor;

@property (nonatomic, strong) UIFont *itemMessageFont;
@property (nonatomic, strong) UIColor *itemMessageColor;
@property (nonatomic, strong) UIColor *destructiveItemMessageColor;

+ (instancetype)appearance;

@end
