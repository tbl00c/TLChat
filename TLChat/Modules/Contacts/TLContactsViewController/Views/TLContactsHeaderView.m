//
//  TLContactsHeaderView.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLContactsHeaderView.h"

@interface TLContactsHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLContactsHeaderView

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 22.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setTitle:dataModel];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *bgView = [UIView new];
        [bgView setBackgroundColor:[UIColor colorGrayBG]];
        [self setBackgroundView:bgView];
        
        self.titleLabel = self.contentView.addLabel(1)
        .font([UIFont systemFontOfSize:15])
        .textColor([UIColor grayColor])
        .masonry(^ (MASConstraintMaker *make){
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            make.right.mas_lessThanOrEqualTo(-15);
        })
        .view;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:title];
}

@end
