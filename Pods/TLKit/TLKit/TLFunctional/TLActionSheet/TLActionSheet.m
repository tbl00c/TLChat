//
//  TLActionSheet.m
//  TLKit
//
//  Created by 李伯坤 on 2020/1/26.
//

#import "TLActionSheet.h"
#import "TLActionSheetAppearance.h"

#define     TLAS_SPACE_TITLE_LEFT            22.0f
#define     TLAS_SPACE_TITLE_TOP             20.0f
#define     TLAS_SPACE_MIDDEL                8.0f
#define     TLAS_MAX_TABLEVIEW_HEIGHT        self.frame.size.height * 0.6

#pragma mark - # TLActionSheetItem
@implementation TLActionSheetItem

- (instancetype)initWithTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction
{
    return [self initWithTitle:title message:nil clickAction:clickAction];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message clickAction:(TLActionSheetItemClickAction)clickAction
{
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.clickAction = clickAction;
    }
    return self;
}

@end

#pragma mark - # TLActionSheetItemCell
@interface TLActionSheetItemCell : UITableViewCell

@property (nonatomic, strong) TLActionSheetItem *item;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIView *seperatorView;

@property (nonatomic, assign) BOOL showSeperator;

@end

@implementation TLActionSheetItemCell

+ (CGFloat)heightForItem:(TLActionSheetItem *)item
{
    if (item.type == TLActionSheetItemTypeCustom) {
        return item.customView.frame.size.height;
    }
    TLActionSheetAppearance *appearance = [TLActionSheetAppearance appearance];
    CGFloat height = appearance.itemHeight;
    if (item.message.length > 0) {
        height += 6;
    }
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectedBackgroundView:[UIView new]];
        
        {
            UILabel *label = [[UILabel alloc] init];
            [label setTextAlignment:NSTextAlignmentCenter];
            [self.contentView addSubview:label];
            self.titleLabel = label;
        }
        {
            UILabel *label = [[UILabel alloc] init];
            [label setTextAlignment:NSTextAlignmentCenter];
            [self.contentView addSubview:label];
            self.messageLabel = label;
        }
        {
            CGFloat height = 1.0 / [UIScreen mainScreen].scale;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, height)];
            [lineView setBackgroundColor:[TLActionSheetAppearance appearance].separatorColor];
            [self.contentView addSubview:lineView];
            self.seperatorView = lineView;
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.item.type != TLActionSheetItemTypeCustom) {
        if (self.titleLabel.frame.size.width > self.frame.size.width) {
            [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.titleLabel.frame.size.height)];
        }
        if (self.messageLabel.frame.size.width > self.frame.size.width) {
            [self.messageLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.messageLabel.frame.size.height)];
        }
        [self.titleLabel setCenter:self.contentView.center];
        [self.messageLabel setCenter:self.contentView.center];
        if (self.titleLabel.text.length > 0 && self.messageLabel.text.length > 0) {
            [self.titleLabel setFrame:CGRectMake(self.titleLabel.frame.origin.x, 10, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
            [self.messageLabel setFrame:CGRectMake(self.messageLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 3, self.messageLabel.frame.size.width, self.messageLabel.frame.size.height)];
        }
    }
    else {
        [self.customView setCenter:self.contentView.center];
    }
    if (self.showSeperator) {
        [self.seperatorView setFrame:CGRectMake(0, self.frame.size.height - self.seperatorView.frame.size.height, self.frame.size.width, self.seperatorView.frame.size.height)];
    }
}

- (void)setItem:(TLActionSheetItem *)item
{
    _item = item;
    
    TLActionSheetAppearance *appearance = [TLActionSheetAppearance appearance];
    [self setBackgroundColor:item.backgroundColor ? item.backgroundColor : appearance.itemBackgroundColor];
    [self.selectedBackgroundView setBackgroundColor:item.selectedBackgroundColor ? item.selectedBackgroundColor : appearance.separatorColor];
    
    {
        [self.titleLabel setHidden:YES];
        [self.titleLabel setFont:item.titleFont ? item.titleFont : appearance.itemTitleFont];
        [self.titleLabel setText:item.title];
        CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [self.titleLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
    }
    
    {
        [self.messageLabel setHidden:YES];
        [self.messageLabel setFont:item.messageFont ? item.messageFont : appearance.itemMessageFont];
        [self.messageLabel setText:item.message];
        CGSize size = [self.messageLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [self.messageLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
    }
    
    if (self.customView) {
        [self.customView removeFromSuperview];
        self.customView = nil;
    }
    
    if (item.type == TLActionSheetItemTypeNormal) {
        [self.titleLabel setHidden:NO];
        [self.titleLabel setTextColor:item.titleColor ? item.titleColor : appearance.itemTitleColor];
        if (item.message.length > 0) {
            [self.messageLabel setTextColor:item.messageColor ? item.messageColor : appearance.itemMessageColor];
            [self.messageLabel setHidden:NO];
        }
    }
    else if (item.type == TLActionSheetItemTypeDestructive) {
        [self.titleLabel setHidden:NO];
        [self.titleLabel setTextColor:item.titleColor ? item.titleColor : appearance.destructiveItemTitleColor];;
        if (item.message.length > 0) {
            [self.messageLabel setTextColor:item.messageColor ? item.messageColor : appearance.destructiveItemMessageColor];
            [self.messageLabel setHidden:NO];
        }
    }
    else if (item.type == TLActionSheetItemTypeCustom) {
        self.customView = item.customView;
        [self.contentView addSubview:self.customView];
    }
}

- (void)setShowSeperator:(BOOL)showSeperator
{
    _showSeperator = showSeperator;
    if (showSeperator) {
        [self.seperatorView setHidden:NO];
        [self.seperatorView setBackgroundColor:[TLActionSheetAppearance appearance].separatorColor];
    }
    else {
        [self.seperatorView setHidden:YES];
    }
}

@end

#pragma mark - # TLActionSheet
@interface TLActionSheet () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_items;
}

@property (nonatomic, strong) UIControl *shadowView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) TLActionSheetItem *cancelItem;

@end

@implementation TLActionSheet

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title items:nil];
}

- (instancetype)initWithTitle:(NSString *)title items:(NSArray<TLActionSheetItem *> *)items
{
    if (self = [self initWithFrame:CGRectZero]) {
        _title = title;
        if (items.count > 0) {
            [_items addObjectsFromArray:items];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _items = [[NSMutableArray alloc] init];
        _cancelItem = [[TLActionSheetItem alloc] initWithTitle:@"取消" clickAction:nil];
        
        [self _initActionSheet];
    }
    return self;
}

#pragma mark - # API
- (void)addItemWithTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction
{
    [self addItemWithTitle:title message:nil clickAction:clickAction];
}

- (void)addItemWithTitle:(NSString *)title message:(NSString *)message clickAction:(TLActionSheetItemClickAction)clickAction;
{
    TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithTitle:title message:message clickAction:clickAction];
    [self addItem:item];
}

- (void)setCancelItemTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction;
{
    [self.cancelItem setTitle:title];
    [self.cancelItem setClickAction:clickAction];
}

- (void)addDestructiveItemWithTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction
{
    TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithTitle:title message:nil clickAction:clickAction];
    [item setType:TLActionSheetItemTypeDestructive];
    [self addItem:item];
}

- (void)addCustomViewItem:(UIView *)customView clickAction:(TLActionSheetItemClickAction)clickAction
{
    TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithTitle:nil clickAction:clickAction];
    [item setType:TLActionSheetItemTypeCustom];
    [item setCustomView:customView];
    [self addItem:item];
}

- (void)addItem:(TLActionSheetItem *)item
{
    [_items addObject:item];
}

- (void)show
{
    [self showInView:nil];
}

- (void)showInView:(UIView *)view
{
    // 父视图
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    // 重置视图
    [self setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [self _resetActionSheet];
    
    // 遮罩
    [self.shadowView setFrame:view.bounds];
    [self.shadowView removeFromSuperview];
    [view addSubview:_shadowView];
    
    // 弹窗
    [self removeFromSuperview];
    [view addSubview:self];
    CGRect originRect = CGRectMake(0, view.frame.size.height + self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [self setFrame:originRect];
    
    // 显示
    [self.shadowView setBackgroundColor:[UIColor clearColor]];
    CGRect targetRect = CGRectMake(0, view.frame.size.height - self.frame.size.height, originRect.size.width, originRect.size.height);
    [UIView animateWithDuration:0.2 animations:^{
        [self setFrame:targetRect];
        [self.shadowView setBackgroundColor:[TLActionSheetAppearance appearance].shadowColor];
    }];
}

- (void)dismiss
{
    CGRect targetRect = CGRectMake(0, _shadowView.frame.size.height + self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.2 animations:^{
        [self setFrame:targetRect];
        [self.shadowView setBackgroundColor:[UIColor clearColor]];
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - # Event
- (void)excuteCancelAction
{
    [self dismiss];
    if (self.cancelItem.clickAction) {
        self.cancelItem.clickAction(self, self.cancelItem, self.items.count);
    }
}

#pragma mark - # Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLActionSheetItem *item = indexPath.row < self.items.count ? [self.items objectAtIndex:indexPath.row] : nil;
    TLActionSheetItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLActionSheetItemCell" forIndexPath:indexPath];
    [cell setItem:item];
    [cell setShowSeperator:indexPath.row < self.items.count - 1];
    if (item.configAction) {
        item.configAction(self, cell.contentView, item, indexPath.row - 1);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLActionSheetItem *item = indexPath.row < self.items.count ? [self.items objectAtIndex:indexPath.row] : nil;
    if (item.clickAction) {
        item.clickAction(self, item, indexPath.row);
    }
    [self dismiss];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLActionSheetItem *item = indexPath.row < self.items.count ? [self.items objectAtIndex:indexPath.row] : nil;
    CGFloat height = [TLActionSheetItemCell heightForItem:item];
    return height;
}

#pragma mark - # Private
- (void)_initActionSheet
{
    // 遮罩
    {
        UIControl *view = [[UIControl alloc] init];
        [view addTarget:self action:@selector(excuteCancelAction) forControlEvents:UIControlEventTouchUpInside];
        self.shadowView = view;
    }
    
    // header
    {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        self.headerView = view;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(TLAS_SPACE_TITLE_LEFT, TLAS_SPACE_TITLE_TOP, 0, 0)];
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentCenter];
        self.titleLabel = label;
    }
    
    // 列表
    {
        UITableView *tableView = [[UITableView alloc] init];
        [tableView setBackgroundColor:[UIColor clearColor]];
        [tableView setTableFooterView:[UIView new]];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        [tableView setBounces:NO];
        [tableView setScrollEnabled:NO];
        [tableView setScrollsToTop:NO];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        [self addSubview:tableView];
        [tableView registerClass:[TLActionSheetItemCell class] forCellReuseIdentifier:@"TLActionSheetItemCell"];
        self.tableView = tableView;
    }
    
    // 取消按钮
    {
        UIButton *button = [[UIButton alloc] init];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [button addTarget:self action:@selector(excuteCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.cancelButton = button;
    }
    
}

- (void)_resetActionSheet
{
    CGFloat y = 0;
    CGFloat width = self.frame.size.width;
    
    TLActionSheetAppearance *appearance = [TLActionSheetAppearance appearance];
    
    [self setBackgroundColor:appearance.backgroundColor];
    
    // 遮罩
    [self.shadowView setBackgroundColor:appearance.shadowColor];
    
    // header
    {
        [self.headerView setHidden:YES];
        [self.headerView setBackgroundColor:appearance.itemBackgroundColor];
        while (self.headerView.subviews.count > 0) {
            [self.titleLabel.subviews.firstObject removeFromSuperview];
        }
        
        if (self.customHeaderView) {
            [self.headerView setHidden:NO];
            [self.customHeaderView removeFromSuperview];
            [self.customHeaderView setFrame:self.customHeaderView.bounds];
            
            [self.headerView setFrame:self.customHeaderView.bounds];
            [self.headerView addSubview:self.customHeaderView];
        }
        else if (self.title.length > 0) {
            [self.headerView setHidden:NO];
            [self.titleLabel setTextColor:appearance.headerTitleColor];
            [self.titleLabel setFont:appearance.headerTitleFont];
            [self.titleLabel setText:self.title];
            CGFloat labelWidth = width - TLAS_SPACE_TITLE_LEFT * 2;
            CGFloat labelHeight = [self.titleLabel sizeThatFits:CGSizeMake(labelWidth, MAXFLOAT)].height;
            [self.titleLabel setFrame:CGRectMake(TLAS_SPACE_TITLE_LEFT, TLAS_SPACE_TITLE_TOP, labelWidth, labelHeight)];
            
            CGFloat headerHeight = labelHeight + TLAS_SPACE_TITLE_TOP * 2;
            [self.headerView setFrame:CGRectMake(0, 0, width, headerHeight)];
            [self.headerView addSubview:self.titleLabel];
        }
        
        if (!self.headerView.hidden) {
            y += self.headerView.frame.size.height;
            // 添加分割线
            if (self.items.count > 0) {
                CGFloat height = 1.0 / [UIScreen mainScreen].scale;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height - height, self.frame.size.width, height)];
                [lineView setBackgroundColor:appearance.separatorColor];
                [self.headerView addSubview:lineView];
            }
        }
    }
    
    // items
    {
        CGFloat tableViewHeight = 0;
        for (TLActionSheetItem *item in self.items) {
            tableViewHeight += [TLActionSheetItemCell heightForItem:item];
        }
        [self.tableView setScrollEnabled:NO];
        if (tableViewHeight > TLAS_MAX_TABLEVIEW_HEIGHT) {
            tableViewHeight = TLAS_MAX_TABLEVIEW_HEIGHT;
            [self.tableView setScrollEnabled:YES];
        }
        [self.tableView setFrame:CGRectMake(0, y, width, tableViewHeight)];
        [self.tableView reloadData];
        y += tableViewHeight;
    }
    
    y += TLAS_SPACE_MIDDEL;
    
    // button
    {
        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            edgeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
        }
        [self.cancelButton setFrame:CGRectMake(0, y, width, appearance.itemHeight + edgeInsets.bottom)];
        [self.cancelButton setTitle:self.cancelItem.title forState:UIControlStateNormal];
        [self.cancelButton setBackgroundColor:appearance.itemBackgroundColor];
        [self.cancelButton setTitleColor:appearance.cancelItemTitleColor forState:UIControlStateNormal];
        [self.cancelButton.titleLabel setFont:appearance.itemTitleFont];
        [self.cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, edgeInsets.bottom, 0)];
        [self.cancelButton setBackgroundImage:[self _imageWithColor:appearance.separatorColor] forState:UIControlStateHighlighted];
        y += self.cancelButton.frame.size.height;
    }
    
    // 圆角
    {
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, y)];
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:(CGSize){10}];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        self.layer.mask = shapeLayer;
    }
}

- (UIImage *)_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == self.items.count) {
        return self.cancelItem.title;
    }
    else if (buttonIndex < self.items.count) {
        TLActionSheetItem *item = [self.items objectAtIndex:buttonIndex];
        return item.title;
    }
    return nil;
}

#pragma mark - # 旧版本兼容
- (id)initWithTitle:(NSString *)title clickAction:(void (^)(NSInteger buttonIndex))clickAction cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    [self setClickAction:clickAction];
    [self setCancelItemTitle:cancelButtonTitle clickAction:nil];
    if (self = [self initWithTitle:title]) {
        __weak typeof(self) weakSelf = self;
        TLActionSheetItemClickAction clickAction = ^(TLActionSheet *actionSheet, TLActionSheetItem *item, NSInteger index) {
            if (weakSelf.clickAction) {
                weakSelf.clickAction(index);
            }
        };
        
        if (otherButtonTitles) {
            va_list list;
            va_start(list, otherButtonTitles);
            if (otherButtonTitles) {
                [self addItemWithTitle:otherButtonTitles clickAction:clickAction];
            }
            NSString *title = va_arg(list, id);
            while (title.length > 0) {
                [self addItemWithTitle:title clickAction:clickAction];
                title = va_arg(list, id);
            }
            va_end(list);
        }
       
        if (destructiveButtonTitle.length > 0) {
            [self addDestructiveItemWithTitle:destructiveButtonTitle clickAction:clickAction];
        }
    }
    
    return self;
}

@end
