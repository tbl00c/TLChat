//
//  ZZFLEXEditModel.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFLEXEditModel.h"

NSString *const ZZFLEXEditErrorDomain = @"ZZFLEXEditErrorDomain";

@interface ZZFLEXEditModel ()

/// 输入合法性检查，ZZFLEXEditModelProtocol中checkInputlegitimacy方法，默认执行此block
@property (nonatomic, copy) NSError* (^inputlegitimacyCheckAction)(ZZFLEXEditModel *model);

/// 输入完成执行此block，给sourceModel赋值
@property (nonatomic, copy) void (^completetAction)(ZZFLEXEditModel *model);

@property (nonatomic, strong) NSDictionary *cache;

@end

@implementation ZZFLEXEditModel

- (NSError *)checkInputlegitimacy
{
    if (self.inputlegitimacyCheckAction) {
        return self.inputlegitimacyCheckAction(self);
    }
    return nil;
}

- (void)excuteCompleteAction
{
    if (self.completetAction) {
        self.completetAction(self);
    }
}

@end

ZZFLEXEditModel *createFLEXEditModel(NSInteger tag, id titleModel, id placeholderModel, id value, id sourceModel, NSError* (^inputlegitimacyCheckAction)(ZZFLEXEditModel *model), void (^completetAction)(ZZFLEXEditModel *model))
{
    ZZFLEXEditModel *model = [[ZZFLEXEditModel alloc] init];
    model.tag = tag;
    model.titleModel = titleModel;
    model.placeholderModel = placeholderModel;
    model.value = value;
    model.sourceModel = sourceModel;
    model.inputlegitimacyCheckAction = inputlegitimacyCheckAction;
    model.completetAction = completetAction;
    return model;
}

