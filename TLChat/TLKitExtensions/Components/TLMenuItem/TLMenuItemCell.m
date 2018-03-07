//
//  TLMenuItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLMenuItemCell.h"

#define     WIDTH_ICON_RIGHT        31
#define     EGDE_RIGHT_IMAGE        13
#define     EGDE_SUB_TITLE          8

@implementation TLMenuItemCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 44.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setMenuItem:dataModel];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == 0) {
        self.addSeparator(ZZSeparatorPositionTop);
    }
    else {
        self.removeSeparator(ZZSeparatorPositionTop);
    }
    if (indexPath.row == count - 1) {
        self.addSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(15);
    }
}

#pragma mark - # Public Methods
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        
        [self p_initSubviews];
    }
    return self;
}

- (void)setMenuItem:(TLMenuItem *)menuItem
{
    _menuItem = menuItem;
    
    // icon
    if (menuItem.iconURL) {     // 优先展示网络配置的图片
        [self.iconView tt_setImageWithURL:menuItem.iconURL.toURL placeholderImage:[UIImage imageNamed:menuItem.iconName]];
    }
    else if (menuItem.iconName) {
        [self.iconView setImage:[UIImage imageNamed:menuItem.iconName]];
    }
    
    // 标题
    [self.titleLabel setText:menuItem.title];
    
    // 气泡
    [self.badgeView setHidden:YES];
    if (menuItem.badge) {
        [self.badgeView setHidden:NO];
        [self.badgeView setBadgeValue:menuItem.badge];
        [self.badgeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(menuItem.badgeSize);
        }];
    }
    else {
        [self.badgeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(0);
        }];
    }
    
    // 右侧说明
    [self.detailLabel setText:menuItem.subTitle];
    
    // 右侧图片
    [self.rightBadgeView setHidden:YES];
    if (menuItem.rightIconURL.length > 0) {
        [self.rightImageView setHidden:NO];
        [self.rightImageView tt_setImageWithURL:menuItem.rightIconURL.toURL];
        if (menuItem.subTitle.length > 0) {
            [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(-WIDTH_ICON_RIGHT - EGDE_RIGHT_IMAGE - EGDE_SUB_TITLE);
            }];
        }
        
        // 图片上方气泡
        if (menuItem.showRightIconBadge) {
            [self.rightBadgeView setHidden:NO];
        }
    }
    else {
        [self.rightImageView setHidden:YES];
        if (menuItem.subTitle.length > 0) {
            [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(- EGDE_RIGHT_IMAGE);
            }];
        }
    }
}

#pragma mark - # Private Methods
- (void)p_initSubviews
{
    // icon
    self.iconView = self.addImageView(1)
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.0f);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(25.0f);
    })
    .view;
    
    // 标题
    self.titleLabel = self.addLabel(2)
    .masonry(^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(15.0f);
        make.right.mas_lessThanOrEqualTo(-15.0f);
    })
    .view;
    
    // 气泡
    [self.contentView addSubview:self.badgeView];
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(18);
    }];
    
    // 箭头
    self.arrowView = self.addImageView(10)
    .image(TLImage(@"right_arrow"))
    .masonry(^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(8, 13));
        make.right.mas_equalTo(-15);
    })
    .view;
    
    // 右图
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(-EGDE_RIGHT_IMAGE);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(WIDTH_ICON_RIGHT);
    }];
    
    // 描述
    self.detailLabel = self.addLabel(4)
    .font([UIFont systemFontOfSize:14.0f]).textColor([UIColor grayColor])
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_greaterThanOrEqualTo(self.badgeView.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(-WIDTH_ICON_RIGHT - EGDE_RIGHT_IMAGE - EGDE_SUB_TITLE);
        make.centerY.mas_equalTo(self.iconView);
    })
    .view;
    
    [self.detailLabel setContentCompressionResistancePriority:500 forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabel setContentCompressionResistancePriority:600 forAxis:UILayoutConstraintAxisHorizontal];
}

#pragma mark - # Getters
- (TLBadge *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[TLBadge alloc] initWithFrame:CGRectMake(0, 0, 0, 18)];
    }
    return _badgeView;
}

- (UIImageView *)rightImageView
{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        
        {
            [_rightImageView addSubview:self.rightBadgeView];
            [self.rightBadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(_rightImageView.mas_right);
                make.centerY.mas_equalTo(_rightImageView.mas_top).mas_offset(1);
                make.size.mas_equalTo(8);
            }];
        }
    }
    return _rightImageView;
}

- (TLBadge *)rightBadgeView
{
    if (!_rightBadgeView) {
        _rightBadgeView = [[TLBadge alloc] initWithFrame:CGRectMake(0, 0, 0, 18)];
        [_rightBadgeView setBadgeValue:@""];
    }
    return _rightBadgeView;
}

@end
