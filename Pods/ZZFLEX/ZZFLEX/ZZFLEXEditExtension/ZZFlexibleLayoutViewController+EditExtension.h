//
//  ZZFlexibleLayoutViewController+EditExtension.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"

@interface ZZFlexibleLayoutViewController (EditExtension)

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
