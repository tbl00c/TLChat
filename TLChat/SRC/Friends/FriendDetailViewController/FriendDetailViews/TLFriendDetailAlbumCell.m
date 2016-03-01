//
//  TLFriendDetailAlbumCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailAlbumCell.h"
#import <UIImageView+WebCache.h>
#import "TLInfoMacros.h"

@interface TLFriendDetailAlbumCell ()

@property (nonatomic, strong) NSMutableArray *imageViewsArray;

@end

@implementation TLFriendDetailAlbumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageViewsArray = [[NSMutableArray alloc] init];
        [self.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)setInfo:(TLInfo *)info
{
    _info = info;
    [self.textLabel setText:info.title];
    NSArray *arr = info.userInfo;
    
    CGFloat spaceY = 12;
    NSUInteger count = (WIDTH_SCREEN - LEFT_INFOCELL_SUBTITLE_SPACE - 28) / (80 - spaceY * 2 + 3);
    count = arr.count <= count ? arr.count : count;
    CGFloat spaceX = (WIDTH_SCREEN - LEFT_INFOCELL_SUBTITLE_SPACE - 28 - count * (80 - spaceY * 2)) / count;
    spaceX = spaceX > 7 ? 7 : spaceX;
    for (int i = 0; i < count; i ++) {
        NSString *imageURL = arr[i];
        UIImageView *imageView;
        if (self.imageViewsArray.count <= i) {
            imageView = [[UIImageView alloc] init];
            [self.imageViewsArray addObject:imageView];
        }
        else {
            imageView = self.imageViewsArray[i];
        }
        [self.contentView addSubview:imageView];
        [imageView sd_setImageWithURL:TLURL(imageURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).mas_offset(spaceY);
            make.bottom.mas_equalTo(self.contentView).mas_offset(-spaceY);
            make.width.mas_equalTo(imageView.mas_height);
            if (i == 0) {
                make.left.mas_equalTo(LEFT_INFOCELL_SUBTITLE_SPACE);
            }
            else {
                make.left.mas_equalTo([self.imageViewsArray[i - 1] mas_right]).mas_offset(spaceX);
            }
        }];
    }
}

@end
