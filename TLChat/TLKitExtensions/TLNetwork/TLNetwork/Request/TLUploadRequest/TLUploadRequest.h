//
//  TLUploadRequest.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLBaseRequest.h"

@interface TLUploadRequest : TLBaseRequest

#pragma mark - 必传参数
/// 文件数据
@property (nonatomic, strong) NSData *data;
/// 文件路径（优先使用data）
@property (nonatomic, strong) NSString *dataPath;
/// 上传进度
@property (nonatomic, copy) TLRequestProgressBlock uploadProgressAction;

#pragma mark - 多表单相关
/// 将分片数据组成完整数据
@property (nonatomic, copy) TLConstructingBlock constructingBodyAction;

@end
