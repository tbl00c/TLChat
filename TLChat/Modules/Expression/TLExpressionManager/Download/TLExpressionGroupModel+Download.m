//
//  TLExpressionGroupModel+Download.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/2.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionGroupModel+Download.h"
#import "TLExpressionGroupModel+DetailRequest.h"
#import "TLExpressionHelper.h"
#import "NSFileManager+TLChat.h"

@implementation TLExpressionGroupModel (Download)

- (void)startDownload
{
    self.status = TLExpressionGroupStatusDownloading;
    if (self.data.count == 0) {
        self.data = @[].mutableCopy;
        [self requestDetailInfoWithPageIndex:1];
    }
    else {
        [self p_startDownload];
    }
}

- (void)requestDetailInfoWithPageIndex:(NSInteger)pageIndex
{
    [self requestExpressionGroupDetailByPageIndex:pageIndex success:^(NSArray *successData) {
        if (successData.count > 0) {
            [self.data addObjectsFromArray:successData];

            [self p_startDownload];
        }
        else {
            self.status = TLExpressionGroupStatusNet;
            if (self.downloadCompleteAction) {
                self.downloadCompleteAction(self, NO, @"表情包数据错误");
            }
        }
    } failure:^(id failureData) {
        self.status = TLExpressionGroupStatusNet;
        if (self.downloadCompleteAction) {
            self.downloadCompleteAction(self, NO, @"获取表情包信息失败");
        }
    }];
}

- (void)p_startDownload
{
    [[TLExpressionHelper sharedHelper] downloadExpressionsWithGroupInfo:self progress:^(CGFloat progress) {
        self.downloadProgress = progress;
        if (self.downloadProgressAction) {
            self.downloadProgressAction(self, progress);
        }
    } success:^(TLExpressionGroupModel *group) {
        self.status = TLExpressionGroupStatusLocal;
        [[TLExpressionHelper sharedHelper] addExpressionGroup:group];
        if (self.downloadCompleteAction) {
            self.downloadCompleteAction(group, YES, nil);
        }
    } failure:^(TLExpressionGroupModel *group, NSString *error) {
        self.status = TLExpressionGroupStatusNet;
        if (self.downloadCompleteAction) {
            self.downloadCompleteAction(group, NO, error);
        }
    }];
}


@end
