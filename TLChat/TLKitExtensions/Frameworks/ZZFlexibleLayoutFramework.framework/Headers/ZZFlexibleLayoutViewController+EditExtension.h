//
//  ZZFlexibleLayoutViewController+EditExtension.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"

extern NSString *const ZZFLEXEditErrorDomain;

/**
 *  ZZFLEX关于实现编辑界面的拓展
 *
 *  设计思路及使用方法：
 *  1、所有编辑数据，会暂存的dataModel中。用户点“确认”后，执行以下两步骤：
 *    第一步：调用 checkInputlegitimacy 检查用户输入的合法性
 *    第二步：在合法性验证通过后，执行 executeRelationalMapping 方法，将用于输入的内容映射到SourceModel中
 *  2、所有编辑cell/view使用的editModel，必须实现ZZFLEXEditModelProtocol协议(或者直接继承ZZFLEXEditModel)
 *    当用户对输入后，有两种可选方案：
 *    第一种：将结果暂存到editModel中，用户点"确定"后，
 *    通过此协议，将输入的合法性检测、对sourceModel的赋值分散到各Model当中
 *
 */

@interface ZZFlexibleLayoutViewController (EditExtension)

/**
 *  检查用户输入的合法性(自上而下)
 *  是否是输入项的判断条件是，DataModel是否实现了ZZFLEXEditModelProtocol协议
 *
 *  @return 出错信息，若为nil表示成功
 */
- (NSError *)checkInputlegitimacy;

/**
 *  执行关系映射
 *  在确认用户输入合法后，将用户输入的信息写入SourceModel中，以用于后续操作
 */
- (void)executeRelationalMapping;

@end
