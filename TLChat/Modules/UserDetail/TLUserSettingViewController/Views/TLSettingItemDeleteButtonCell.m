//
//  TLSettingItemDeleteButtonCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/3/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLSettingItemDeleteButtonCell.h"
#import "TLSettingItem.h"

@interface TLSettingItemDeleteButtonCell ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation TLSettingItemDeleteButtonCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 62.0f;
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

- (void)setViewDataModel:(TLSettingItem *)dataModel
{
    self.button.zz_make.title(dataModel.title);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        @weakify(self);
        self.button = self.contentView.addButton(1)
        .backgroundColor([UIColor colorRedForButton]).titleColor([UIColor whiteColor]).titleFont([UIFont systemFontOfSize:18])
        .backgroundColorHL([UIColor colorRedForButtonHL]).titleColorHL([[UIColor whiteColor] colorWithAlphaComponent:0.7])
        .cornerRadius(5).borderWidth(1).borderColor([UIColor colorGrayLine].CGColor)
        .masonry(^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-15);
        })
        .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
            @strongify(self);
            if (self.eventAction) {
                self.eventAction(0, nil);
            }
        })
        .view;
    }
    return self;
}

@end
