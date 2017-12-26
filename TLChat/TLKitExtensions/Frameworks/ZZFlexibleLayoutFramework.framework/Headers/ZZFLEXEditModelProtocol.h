//
//  ZZFLEXEditModelProtocol.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZZFLEXEditModelProtocol <NSObject>

@required;
/// 映射关系
- (NSDictionary *)relationMap;

/// 检查输入合法性
- (NSError *)checkInputlegitimacy;

/// 执行关系映射（将editModel中的值赋给sourceModel）
- (void)executeRelationalMapping;

@optional;
/// 执行反向映射（将sourceModel中的值赋给editModel）
- (void)executeReverseRelationalMapping;

@end
