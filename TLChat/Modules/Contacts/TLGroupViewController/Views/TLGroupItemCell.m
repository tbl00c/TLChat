//
//  TLGroupItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupItemCell.h"
#import "NSFileManager+TLChat.h"
#import "TLMacros.h"

@interface TLGroupItemCell ()

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation TLGroupItemCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 60.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setGroup:dataModel];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == count - 1) {
        self.addSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(15);
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initUI];
    }
    return self;
}

- (void)setGroup:(TLGroup *)group
{
    _group = group;
    NSString *path = [NSFileManager pathUserAvatar:group.groupAvatarPath];
    UIImage *image = [UIImage imageNamed:path];
    if (image == nil) {
        image = [UIImage imageNamed:DEFAULT_AVATAR_PATH];
    }
    [self.avatarView setImage:image];
    [self.nameLabel setText:group.groupName];
}

#pragma mark - # Private Methods
- (void)p_initUI
{
    self.avatarView = self.contentView.addImageView(1)
    .masonry(^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    })
    .view;
    [self.avatarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.avatarView.mas_height);
    }];
    
    self.nameLabel = self.contentView.addLabel(2)
    .font([UIFont systemFontOfSize:17.0f])
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.avatarView);
        make.right.mas_lessThanOrEqualTo(-20);
    })
    .view;
}

@end
