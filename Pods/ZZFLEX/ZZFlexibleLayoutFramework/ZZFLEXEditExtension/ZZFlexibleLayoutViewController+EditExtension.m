//
//  ZZFlexibleLayoutViewController+EditExtension.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFlexibleLayoutViewController+EditExtension.h"
#import "ZZFLEXEditModelProtocol.h"

@implementation ZZFlexibleLayoutViewController (EditExtension)

- (NSError *)checkInputlegitimacy
{
    NSArray *data = self.dataModelArray.all();
    for (id<ZZFLEXEditModelProtocol> model in data) {
        if ([model respondsToSelector:@selector(checkInputlegitimacy)]) {
            NSError *error = [model checkInputlegitimacy];
            if (error) {
                return error;
            }
        }
    }
    
    return nil;
}

- (void)excuteCompleteAction
{
    NSArray *data = self.dataModelArray.all();
    for (id<ZZFLEXEditModelProtocol> model in data) {
        if ([model respondsToSelector:@selector(excuteCompleteAction)]) {
            [model excuteCompleteAction];
        }
    }
}

@end
