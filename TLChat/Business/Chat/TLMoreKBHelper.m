//
//  TLMoreKBHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMoreKBHelper.h"
#import "TLMoreKeyboardItem.h"

@implementation TLMoreKBHelper

- (id) init
{
    if (self = [super init]) {
        self.chatMoreKeyboardData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    TLMoreKeyboardItem *imageItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeImage
                                                               title:@"照片"
                                                           imagePath:@"moreKB_image"];
    TLMoreKeyboardItem *cameraItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeCamera
                                                                title:@"拍摄"
                                                            imagePath:@"moreKB_video"];
    TLMoreKeyboardItem *videoItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeVideo
                                                               title:@"小视频"
                                                           imagePath:@"moreKB_sight"];
    TLMoreKeyboardItem *videoCallItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeVideoCall
                                                                   title:@"视频聊天"
                                                               imagePath:@"moreKB_video_call"];
    TLMoreKeyboardItem *walletItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeWallet
                                                                title:@"红包"
                                                            imagePath:@"moreKB_wallet"];
    TLMoreKeyboardItem *transferItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeTransfer
                                                                  title:@"转账"
                                                              imagePath:@"moreKB_pay"];
    TLMoreKeyboardItem *positionItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypePosition
                                                                  title:@"位置"
                                                              imagePath:@"moreKB_location"];
    TLMoreKeyboardItem *favoriteItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeFavorite
                                                                  title:@"收藏"
                                                              imagePath:@"moreKB_favorite"];
    TLMoreKeyboardItem *businessCardItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeBusinessCard
                                                                      title:@"个人名片"
                                                                  imagePath:@"moreKB_friendcard" ];
    TLMoreKeyboardItem *voiceItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeVoice
                                                               title:@"语音输入"
                                                           imagePath:@"moreKB_voice"];
    TLMoreKeyboardItem *cardsItem = [TLMoreKeyboardItem createByType:TLMoreKeyboardItemTypeCards
                                                               title:@"卡券"
                                                           imagePath:@"moreKB_wallet"];
    [self.chatMoreKeyboardData addObjectsFromArray:@[imageItem, cameraItem, videoItem, videoCallItem, walletItem, transferItem, positionItem, favoriteItem, businessCardItem, voiceItem, cardsItem]];
}

@end
