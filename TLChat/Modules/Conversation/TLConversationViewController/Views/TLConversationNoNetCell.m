//
//  TLConversationNoNetCell.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLConversationNoNetCell.h"

@interface TLConversationNoNetCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation TLConversationNoNetCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 45.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView setBackgroundColor:RGBAColor(255, 223, 224, 1)];
        
        [self p_initViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addSeparator(ZZSeparatorPositionBottom);
}

#pragma mark - # Private Methods
- (void)p_initViews
{
    self.iconView = self.addImageView(1001)
    .image(TLImage(@"conv_exclamation_mark"))
    .masonry(^(MASConstraintMaker *make) {
        make.size.mas_equalTo(40);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    })
    .view;
    
    self.titleLabel = self.contentView.addLabel(1002)
    .text(LOCSTR(@"当前网络不可用，请检查你的网络设置"))
    .font([UIFont systemFontOfSize:14]).textColor([UIColor grayColor])
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-15);
        make.centerY.mas_equalTo(0);
    })
    .view;
}

@end
