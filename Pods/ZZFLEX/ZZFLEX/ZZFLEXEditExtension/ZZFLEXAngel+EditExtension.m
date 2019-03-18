//
//  ZZFLEXAngel+EditExtension.m
//  ZZFLEXDemo
//
//  Created by lbk on 2018/2/5.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import "ZZFLEXAngel+EditExtension.h"
#import "ZZFLEXEditModelProtocol.h"

@implementation ZZFLEXAngel (EditExtension)

- (NSError *)checkInputlegitimacy
{
    for (id<ZZFLEXEditModelProtocol> model in self.dataModelArray.all()) {
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
    for (id<ZZFLEXEditModelProtocol> model in self.dataModelArray.all()) {
        if ([model respondsToSelector:@selector(excuteCompleteAction)]) {
            [model excuteCompleteAction];
        }
    }
}

@end
