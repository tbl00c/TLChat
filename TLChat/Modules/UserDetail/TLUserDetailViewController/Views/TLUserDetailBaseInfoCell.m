//
//  TLUserDetailBaseInfoCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUserDetailBaseInfoCell.h"
#import "TLUser.h"
#import "TLMacros.h"

#define     MINE_SPACE_X        14.0f
#define     MINE_SPACE_Y        12.0f

@interface TLUserDetailBaseInfoCell ()

@property (nonatomic, strong) UIButton *avatarView;
@property (nonatomic, strong) UILabel *shownameLabel;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *nikenameLabel;

@property (nonatomic, copy) id (^eventAction)(NSInteger, id);

@end

@implementation TLUserDetailBaseInfoCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 90.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setUserModel:dataModel];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == 0) {
        self.addSeparator(ZZSeparatorPositionTop);
    }
    
    if (indexPath.row == count - 1) {
        self.addSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(15);
    }
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self p_initUI];
    }
    return self;
}

- (void)setUserModel:(TLUser *)userModel
{
    _userModel = userModel;
    if (userModel.avatarPath) {
        [self.avatarView setImage:[UIImage imageNamed:userModel.avatarPath] forState:UIControlStateNormal];
    }
    else{
        [self.avatarView tt_setImageWithURL:TLURL(userModel.avatarURL) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    [self.shownameLabel setText:userModel.showName];
    if (userModel.username.length > 0) {
        [self.usernameLabel setText:[NSString stringWithFormat:@"%@：%@", LOCSTR(@"微信号"), userModel.username]];
        if (userModel.nikeName.length > 0) {
            [self.nikenameLabel setText:[NSString stringWithFormat:@"%@：%@", LOCSTR(@"昵称"), userModel.nikeName]];
        }
    }
    else if (userModel.nikeName.length > 0){
        [self.nikenameLabel setText:[NSString stringWithFormat:@"%@：%@", LOCSTR(@"昵称"), userModel.nikeName]];
    }
}

#pragma mark - # UI
- (void)p_initUI
{
    @weakify(self);
    
    // 头像
    self.avatarView = self.contentView.addButton(1)
    .cornerRadius(5)
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        if (self.eventAction) {
            self.eventAction(0, self.userModel);
        }
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
    })
    .view;
    
    [self.avatarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.avatarView.mas_height);
    }];
    
    // 用户昵称
    self.shownameLabel = self.contentView.addLabel(2)
    .font([UIFont systemFontOfSize:17.0f])
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(MINE_SPACE_Y);
        make.top.mas_equalTo(self.avatarView.mas_top).mas_offset(3);
    })
    .view;
    [self.shownameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    
    // 用户名
    self.usernameLabel = self.contentView.addLabel(3)
    .font([UIFont systemFontOfSize:14.0f])
    .textColor([UIColor grayColor])
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shownameLabel);
        make.top.mas_equalTo(self.shownameLabel.mas_bottom).mas_offset(5);
    })
    .view;
    
    // 昵称
    self.nikenameLabel = self.contentView.addLabel(4)
    .textColor([UIColor grayColor])
    .font([UIFont systemFontOfSize:14.0f])
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shownameLabel);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(3);
    })
    .view;
}

@end
