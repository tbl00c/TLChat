//
//  TLTabBarControllerProtocol.h
//  TLKit
//
//  Created by 李伯坤 on 2017/7/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

/**
 * 加入到TLTabBarController中的VC选择遵循的协议
 */

#import <Foundation/Foundation.h>

@protocol TLTabBarControllerProtocol <NSObject>

@optional;
/**
 *  tabBar被单击
 *
 *  @param  isSelected      是否已经选中
 */
- (void)tabBarItemDidClick:(BOOL)isSelected;

/**
 *  tabBar被双击（仅在已选中时调用）
 */
- (void)tabBarItemDidDoubleClick;

@end
