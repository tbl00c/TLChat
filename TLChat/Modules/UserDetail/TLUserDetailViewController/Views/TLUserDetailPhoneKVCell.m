//
//  TLUserDetailPhoneKVCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLUserDetailPhoneKVCell.h"

@interface TLUserDetailPhoneKVCell ()

@property (nonatomic, strong) UIButton *phoneButton;

@end

@implementation TLUserDetailPhoneKVCell

- (void)setViewDataModel:(TLUserDetailKVModel *)dataModel
{
    [super setViewDataModel:dataModel];
    
    [self.phoneButton setTitle:dataModel.data forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.phoneButton = self.detailContentView.addButton(1)
        .titleColor([UIColor colorBlueMoment]).titleFont([UIFont systemFontOfSize:16])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
        })
        .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
            NSString *phone = sender.currentTitle;
            NSString *urlString = [NSString stringWithFormat:@"tel:%@", phone];
            [[UIApplication sharedApplication] openURL:TLURL(urlString)];
        })
        .view;
    }
    return self;
}

@end
