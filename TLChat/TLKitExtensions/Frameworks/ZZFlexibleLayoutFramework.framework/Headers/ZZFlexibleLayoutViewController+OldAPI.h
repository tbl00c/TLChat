//
//  ZZFlexibleLayoutViewController+OldAPI.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"

@interface ZZFlexibleLayoutViewController (OldAPI)

/// 添加section
- (NSInteger)addSectionWithTag:(NSInteger)tag;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing;
- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets;

- (NSInteger)addSectionWithTag:(NSInteger)tag backgroundColor:(UIColor *)backgroundColor;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor;
- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor;


/// 为section添加headerView
- (BOOL)setSectionHeaderViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className;
/// 为section添加footerView
- (BOOL)setSectionFooterViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className;


/// 为指定section添加cell（若section不存在将自动添加）
- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className;
- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag;

/// 为指定section批量添加cell(相同class，若section不存在将自动添加)
- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className;
- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag;

@end


#pragma mark - ## ZZFlexibleLayoutViewController (OldSeperatorAPI)
@interface ZZFlexibleLayoutViewController (OldSeperatorAPI)

/// 添加默认的分割线cell（SCREENWIDTH，10）
- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag;
- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size;
- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withColor:(UIColor *)color;
- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size andColor:(UIColor *)color;

@end
