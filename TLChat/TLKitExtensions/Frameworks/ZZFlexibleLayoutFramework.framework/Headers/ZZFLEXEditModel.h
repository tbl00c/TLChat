//
//  ZZFLEXEditModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZFLEXEditModelProtocol.h"

@interface ZZFLEXEditModel : NSObject <ZZFLEXEditModelProtocol>

@property (nonatomic, assign) NSInteger tag;

/// 映射关系
@property (nonatomic, strong) NSDictionary *relationMap;

/// 源Model
@property (nonatomic, strong) id sourceModel;

#pragma mark - # 较通用参数
/// 标题
@property (nonatomic, strong) NSString *title;
/// 占位符
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *placeholder1;

/// 是否展示右侧箭头（默认NO）
@property (nonatomic, assign) BOOL showArrow;

/// 用户输入值1
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id value1;
@property (nonatomic, strong) id value2;
@property (nonatomic, strong) id value3;

- (id)initWithTag:(NSInteger)tag
      sourceModel:(id)sourceModel
      relationMap:(NSDictionary *)relationMap
inputlegitimacyCheckAction:(NSError *(^)(ZZFLEXEditModel *model))inputlegitimacyCheckAction;


- (id)initWithTag:(NSInteger)tag
            title:(NSString *)title
      placeholder:(NSString *)placeholder
        showArrow:(BOOL)showArrow
      sourceModel:(id)sourceModel
      relationMap:(NSDictionary *)relationMap
inputlegitimacyCheckAction:(NSError *(^)(ZZFLEXEditModel *model))inputlegitimacyCheckAction;


@end

/// 创建EditModel
ZZFLEXEditModel *createFLEXEditModel(NSInteger tag, id sourceModel, NSDictionary *relationMap, NSError* (^inputlegitimacyCheckAction)(ZZFLEXEditModel *model));
/// 创建带有通用参数的EditModel
ZZFLEXEditModel *createFLEXEditModel2(NSInteger tag, NSString *title, NSString *placeholder, BOOL showArrow, id sourceModel, NSDictionary *relationMap, NSError* (^inputlegitimacyCheckAction)(ZZFLEXEditModel *model));
