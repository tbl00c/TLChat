//
//  TLActionSheet.m
//  TLChat
//
//  Created by 李伯坤 on 16/5/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLActionSheet.h"
#import "UIImage+Color.h"

#define     TITLE_FONT_SIZE             13.0f
#define     BUTTON_FONT_SIZE            17.0f
#define     HEIGHT_BUTTON               52.0f
#define     SPACE_MIDDEL                8.0f
#define     SPACE_TITLE_LEFT            22.0f
#define     SPACE_TITLE_TOP             20.0f

#define     COLOR_BACKGROUND            [UIColor colorWithWhite:0.0 alpha:0.4]
#define     COLOR_DESTRUCTIVE_TITLE     [UIColor redColor]
#define     COLOR_TABLEVIEW_BG          [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0]
#define     COLOR_SEPERATOR             [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]

@implementation TLActionSheetItem

@end

@interface TLActionSheet() <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger tableViewButtonCount;
}

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *cancelButtonTitle;

@property (nonatomic, strong) NSString *destructiveButtonTitle;

/// 遮罩
@property (nonatomic, strong) UIButton *shadowView;

/// 弹窗
@property (nonatomic, strong) UIView *actionSheetView;
/// 顶部视图
@property (nonatomic, strong) UIView *headerView;
/// 选项
@property (nonatomic, strong) UITableView *tableView;
/// 按钮
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UILabel *headerTitleLabel;

@end

@implementation TLActionSheet

- (id)initWithTitle:(NSString *)title clickAction:(void (^)(NSInteger buttonIndex))clickAction cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [self initWithFrame:CGRectZero]) {
        [self setTitle:title];
        [self setClickAction:clickAction];
        [self setCancelButtonTitle:cancelButtonTitle];
        [self setDestructiveButtonTitle:destructiveButtonTitle];
        
        va_list list;
        if (otherButtonTitles) {
            _otherButtonTitles = [[NSMutableArray alloc] initWithCapacity:0];
            [_otherButtonTitles addObject:otherButtonTitles];
            
            va_start(list, otherButtonTitles);
            NSString *otherTitle = va_arg(list, id);
            while (otherTitle) {
                [_otherButtonTitles addObject:otherTitle];
                otherTitle = va_arg(list, id);
            }
        }
        
        [self _resetActionSheetUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self addSubview:self.shadowView];
        [self addSubview:self.actionSheetView];
        [self.actionSheetView addSubview:self.headerView];
        [self.actionSheetView addSubview:self.tableView];
        [self.actionSheetView addSubview:self.cancelButton];
        [self.shadowView setFrame:self.bounds];
    }
    return self;
}

- (void)setOtherButtonTitles:(NSMutableArray *)otherButtonTitles
{
    _otherButtonTitles = otherButtonTitles;
    
    [self _resetActionSheetUI];
}

- (void)setCustomHeaderView:(UIView *)customHeaderView
{
    _customHeaderView = customHeaderView;
    
    [self _resetActionSheetUI];
}

#pragma mark - # Public Methods
- (void)show
{
    [self showInView:[UIApplication sharedApplication].delegate.window];
}

- (void)showInView:(UIView *)view
{
    if (view == nil) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    [view addSubview:self];
    
    CGRect rect = CGRectMake(0, self.frame.size.height - self.actionSheetView.frame.size.height, self.frame.size.width, self.actionSheetView.frame.size.height);
    [self.shadowView setBackgroundColor:[UIColor clearColor]];
    [self.actionSheetView setFrame:CGRectMake(0,
                                              self.frame.size.height,
                                              self.actionSheetView.frame.size.width,
                                              self.actionSheetView.frame.size.height)];
    [UIView animateWithDuration:0.2 animations:^{
        [self.actionSheetView setFrame:rect];
        [self.shadowView setBackgroundColor:COLOR_BACKGROUND];
    }];
}

- (void)dismiss
{
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:YES];
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex
{
    buttonIndex -= self.destructiveButtonTitle ? 1 : 0;
    if (buttonIndex == -1) {
        return self.destructiveButtonTitle;
    }
    else if (buttonIndex >= 0 &&  buttonIndex < _otherButtonTitles.count) {
        return _otherButtonTitles[buttonIndex];
    }
    else if (buttonIndex == _otherButtonTitles.count) {
        return self.cancelButtonTitle;
    }
    return nil;
}

#pragma mark - # Event Response
- (void)didTapBackground:(id)sender
{
    [self cancelButtonClicked:sender];
}

- (void)cancelButtonClicked:(id)sender
{
    if (self.clickAction) {
        self.clickAction(self.cancelButtonIndex);
        self.clickAction = nil;
    }
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:YES];
}

#pragma mark - # Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableViewButtonCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TLActionSheetCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TLActionSheetCell"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:BUTTON_FONT_SIZE]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
    if (self.destructiveButtonTitle) {
        if (indexPath.row == 0) {
            [cell.textLabel setTextColor:COLOR_DESTRUCTIVE_TITLE];
            [cell.textLabel setText:self.destructiveButtonTitle];
        }
        else {
            [cell.textLabel setTextColor:[UIColor blackColor]];
            [cell.textLabel setText:_otherButtonTitles[indexPath.row - 1]];
        }
    }
    else {
        [cell.textLabel setTextColor:[UIColor blackColor]];
        [cell.textLabel setText:_otherButtonTitles[indexPath.row]];
    }
    
    if (self.cellConfigAction) {
        self.cellConfigAction(cell, cell.textLabel.text);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickAction) {
        self.clickAction(indexPath.row);
        self.clickAction = nil;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissWithClickedButtonIndex:indexPath.row animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets edgeInset = UIEdgeInsetsZero;
    if ((self.destructiveButtonTitle && indexPath.row >= _otherButtonTitles.count) || (!self.destructiveButtonTitle && indexPath.row >= _otherButtonTitles.count - 1)) {
        edgeInset = UIEdgeInsetsMake(0, 0, 0, self.frame.size.width);
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:edgeInset];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - # Private Methods
- (void)_resetActionSheetUI
{
    tableViewButtonCount = _otherButtonTitles.count + (self.destructiveButtonTitle ? 1 : 0);
    _numberOfButtons = tableViewButtonCount + (self.cancelButtonTitle ? 1 : 0);
    _destructiveButtonIndex = (self.destructiveButtonTitle ? 0 : -1);
    _cancelButtonIndex = (self.cancelButtonTitle ? _otherButtonTitles.count + (self.destructiveButtonTitle ? 1 : 0) : -1);
    
    // 顶部视图
    {
        // 移除旧视图
        while (self.headerView.subviews.count > 0) {
            [self.headerView.subviews.firstObject removeFromSuperview];
        }
        
        // 添加新视图
        if (self.customHeaderView) {
            [self.headerView addSubview:self.customHeaderView];
            [self.headerView setFrame:CGRectMake(0, 0, self.frame.size.width, self.customHeaderView.frame.size.height)];
        }
        else if (self.title.length > 0) {
            [self.headerTitleLabel removeFromSuperview];
            [self.headerTitleLabel setFrame:CGRectMake(SPACE_TITLE_LEFT, SPACE_TITLE_TOP, self.frame.size.width - SPACE_TITLE_LEFT * 2, 0)];
            [self.headerTitleLabel setText:self.title];
            CGFloat hightTitle = [self.headerTitleLabel sizeThatFits:CGSizeMake(self.headerTitleLabel.frame.size.width, MAXFLOAT)].height;
            [self.headerTitleLabel setFrame:CGRectMake(self.headerTitleLabel.frame.origin.x, self.headerTitleLabel.frame.origin.y, self.headerTitleLabel.frame.size.width, hightTitle)];
            
            CGFloat hightHeader = hightTitle + SPACE_TITLE_TOP * 2;
            [self.headerView setFrame:CGRectMake(0, 0, self.frame.size.width, hightHeader)];
            [self.headerView addSubview:self.headerTitleLabel];
        }
        else {
            [self.headerView setFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        }
        
        // 添加分割线
        if (self.destructiveButtonTitle || tableViewButtonCount > 0) {
            CGFloat height = 1.0 / [UIScreen mainScreen].scale;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height - height, self.frame.size.width, height)];
            [lineView setBackgroundColor:COLOR_SEPERATOR];
            [self.headerView addSubview:lineView];
        }
    }
    
    // 按钮列表
    {
        NSInteger tableHeight = tableViewButtonCount * HEIGHT_BUTTON;
        [self.tableView setBounces:NO];
        CGFloat maxHeight = (self.frame.size.height - self.headerView.frame.size.height - SPACE_MIDDEL - HEIGHT_BUTTON) * 0.6;
        if (tableHeight > maxHeight) {
            [self.tableView setBounces:YES];
            tableHeight = maxHeight;
        }
        [self.tableView setFrame:CGRectMake(0, self.headerView.frame.size.height, self.frame.size.width, tableHeight)];
    }
    
    
   
    // 取消按钮
    {
        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            edgeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
        }
        NSInteger height = edgeInsets.bottom + HEIGHT_BUTTON;
        [self.cancelButton setTitle:self.cancelButtonTitle ? self.cancelButtonTitle : @"取消" forState:UIControlStateNormal];
        CGFloat y = self.tableView.frame.origin.y + self.tableView.frame.size.height + SPACE_MIDDEL;
        [self.cancelButton setFrame:CGRectMake(0, y, self.frame.size.width, height)];
        [self.cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, edgeInsets.bottom, 0)];
    }
    
    // 整体视图
    {
        CGFloat height = self.cancelButton.frame.origin.y + self.cancelButton.frame.size.height;
        [self.actionSheetView setFrame:CGRectMake(0, self.frame.size.height - height, self.frame.size.width, height)];
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.actionSheetView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:(CGSize){10}];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        self.actionSheetView.layer.mask = shapeLayer;
    }
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if (animated) {
        CGRect rect = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.actionSheetView.frame.size.height);
        [UIView animateWithDuration:0.2 animations:^{
            [self.actionSheetView setFrame:rect];
            [self.shadowView setBackgroundColor:[UIColor clearColor]];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else {
        [self removeFromSuperview];
    }
}

#pragma mark - # Getter 
- (UIButton *)shadowView
{
    if (_shadowView == nil) {
        _shadowView = [[UIButton alloc] init];
        [_shadowView addTarget:self action:@selector(didTapBackground:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shadowView;
}

- (UIView *)actionSheetView
{
    if (_actionSheetView == nil) {
        _actionSheetView = [[UIView alloc] init];
        [_actionSheetView setBackgroundColor:COLOR_TABLEVIEW_BG];
    }
    return _actionSheetView;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_headerView setBackgroundColor:[UIColor whiteColor]];
    }
    return  _headerView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_tableView setRowHeight:HEIGHT_BUTTON];
        [_tableView setBackgroundColor:COLOR_TABLEVIEW_BG];
        [_tableView setSeparatorColor:COLOR_SEPERATOR];
        [_tableView setTableFooterView:[UIView new]];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setBounces:NO];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _tableView;
}

- (UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:BUTTON_FONT_SIZE]];
        [_cancelButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setBackgroundImage:[UIImage imageWithColor:COLOR_SEPERATOR] forState:UIControlStateHighlighted];
    }
    return _cancelButton;
}

- (UILabel *)headerTitleLabel
{
    if (_headerTitleLabel == nil) {
        _headerTitleLabel = [[UILabel alloc] init];
        [_headerTitleLabel setTextColor:[UIColor grayColor]];
        [_headerTitleLabel setFont:[UIFont systemFontOfSize:TITLE_FONT_SIZE]];
        [_headerTitleLabel setNumberOfLines:0];
        [_headerTitleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _headerTitleLabel;
}

@end
