//
//  ZZFlexibleLayoutViewModel+HostView.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/1/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import <UIKit/UIKit.h>

@interface ZZFlexibleLayoutViewModel (HostView)

/**
 获取实际展示大小
 */
- (CGSize)visableSizeForHostView:(__kindof UIView *)hostView;

/**
 执行配置方法
 */
- (void)excuteConfigActionForPageControler:(id)pageController
                                  hostView:(__kindof UIView *)hostView
                                  itemView:(__kindof UIView<ZZFlexibleLayoutViewProtocol> *)itemView
                              sectionCount:(NSInteger)sectionCount
                                 indexPath:(NSIndexPath *)indexPath;

/**
 执行选中方法
 */
- (void)excuteSelectedActionForHostView:(__kindof UIView *)hostView;

@end
