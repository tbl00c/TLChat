//
//  TLTagItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTagItemCell.h"
#import "TLUserGroup.h"

@interface TLTagItemCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLTagItemCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 55.0f;
}

- (void)setViewDataModel:(TLUserGroup *)dataModel
{
    [self.titleLabel setText:[NSString stringWithFormat:@"%@(%ld)", dataModel.groupName, dataModel.users.count]];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == 0) {
        self.addSeparator(TLSeparatorPositionTop);
    }
    else {
        self.removeSeparator(TLSeparatorPositionTop);
    }
    if (indexPath.row == count - 1) {
        self.addSeparator(TLSeparatorPositionBottom);
    }
    else {
        self.addSeparator(TLSeparatorPositionBottom).beginAt(15);
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = self.contentView.addLabel(1).font([UIFont systemFontOfSize:15.0f])
        .masonry(^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_lessThanOrEqualTo(-15);
            make.centerY.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
