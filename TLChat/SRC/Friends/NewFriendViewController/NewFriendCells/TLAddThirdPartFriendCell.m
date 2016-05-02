//
//  TLAddThirdPartFriendCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAddThirdPartFriendCell.h"
#import "TLAddThirdPartFriendItem.h"
#import "UIView+Extensions.h"

@interface TLAddThirdPartFriendCell ()

@property (nonatomic, strong) NSDictionary *itemsDic;

@property (nonatomic, strong) TLAddThirdPartFriendItem *contacts;

@property (nonatomic, strong) TLAddThirdPartFriendItem *qq;

@property (nonatomic, strong) TLAddThirdPartFriendItem *google;

@end

@implementation TLAddThirdPartFriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBottomLineStyle:TLCellLineStyleFill];
        _itemsDic = @{
                      TLThirdPartFriendTypeContacts : self.contacts,
                      TLThirdPartFriendTypeQQ : self.qq,
                      TLThirdPartFriendTypeGoogle : self.google};
    }
    return self;
}

- (void)setThridPartItems:(NSArray *)thridPartItems
{
    if (_thridPartItems == thridPartItems) {
        return;
    }
    _thridPartItems = thridPartItems;
    TLAddThirdPartFriendItem *lastItem;
    [self.contentView removeAllSubViews];
    for (int i = 0; i < thridPartItems.count; i++) {
        NSString *keyStr = [thridPartItems objectAtIndex:i];
        TLAddThirdPartFriendItem *item = [self.itemsDic objectForKey:keyStr];
        [self.contentView addSubview:item];
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.mas_equalTo(self.contentView);
        }];
        if (i == 0) {
            [item mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView);
            }];
        }
        else {
            [item mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastItem.mas_right);
                make.width.mas_equalTo(lastItem);
            }];
        }
        if (i == self.thridPartItems.count - 1) {
            [item mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.contentView);
            }];
        }
        lastItem = item;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorGrayLine].CGColor);
    CGContextBeginPath(context);
    if (self.thridPartItems.count == 2) {
        CGContextMoveToPoint(context, self.width / 2.0, 0);
        CGContextAddLineToPoint(context, self.width / 2.0, self.height);
    }
    else if (self.thridPartItems.count == 3) {
        CGContextMoveToPoint(context, self.width / 3.0, 0);
        CGContextAddLineToPoint(context, self.width / 3.0, self.height);
        CGContextMoveToPoint(context, self.width / 3.0 * 2, 0);
        CGContextAddLineToPoint(context, self.width / 3.0 * 2, self.height);
    }
    CGContextStrokePath(context);
}

#pragma mark - Event Response -
- (void)itemButtonDown:(TLAddThirdPartFriendItem *)item
{
    if (_delegate && [_delegate respondsToSelector:@selector(addThirdPartFriendCellDidSelectedType:)]) {
        [_delegate addThirdPartFriendCellDidSelectedType:item.itemTag];
    }
}

#pragma mark - Getter -
- (TLAddThirdPartFriendItem *)contacts
{
    if (_contacts == nil) {
        _contacts = [[TLAddThirdPartFriendItem alloc] initWithImagePath:@"newFriend_contacts" andTitle:@"添加手机联系人"];
        _contacts.itemTag = [TLThirdPartFriendTypeContacts copy];
        [_contacts addTarget:self action:@selector(itemButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contacts;
}

- (TLAddThirdPartFriendItem *)qq
{
    if (_qq == nil) {
        _qq = [[TLAddThirdPartFriendItem alloc] initWithImagePath:@"newFriend_qq" andTitle:@"添加QQ好友"];
        _qq.itemTag = [TLThirdPartFriendTypeQQ copy];
        [_qq addTarget:self action:@selector(itemButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qq;
}

- (TLAddThirdPartFriendItem *)google
{
    if (_google == nil) {
        _google = [[TLAddThirdPartFriendItem alloc] initWithImagePath:@"newFriend_google" andTitle:@"添加Google好友"];
        _google.itemTag = [TLThirdPartFriendTypeGoogle copy];
        [_google addTarget:self action:@selector(itemButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _google;
}

@end
