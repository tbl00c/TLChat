//
//  ZZFLEXEditModelProtocol.h
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZZFLEXEditModelProtocol <NSObject>

@required;
/// 检查输入合法性
- (NSError *)checkInputlegitimacy;

- (void)excuteCompleteAction;


@end
