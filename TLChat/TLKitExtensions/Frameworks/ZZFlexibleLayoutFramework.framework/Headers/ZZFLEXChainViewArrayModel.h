//
//  ZZFLEXChainViewArrayModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZFLEXChainViewArrayModel : NSObject

- (ZZFLEXChainViewArrayModel *(^)(NSInteger section))toSection;
- (ZZFLEXChainViewArrayModel *(^)(NSArray *dataModelArray))withDataModelArray;
- (ZZFLEXChainViewArrayModel *(^)(id ((^)(NSInteger actionType, id data))))eventAction;
- (ZZFLEXChainViewArrayModel *(^)(NSInteger viewTag))viewTag;

- (id)initWithClassName:(NSString *)className listData:(NSMutableArray *)listData;

@end
