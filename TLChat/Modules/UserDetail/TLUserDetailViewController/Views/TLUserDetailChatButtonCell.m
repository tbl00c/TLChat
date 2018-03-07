//
//  TLUserDetailButtonCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLUserDetailChatButtonCell.h"

@interface TLUserDetailChatButtonCell ()

@property (nonatomic, copy) id (^eventAction)(NSInteger, id);

@end

@implementation TLUserDetailChatButtonCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 62.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self.button setTitle:dataModel forState:UIControlStateNormal];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        @weakify(self);
        self.button = self.contentView.addButton(1)
        .backgroundColor([UIColor colorGreenDefault]).titleColor([UIColor whiteColor]).titleFont([UIFont systemFontOfSize:18])
        .backgroundColorHL([UIColor colorGreenHL]).titleColorHL([[UIColor whiteColor] colorWithAlphaComponent:0.7])
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
