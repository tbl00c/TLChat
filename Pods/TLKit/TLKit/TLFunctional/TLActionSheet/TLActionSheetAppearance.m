//
//  TLActionSheetAppearance.m
//  TLKit
//
//  Created by 李伯坤 on 2020/1/27.
//

#import "TLActionSheetAppearance.h"

@implementation TLActionSheetAppearance

+ (instancetype)appearance
{
    static TLActionSheetAppearance *appearance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearance = [[TLActionSheetAppearance alloc] init];
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
    _shadowColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    _backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
    _separatorColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    
    _headerTitleFont = [UIFont systemFontOfSize:13.0f];
    _headerTitleColor = [UIColor grayColor];
    
    _itemHeight = 52;
    _itemBackgroundColor = [UIColor whiteColor];
    
    _itemTitleFont = [UIFont systemFontOfSize:17.0f];
    _itemTitleColor = [UIColor blackColor];
    _destructiveItemTitleColor = [UIColor redColor];
    _cancelItemTitleColor = [UIColor blackColor];
    
    _itemMessageFont = [UIFont systemFontOfSize:12.0f];
    _itemMessageColor = [UIColor grayColor];
    _destructiveItemMessageColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
}

@end
