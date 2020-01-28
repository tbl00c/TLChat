//
//  TLActionSheet.h
//  TLKit
//
//  Created by 李伯坤 on 2020/1/26.
//

/*
 自定义ActionSheet
 
 无任何依赖，可直接独立使用
 */

#import <UIKit/UIKit.h>

#pragma mark - # TLActionSheetItem
@class TLActionSheet;
@class TLActionSheetItem;
typedef void (^TLActionSheetItemClickAction)(TLActionSheet *actionSheet, TLActionSheetItem *item, NSInteger index);
typedef void (^TLActionSheetItemConfigAction)(TLActionSheet *actionSheet, __kindof UIView *view, TLActionSheetItem *item, NSInteger index);
typedef NS_ENUM(NSInteger, TLActionSheetItemType) {
    TLActionSheetItemTypeNormal = 0,
    TLActionSheetItemTypeCancel = 1,
    TLActionSheetItemTypeDestructive = 2,
    TLActionSheetItemTypeCustom = 3,
};

@interface TLActionSheetItem : NSObject

/// 类型
@property (nonatomic, assign) TLActionSheetItemType type;

/// 标题
@property (nonatomic, strong) NSString *title;
/// 副标题
@property (nonatomic, strong) NSString *message;
/// 点击事件
@property (nonatomic, copy) TLActionSheetItemClickAction clickAction;
/// 红点，空字符串显示数字，其他直接显示
//@property (nonatomic, strong) NSString *badge;
/// 自定义类型
@property (nonatomic, strong) UIView *customView;

@property (nonatomic, copy) TLActionSheetItemConfigAction configAction;

#pragma mark - 自定义项
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIFont *messageFont;

- (instancetype)initWithTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message clickAction:(TLActionSheetItemClickAction)clickAction;

@end

#pragma mark - # TLActionSheet
@interface TLActionSheet : UIView

/// 标题
@property (nonatomic, strong) NSString *title;
/// 自定义头部视图
@property (nonatomic, strong) UIView *customHeaderView;
/// 按钮（不包含取消按钮）
@property (nonatomic, strong, readonly) NSArray<TLActionSheetItem *> *items;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title items:(NSArray<TLActionSheetItem *> *)items;


- (void)addItem:(TLActionSheetItem *)item;

- (void)addItemWithTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction;
- (void)addItemWithTitle:(NSString *)title message:(NSString *)message clickAction:(TLActionSheetItemClickAction)clickAction;
- (void)addDestructiveItemWithTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction;
- (void)addCustomViewItem:(UIView *)customView clickAction:(TLActionSheetItemClickAction)clickAction;

- (void)setCancelItemTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction;

- (void)show;
- (void)dismiss;

/**
 *  根据index获取按钮标题
 *
 *  @param  buttonIndex     按钮index
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

#pragma mark - # 旧版本兼容
/// 点击事件响应block
@property (nonatomic, copy) void (^clickAction)(NSInteger buttonIndex);

- (id)initWithTitle:(NSString *)title
        clickAction:(void (^)(NSInteger buttonIndex))clickAction
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end

