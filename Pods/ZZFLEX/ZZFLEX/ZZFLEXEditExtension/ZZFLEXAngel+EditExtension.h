//
//  ZZFLEXAngel+EditExtension.h
//  ZZFLEXDemo
//
//  Created by lbk on 2018/2/5.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import "ZZFLEXAngel.h"

@interface ZZFLEXAngel (EditExtension)

/**
 *  检查用户输入的合法性(自上而下)
 *  是否是输入项的判断条件是，DataModel是否实现了ZZFLEXEditModelProtocol协议
 *
 *  @return 出错信息，若为nil表示成功
 */
- (NSError *)checkInputlegitimacy;

/**
 *  执行模型赋值操作
 */
- (void)excuteCompleteAction;

@end
