//
//  TLExpressionHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionHelper.h"
#import "TLDBExpressionStore.h"
#import "TLEmojiKBHelper.h"
#import "TLUserHelper.h"
#import "NSFileManager+TLChat.h"

@interface TLExpressionHelper ()

@property (nonatomic, strong) TLDBExpressionStore *store;

@end

@implementation TLExpressionHelper
@synthesize defaultFaceGroup = _defaultFaceGroup;
@synthesize defaultSystemEmojiGroup = _defaultSystemEmojiGroup;
@synthesize userEmojiGroups = _userEmojiGroups;

+ (TLExpressionHelper *)sharedHelper
{
    static TLExpressionHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[TLExpressionHelper alloc] init];
    });
    return helper;
}

- (NSArray *)userEmojiGroups
{
    return [self.store expressionGroupsByUid:[TLUserHelper sharedHelper].userID];
}

- (BOOL)addExpressionGroup:(TLExpressionGroupModel *)emojiGroup
{
    BOOL ok = [self.store addExpressionGroup:emojiGroup forUid:[TLUserHelper sharedHelper].userID];
    if (ok) {       // 通知表情键盘
        [[TLEmojiKBHelper sharedKBHelper] updateEmojiGroupData];
    }
    return ok;
}

- (BOOL)deleteExpressionGroupByID:(NSString *)groupID
{
    TLExpressionGroupModel *groupModel = [self emojiGroupByID:groupID];
    BOOL ok = [self.store deleteExpressionGroupByID:groupID forUid:[TLUserHelper sharedHelper].userID];
    if (ok) {       // 通知表情键盘
        [[TLEmojiKBHelper sharedKBHelper] updateEmojiGroupData];
        
        BOOL canDeleteFile = ![self didExpressionGroupAlwaysInUsed:groupID];
        if (canDeleteFile) {
            NSError *error;
            ok = [[NSFileManager defaultManager] removeItemAtPath:groupModel.path error:&error];
            if (!ok) {
                DDLogError(@"删除表情文件失败\n路径:%@\n原因:%@", groupModel.path, [error description]);
            }
        }
    }
    return ok;
}

- (BOOL)didExpressionGroupAlwaysInUsed:(NSString *)groupID
{
    NSInteger count = [self.store countOfUserWhoHasExpressionGroup:groupID];
    return count > 0;
}

- (TLExpressionGroupModel *)emojiGroupByID:(NSString *)groupID;
{
    for (TLExpressionGroupModel *group in self.userEmojiGroups) {
        if ([group.gId isEqualToString:groupID]) {
            return group;
        }
    }
    return nil;
}

- (void)downloadExpressionsWithGroupInfo:(TLExpressionGroupModel *)group
                                progress:(void (^)(CGFloat))progress
                                 success:(void (^)(TLExpressionGroupModel *))success
                                 failure:(void (^)(TLExpressionGroupModel *, NSString *))failure
{
    group.type = TLEmojiTypeImageWithTitle;
    dispatch_queue_t downloadQueue = dispatch_queue_create([group.gId UTF8String], nil);
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    __block CGFloat p = 0;
    for (int i = 0; i <= group.data.count; i++) {
        dispatch_group_async(downloadGroup, downloadQueue, ^{
            NSString *groupPath = [NSFileManager pathExpressionForGroupID:group.gId];
            NSString *emojiPath;
            NSData *data = nil;
            if (i == group.data.count) {
                emojiPath = [NSString stringWithFormat:@"%@icon_%@", groupPath, group.gId];
                data = [NSData dataWithContentsOfURL:TLURL(group.iconURL)];
            }
            else {
                TLExpressionModel *emoji = group.data[i];
                NSString *urlString = [TLExpressionModel expressionDownloadURLWithEid:emoji.eId];
                data = [NSData dataWithContentsOfURL:TLURL(urlString)];
                if (data == nil) {
                    urlString = [TLExpressionModel expressionURLWithEid:emoji.eId];
                    data = [NSData dataWithContentsOfURL:TLURL(urlString)];
                }
                emojiPath = [NSString stringWithFormat:@"%@%@", groupPath, emoji.eId];
            }
            
            [data writeToFile:emojiPath atomically:YES];
            p += 1.0;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (progress) {
                    progress(p / group.data.count);
                }
            });
        });
    }
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        success(group);
    });
}

- (void)updateExpressionGroupModelsStatus:(NSArray *)groupModelArray
{
    for (TLExpressionGroupModel *group in groupModelArray) {
        TLExpressionGroupModel *localEmojiGroup = [[TLExpressionHelper sharedHelper] emojiGroupByID:group.gId];
        if (localEmojiGroup) {
            group.status = TLExpressionGroupStatusLocal;
        }
    }
}

#pragma mark - # Getter
- (TLDBExpressionStore *)store
{
    if (_store == nil) {
        _store = [[TLDBExpressionStore alloc] init];
    }
    return _store;
}

- (TLExpressionGroupModel *)defaultFaceGroup
{
    if (_defaultFaceGroup == nil) {
        _defaultFaceGroup = [[TLExpressionGroupModel alloc] init];
        _defaultFaceGroup.type = TLEmojiTypeFace;
        _defaultFaceGroup.iconPath = @"emojiKB_group_face";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"FaceEmoji" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        _defaultFaceGroup.data = [TLExpressionModel mj_objectArrayWithKeyValuesArray:data];
        for (TLExpressionModel *emoji in _defaultFaceGroup.data) {
            emoji.type = TLEmojiTypeFace;
        }
    }
    return _defaultFaceGroup;
}

- (TLExpressionGroupModel *)defaultSystemEmojiGroup
{
    if (_defaultSystemEmojiGroup == nil) {
        _defaultSystemEmojiGroup = [[TLExpressionGroupModel alloc] init];
        _defaultSystemEmojiGroup.type = TLEmojiTypeEmoji;
        _defaultSystemEmojiGroup.iconPath = @"emojiKB_group_face";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SystemEmoji" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        _defaultSystemEmojiGroup.data = [TLExpressionModel mj_objectArrayWithKeyValuesArray:data];
    }
    return _defaultSystemEmojiGroup;
}

@end

