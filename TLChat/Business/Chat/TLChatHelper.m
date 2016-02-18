//
//  TLChatHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatHelper.h"
#import "TLChatMoreKeyboardItem.h"

@implementation TLChatHelper

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
    TLChatMoreKeyboardItem *imageItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeImage
                                                                       title:@"照片"
                                                                   imagePath:@"sharemore_pic"];
    TLChatMoreKeyboardItem *cameraItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeCamera
                                                                        title:@"拍摄"
                                                                    imagePath:@"sharemore_video"];
    TLChatMoreKeyboardItem *videoItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeVideo
                                                                       title:@"小视频"
                                                                   imagePath:@"sharemore_sight"];
    TLChatMoreKeyboardItem *videoCallItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeVideoCall
                                                                           title:@"视频聊天"
                                                                       imagePath:@"sharemore_videovoip"];
    TLChatMoreKeyboardItem *walletItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeWallet
                                                                        title:@"红包"
                                                                    imagePath:@"sharemore_wallet"];
    TLChatMoreKeyboardItem *transferItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeTransfer
                                                                          title:@"转账"
                                                                      imagePath:@"sharemorePay"];
    TLChatMoreKeyboardItem *positionItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypePosition
                                                                          title:@"位置"
                                                                      imagePath:@"sharemore_location"];
    TLChatMoreKeyboardItem *favoriteItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeFavorite
                                                                          title:@"收藏"
                                                                      imagePath:@"sharemore_myfav"];
    TLChatMoreKeyboardItem *businessCardItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeBusinessCard
                                                                              title:@"个人名片"
                                                                          imagePath:@"sharemore_friendcard" ];
    TLChatMoreKeyboardItem *voiceItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeVoice
                                                                       title:@"语音输入"
                                                                   imagePath:@"sharemore_voiceinput"];
    TLChatMoreKeyboardItem *cardsItem = [TLChatMoreKeyboardItem createByType:TLChatMoreKeyboardItemTypeCards
                                                                       title:@"卡券"
                                                                   imagePath:@"sharemore_wallet"];
    [self.chatMoreKeyboardData addObjectsFromArray:@[imageItem, cameraItem, videoItem, videoCallItem, walletItem, transferItem, positionItem, favoriteItem, businessCardItem, voiceItem, cardsItem]];
}

@end
