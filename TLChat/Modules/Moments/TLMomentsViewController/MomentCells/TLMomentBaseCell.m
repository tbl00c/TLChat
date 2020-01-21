//
//  TLMomentBaseCell.m
//  TLChat
//
//  Created by libokun on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentBaseCell.h"
#import "TLMomentExtensionView.h"

@interface TLMomentBaseCell ()

/// 头像
@property (nonatomic, strong) UIButton *avatarView;
/// 用户名
@property (nonatomic, strong) UIButton *nameView;
/// 正文
@property (nonatomic, strong) UILabel *titleLabel;

/// 点赞&评论
@property (nonatomic, strong) TLMomentExtensionView *extensionView;

/// 链接
@property (nonatomic, strong) UIButton *linkButton;
/// 时间
@property (nonatomic, strong) UILabel *dateLabel;
/// 来源
@property (nonatomic, strong) UILabel *originLabel;
/// 更多按钮
@property (nonatomic, strong) UIButton *moreButton;

@end

@implementation TLMomentBaseCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(TLMoment *)dataModel
{
    CGFloat height = dataModel.momentFrame.height;
    return height;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setMoment:dataModel];
}

- (void)setViewDelegate:(id)delegate
{
    self.delegate = delegate;
}

#pragma mark - # Cell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self p_initSubviews];
    }
    return self;
}

- (void)setMoment:(TLMoment *)moment
{
    _moment = moment;
    
    // 头像
    [self.avatarView tt_setImageWithURL:TLURL(moment.user.avatarURL) forState:UIControlStateNormal placeholderImage:TLImage(DEFAULT_AVATAR_PATH)];
    // 用户名
    self.nameView.zz_make.title(moment.user.showName);
    // 正文
    [self.titleLabel setText:moment.detail.text];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(moment.detail.detailFrame.heightText);
    }];
    [self.detailContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(moment.detail.text.length > 0 ? 10.0f : 0);
    }];
    
    // 点赞&评论
    [self.extensionView setHidden:!moment.hasExtension];
    [self.extensionView setExtension:moment.extension];
    [self.extensionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(moment.momentFrame.heightExtension);
        make.bottom.mas_equalTo(moment.hasExtension ? -15 : -10);
    }];
    [self.moreButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.extensionView.mas_top).mas_offset(moment.hasExtension ? -3 : 0);
    }];
    
    // 时间
    [self.dateLabel setText:moment.showDate];
    // 来源
    [self.originLabel setText:moment.source];
    // 链接
    self.linkButton.zz_make.title(moment.link.title).hidden(moment.link.title.length == 0);
}

#pragma mark - # UI
- (void)p_initSubviews
{
    @weakify(self);
    
    // 头像
    self.avatarView = self.contentView.addButton(1001)
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        [self e_didClickUser];
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(40);
    })
    .view;
    
    // 用户名
    self.nameView = self.contentView.addButton(1002)
    .backgroundColor([UIColor clearColor]).backgroundColorHL([UIColor lightGrayColor])
    .titleFont([UIFont boldSystemFontOfSize:15.0f]).titleColor([UIColor colorBlueMoment])
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        [self e_didClickUser];
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-10);
        make.height.mas_equalTo(18.0f);
    })
    .view;
    
    // 正文
    self.titleLabel = self.contentView.addLabel(1011)
    .font([UIFont systemFontOfSize:15.0f]).numberOfLines(0)
    .masonry (^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom).mas_offset(6);
        make.left.mas_equalTo(self.nameView);
        make.right.mas_lessThanOrEqualTo(-15);
    })
    .view;
    
    self.detailContainer = self.contentView.addView(1020)
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(self.nameView);
        make.right.mas_equalTo(-15);
    })
    .view;
    
    // 点赞&评论
    [self.contentView addSubview:self.extensionView];
    [self.extensionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameView);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-15);
    }];
    
    // 更多按钮
    self.moreButton = self.contentView.addButton(3003)
    .image(TLImage(@"moments_more")).imageHL(TLImage(@"moments_moreHL"))
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.bottom.mas_equalTo(self.extensionView.mas_top);
    })
    .view;
    
    // 时间
    self.dateLabel = self.contentView.addLabel(3001)
    .font([UIFont systemFontOfSize:12.0f]).textColor([UIColor grayColor])
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameView);
        make.centerY.mas_equalTo(self.moreButton);
    })
    .view;
    
    // 来源
    self.originLabel = self.contentView.addLabel(3002)
    .font([UIFont systemFontOfSize:12.0f]).textColor([UIColor grayColor])
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dateLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.dateLabel);
    })
    .view;
    
    // 链接
    self.linkButton = self.contentView.addButton(3010)
    .backgroundColor([UIColor clearColor]).backgroundColorHL([UIColor lightGrayColor])
    .titleFont([UIFont systemFontOfSize:13.0f]).titleColor([UIColor colorBlueMoment])
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewWithModel:jumpToUrl:)]) {
            [self.delegate momentViewWithModel:self.moment jumpToUrl:self.moment.link.jumpUrl];
        }
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameView);
        make.right.mas_lessThanOrEqualTo(-10);
        make.bottom.mas_equalTo(self.dateLabel.mas_top).mas_offset(-6);
        make.height.mas_equalTo(20);
    })
    .view;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addSeparator(ZZSeparatorPositionBottom);
}

#pragma mark - # Event
- (void)e_didClickUser
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewWithModel:didClickUser:)]) {
        [self.delegate momentViewWithModel:self.moment didClickUser:self.moment.user];
    }
}

#pragma mark - # Getters
- (TLMomentExtensionView *)extensionView
{
    if (!_extensionView) {
        _extensionView = [[TLMomentExtensionView alloc] init];
        [_extensionView setHidden:YES];
    }
    return _extensionView;
}

@end
