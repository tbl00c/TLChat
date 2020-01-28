//
//  TLAlertView.h
//  TLKit
//
//  Created by 李伯坤 on 2020/1/27.
//

#import <UIKit/UIKit.h>

#pragma mark - # TLAlertViewItem
@class TLAlertView;
@class TLAlertViewItem;
typedef void (^TLAlertViewItemClickAction)(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index);
typedef void (^TLAlertViewTextFieldConfigAction)(TLAlertView *alertView, UITextField *textField);

typedef NS_ENUM(NSInteger, TLAlertViewItemType) {
    TLAlertViewItemTypeNormal = 0,
    TLAlertViewItemTypeCancel = 1,
    TLAlertViewItemTypeDestructive = 2,
};

@interface TLAlertViewItem : NSObject

/// 类型
@property (nonatomic, assign) TLAlertViewItemType type;

/// 标题
@property (nonatomic, strong) NSString *title;

/// 点击事件
@property (nonatomic, copy) TLAlertViewItemClickAction clickAction;

#pragma mark - 自定义项
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;

- (instancetype)initWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction;

@end

#pragma mark - # TLAlertView
@interface TLAlertView : UIView
/// 标题
@property (nonatomic, strong) NSString *title;
/// 正文
@property (nonatomic, strong) NSString *message;
/// 按钮（不包含取消按钮）
@property (nonatomic, strong, readonly) NSArray<TLAlertViewItem *> *items;

@property (nonatomic, strong, readonly) UIView *customView;

@property (nonatomic, strong, readonly) UITextField *textField;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)addTextFieldWithConfigAction:(TLAlertViewTextFieldConfigAction)configAction;

- (void)addItemWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction;
- (void)addDestructiveItemWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction;
- (void)addCancelItemTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction;

- (void)addItem:(TLAlertViewItem *)item;

- (void)show;
- (void)dismiss;

@end

