//
//  TLNewFriendFuncationCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLNewFriendFuncationCell.h"
#import "UIView+Extensions.h"

TLNewFriendFuncationModel *createNewFriendFuncationModel(NSString *icon, NSString *title)
{
    TLNewFriendFuncationModel *model = [[TLNewFriendFuncationModel alloc] init];
    model.iconPath = icon;
    model.title = title;
    return model;
}

@interface TLNewFriendFuncationCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation TLNewFriendFuncationCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 80;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setModel:dataModel];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self p_initUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.addSeparator(ZZSeparatorPositionBottom).borderWidth(1);
}

- (void)setModel:(TLNewFriendFuncationModel *)model
{
    _model = model;
    [self.iconView setImage:TLImage(model.iconPath)];
    [self.nameLabel setText:model.title];
}

#pragma mark - # Private Methods
- (void)p_initUI
{
    self.iconView = self.contentView.addImageView(1)
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(36);
    })
    .view;
    
    self.nameLabel = self.contentView.addLabel(2)
    .font([UIFont systemFontOfSize:12])
    .textColor([UIColor grayColor])
    .masonry(^ (MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.centerX.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(self.contentView).mas_offset(-30);
    })
    .view;
}

@end

@implementation TLNewFriendFuncationModel

@end
