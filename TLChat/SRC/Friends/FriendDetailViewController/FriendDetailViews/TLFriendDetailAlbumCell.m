//
//  TLFriendDetailAlbumCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailAlbumCell.h"
#import <UIImageView+WebCache.h>

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
    for (int i = 0; i < arr.count; i ++) {
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
    }
}

@end
