//
//  ZZFLEXEditModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZFLEXEditModelProtocol.h"

extern NSString *const ZZFLEXEditErrorDomain;

/// 创建EditModel
@class ZZFLEXEditModel;
ZZFLEXEditModel *createFLEXEditModel(NSInteger tag,
                                     id titleModel,
                                     id placeholderModel,
                                     id value,
                                     id sourceModel,
                                     NSError* (^inputlegitimacyCheckAction)(ZZFLEXEditModel *model),
                                     void (^completetAction)(ZZFLEXEditModel *model));

@interface ZZFLEXEditModel : NSObject <ZZFLEXEditModelProtocol>

@property (nonatomic, assign) NSInteger tag;

/// 源Model
@property (nonatomic, strong) id sourceModel;

#pragma mark - # 通用参数
/// 标题模型
@property (nonatomic, strong) id titleModel;
@property (nonatomic, strong) id titleModel1;
@property (nonatomic, strong) id titleModel2;
@property (nonatomic, strong) id titleModel3;

/// 占位符模型
@property (nonatomic, strong) id placeholderModel;
@property (nonatomic, strong) id placeholderModel1;
@property (nonatomic, strong) id placeholderModel2;
@property (nonatomic, strong) id placeholderModel3;

/// 自定义信息模型
@property (nonatomic, strong) id userInfo;

/// 用户输入值
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id value1;
@property (nonatomic, strong) id value2;
@property (nonatomic, strong) id value3;

@end
