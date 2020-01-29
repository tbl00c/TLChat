//
//  TLAlertViewAppearance.m
//  TLKit
//
//  Created by 李伯坤 on 2020/1/28.
//

#import "TLAlertViewAppearance.h"

@implementation TLAlertViewAppearance

+ (instancetype)appearance
{
    static TLAlertViewAppearance *appearance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearance = [[TLAlertViewAppearance alloc] init];
    });
    return appearance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self resetData];
    }
    return self;
}

- (void)resetData
{
    _cornerRadius = 8.0f;
    _shadowColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    _backgroundColor = [UIColor whiteColor];
    _separatorColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    
    _titleFont = [UIFont boldSystemFontOfSize:17.0f];
    _titleColor = [UIColor blackColor];
    
    _messageFont = [UIFont systemFontOfSize:17.0f];
    _messageColor = [UIColor grayColor];
    
    _viewWidth = 320;
    _itemHeight = 52;
    _minViewHeight = 160;
    
    _itemTitleFont = [UIFont boldSystemFontOfSize:17.0f];
    _itemTitleColor = [UIColor colorWithRed:74/255.0 green:99/255.0 blue:141/255.0 alpha:1.0];
    _destructiveItemTitleColor = [UIColor redColor];
    _cancelItemTitleColor = [UIColor blackColor];
}

@end
