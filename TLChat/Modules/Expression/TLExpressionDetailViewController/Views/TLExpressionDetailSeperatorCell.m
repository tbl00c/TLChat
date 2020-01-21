//
//  TLExpressionDetailSeperatorCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailSeperatorCell.h"

@implementation TLExpressionDetailSeperatorCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(SCREEN_WIDTH, 20);
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI
{
    UIView *line1 = self.contentView.addView(1).backgroundColor([UIColor colorGrayLine]).view;
    UIView *line2 = self.contentView.addView(2).backgroundColor([UIColor colorGrayLine]).view;
    UILabel *label = self.contentView.addLabel(3)
    .backgroundColor([UIColor whiteColor]).clipsToBounds(YES)
    .textColor([UIColor colorGrayLine]).font([UIFont systemFontOfSize:12.0f])
    .text(LOCSTR(@"长按表情可预览")).view;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5.0f);
        make.left.mas_equalTo(line1.mas_right).mas_offset(5.0f);
        make.right.mas_equalTo(line2.mas_left).mas_offset(-5.0f);
    }];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BORDER_WIDTH_1PX);
        make.left.mas_equalTo(15.0f);
        make.centerY.mas_equalTo(label);
        make.width.mas_equalTo(line2);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BORDER_WIDTH_1PX);
        make.right.mas_equalTo(-15.0f);
        make.centerY.mas_equalTo(label);
    }];
}

@end
