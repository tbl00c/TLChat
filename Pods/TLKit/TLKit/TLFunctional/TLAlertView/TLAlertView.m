//
//  TLAlertView.m
//  TLKit
//
//  Created by 李伯坤 on 2020/1/27.
//

#import "TLAlertView.h"
#import "TLAlertViewAppearance.h"

#define     TLAV_MAX_ITEMS_HEIGHT           self.frame.size.height * 0.3
#define     TLAV_MAX_MESSAGE_HEIGHT         self.frame.size.height * 0.45
#define     TLAV_TITLE_EDGE_TOP             35
#define     TLAV_TITLE_EDGE_LEFT            12
#define     TLAV_TITLE_EDGE_BOTTOM          25
#define     TLAV_MESSAGE_EDGE_TOP           12
#define     TLAV_TEXTFIEld_EDGE_TOP         12

#pragma mark - # TLAlertViewItem
@implementation TLAlertViewItem

- (instancetype)initWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction
{
    if (self = [self init]) {
        self.title = title;
        self.clickAction = clickAction;
    }
    return self;
}

@end

#pragma mark - # TLAlertViewItemCell
typedef NS_ENUM(NSInteger, TLAlertViewItemCellSeperatorType) {
    TLAlertViewItemCellSeperatorTypeNone,
    TLAlertViewItemCellSeperatorTypeLeft,
    TLAlertViewItemCellSeperatorTypeBottom,
};

@interface TLAlertViewItemCell : UICollectionViewCell

@property (nonatomic, strong) TLAlertViewItem *item;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *seperatorView;
@property (nonatomic, assign) TLAlertViewItemCellSeperatorType seperatorType;

@end

@implementation TLAlertViewItemCell

+ (CGSize)sizeForItem:(TLAlertViewItem *)item width:(CGFloat)width totoalCount:(NSInteger)totalCount
{
    TLAlertViewAppearance *appearance = [TLAlertViewAppearance appearance];
    CGFloat itemHeight = appearance.itemHeight;
    CGFloat itemWidth = totalCount == 2 ? width / 2 : width;
    return CGSizeMake(itemWidth, itemHeight);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSelectedBackgroundView:[UIView new]];
        
        {
            UILabel *label = [[UILabel alloc] init];
            [label setTextAlignment:NSTextAlignmentCenter];
            [self.contentView addSubview:label];
            self.titleLabel = label;
        }
        {
            UIView *lineView = [[UIView alloc] init];
            [lineView setBackgroundColor:[TLAlertViewAppearance appearance].separatorColor];
            [self.contentView addSubview:lineView];
            self.seperatorView = lineView;
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.titleLabel.frame;
    if (self.titleLabel.frame.size.width > self.contentView.frame.size.width) {
        rect.size.width = self.contentView.frame.size.width;
    }
    rect.origin.y = (self.contentView.frame.size.height - rect.size.height) / 2.0;
    rect.origin.x = (self.contentView.frame.size.width - rect.size.width) / 2.0;
    [self.titleLabel setFrame:rect];
    
    [self.seperatorView setHidden:YES];
    CGFloat width = 1.0 / [UIScreen mainScreen].scale;
    if (self.seperatorType == TLAlertViewItemCellSeperatorTypeLeft) {
        [self.seperatorView setHidden:NO];
        [self.seperatorView setFrame:CGRectMake(0, 0, width, self.contentView.frame.size.height)];
    }
    else if (self.seperatorType == TLAlertViewItemCellSeperatorTypeBottom){
        [self.seperatorView setHidden:NO];
        [self.seperatorView setFrame:CGRectMake(0, self.contentView.frame.size.height - width, self.contentView.frame.size.width, width)];
    }
}

- (void)setItem:(TLAlertViewItem *)item seperatorType:(TLAlertViewItemCellSeperatorType)seperatorType
{
    _item = item;
    _seperatorType = seperatorType;
    
    TLAlertViewAppearance *appearance = [TLAlertViewAppearance appearance];
    
    self.selectedBackgroundView.backgroundColor = appearance.separatorColor;
    
    {
        [self.titleLabel setFont:item.titleFont ? item.titleFont : appearance.itemTitleFont];
        [self.titleLabel setText:item.title];
        CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [self.titleLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
    }
    
    if (item.type == TLAlertViewItemTypeNormal) {
        [self.titleLabel setTextColor:item.titleColor ? item.titleColor : appearance.itemTitleColor];
    }
    else if (item.type == TLAlertViewItemTypeDestructive) {
        [self.titleLabel setTextColor:item.titleColor ? item.titleColor : appearance.destructiveItemTitleColor];;
    }
    else if (item.type == TLAlertViewItemTypeCancel) {
        [self.titleLabel setTextColor:item.titleColor ? item.titleColor : appearance.cancelItemTitleColor];;
    }
    
    [self setNeedsLayout];
}

@end


#pragma mark - # TLAlertView
@interface TLAlertView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_items;
}

@property (nonatomic, strong) UIScrollView *shadowView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *messageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *seperatorView;

@end

@implementation TLAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [self initWithFrame:CGRectZero]) {
        _title = title;
        _message = message;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _items = [[NSMutableArray alloc] init];
        [self _initAlertView];
    }
    return self;
}

#pragma mark - # API
- (void)addTextFieldWithConfigAction:(TLAlertViewTextFieldConfigAction)configAction
{
    if (self.textField) {
        [self.textField removeFromSuperview];
    }
    UITextField *textField = [[UITextField alloc] init];
    [textField.layer setMasksToBounds:YES];
    [textField.layer setCornerRadius:5.0f];
    [textField.layer setBorderWidth:1.0/[UIScreen mainScreen].scale];
    [textField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 1)]];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setRightView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 1)]];
    [textField setRightViewMode:UITextFieldViewModeAlways];
    _textField = textField;
    if (configAction) {
        configAction(self, textField);
    }
}

- (void)addItemWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction
{
    TLAlertViewItem *item = [[TLAlertViewItem alloc] initWithTitle:title clickAction:clickAction];
    [self addItem:item];
}

- (void)addCancelItemTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction
{
    TLAlertViewItem *item = [[TLAlertViewItem alloc] initWithTitle:title clickAction:clickAction];
    [item setType:TLAlertViewItemTypeCancel];
    [self addItem:item];
}

- (void)addDestructiveItemWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction
{
    TLAlertViewItem *item = [[TLAlertViewItem alloc] initWithTitle:title clickAction:clickAction];
    [item setType:TLAlertViewItemTypeDestructive];
    [self addItem:item];
}

- (void)addItem:(TLAlertViewItem *)item
{
    [_items addObject:item];
}

- (void)show
{
    [self showInView:nil];
}

- (void)showInView:(UIView *)view
{
    TLAlertViewAppearance *appearance = [TLAlertViewAppearance appearance];
    
    // 父视图
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    // 重置视图
    [self setFrame:CGRectMake(0, 0, appearance.viewWidth, view.frame.size.height)];
    [self _resetAlertView];
    
    // 遮罩
    [self.shadowView setFrame:view.bounds];
    [self.shadowView setContentSize:view.bounds.size];
    [self.shadowView removeFromSuperview];
    [view addSubview:_shadowView];
    
    // 弹窗
    [self removeFromSuperview];
    [self.shadowView addSubview:self];
    [self setCenter:self.shadowView.center];
    
    // 显示
    [self setAlpha:0];
    [self.shadowView setBackgroundColor:[UIColor clearColor]];
    [UIView animateWithDuration:0.2 animations:^{
        [self setAlpha:1];
        [self.shadowView setBackgroundColor:appearance.shadowColor];
        if (self.textField) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHeightChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
            [self.textField becomeFirstResponder];
        }
    }];
}

- (void)dismiss
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [UIView animateWithDuration:0.2 animations:^{
        [self.shadowView setBackgroundColor:[UIColor clearColor]];
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - # Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLAlertViewItem *item = indexPath.row < self.items.count ? self.items[indexPath.row] : nil;
    TLAlertViewItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLAlertViewItemCell" forIndexPath:indexPath];
    TLAlertViewItemCellSeperatorType type = TLAlertViewItemCellSeperatorTypeNone;
    if (self.items.count == 2 && indexPath.row == 1) {
        type = TLAlertViewItemCellSeperatorTypeLeft;
    }
    else if (self.items.count > 2 && indexPath.row < self.items.count - 1) {
        type = TLAlertViewItemCellSeperatorTypeBottom;
    }
    [cell setItem:item seperatorType:type];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLAlertViewItem *item = indexPath.row < self.items.count ? self.items[indexPath.row] : nil;
    CGSize size = [TLAlertViewItemCell sizeForItem:item width:collectionView.frame.size.width totoalCount:self.items.count];
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismiss];
    TLAlertViewItem *item = indexPath.row < self.items.count ? self.items[indexPath.row] : nil;
    if (item.clickAction) {
        item.clickAction(self, item, indexPath.row);
    }
}

#pragma mark - # Notification
- (void)keyboardHeightChanged:(NSNotification *)notification
{
    CGRect rect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self _updateAlertViewWithKeyboardRect:rect];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    CGRect rect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self _updateAlertViewWithKeyboardRect:rect];
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
    [self.shadowView setContentOffset:CGPointZero animated:YES];
}

- (void)_updateAlertViewWithKeyboardRect:(CGRect)keyboardRect
{
    CGRect rect = self.frame;
    CGFloat bottom = rect.origin.y + rect.size.height;
    CGFloat offset = keyboardRect.origin.y - bottom - 30;
    if (offset < 0) {
        [self.shadowView setContentOffset:CGPointMake(0, -offset) animated:YES];
    }
}

#pragma mark - # Private
- (void)_initAlertView
{
    // 遮罩
    {
        UIScrollView *view = [[UIScrollView alloc] init];
        [view setScrollsToTop:NO];
        [view setScrollEnabled:NO];
        [view setShowsVerticalScrollIndicator:NO];
        self.shadowView = view;
    }
    
    {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        self.contentView = view;
    }
    
    {
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setNumberOfLines:0];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    
    {
        UITextView *textView = [[UITextView alloc] init];
        [textView setEditable:NO];
        [textView setSelectable:NO];
        [textView setScrollsToTop:NO];
        [textView setScrollEnabled:NO];
        [textView setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:textView];
        self.messageView = textView;
    }
    
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setMinimumLineSpacing:0];
        [layout setMinimumInteritemSpacing:0];
        [layout setSectionInset:UIEdgeInsetsZero];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [collectionView setBackgroundColor:[UIColor whiteColor]];
        [collectionView setScrollEnabled:NO];
        [collectionView setScrollsToTop:NO];
        [collectionView setDelegate:self];
        [collectionView setDataSource:self];
        [collectionView registerClass:[TLAlertViewItemCell class] forCellWithReuseIdentifier:@"TLAlertViewItemCell"];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
    }
    
    // 分割线
    {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        self.seperatorView = view;
    }
    
    [self.layer setMasksToBounds:YES];
}

- (void)_resetAlertView
{
    TLAlertViewAppearance *appearance = [TLAlertViewAppearance appearance];
    
    CGFloat y = 0;
    CGFloat width = self.frame.size.width;
    CGFloat titleX = TLAV_TITLE_EDGE_LEFT;
    CGFloat titleWidth = width - titleX * 2;
    
    [self setBackgroundColor:appearance.backgroundColor];
    [self.layer setCornerRadius:appearance.cornerRadius];
    
    // 遮罩
    [self.shadowView setBackgroundColor:appearance.shadowColor];
    
    {
        // contentView
        while (self.contentView.subviews.count > 0) {
            [self.contentView.subviews.firstObject removeFromSuperview];
        }
        if (self.customView) {
            [self.customView removeFromSuperview];
            [self.contentView addSubview:self.customView];
            [self.contentView setFrame:CGRectMake(0, 0, width, self.customView.frame.size.height)];
            [self.customView setCenter:self.contentView.center];
        }
        else {
            y += TLAV_TITLE_EDGE_TOP;
            if (self.title.length > 0) {
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:4.0f];
                [style setParagraphSpacing:6.0f];
                [style setAlignment:NSTextAlignmentCenter];
                NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.title
                                                                                            attributes:@{NSForegroundColorAttributeName : appearance.titleColor,
                                                                                                         NSFontAttributeName : appearance.titleFont,
                                                                                                         NSParagraphStyleAttributeName : style,
                                                                                            }];
                [self.titleLabel setAttributedText:attrStr];
                [self.contentView addSubview:self.titleLabel];
                CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(titleWidth, MAXFLOAT)];
                [self.titleLabel setFrame:CGRectMake(titleX, y, titleWidth, size.height)];
                y += size.height;
            }
            if (self.message.length > 0) {
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:4.0f];
                [style setParagraphSpacing:6.0f];
                [style setAlignment:NSTextAlignmentCenter];
                NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.message
                                                                                            attributes:@{NSForegroundColorAttributeName : appearance.messageColor,
                                                                                                         NSFontAttributeName : appearance.messageFont,
                                                                                                         NSParagraphStyleAttributeName : style,
                                                                                            }];
                [self.messageView setAttributedText:attrStr];
                [self.contentView addSubview:self.messageView];
                CGSize size = [self.messageView sizeThatFits:CGSizeMake(titleWidth, MAXFLOAT)];
                [self.messageView setScrollEnabled:NO];
                if (size.height > TLAV_MAX_MESSAGE_HEIGHT) {
                    [self.messageView setScrollEnabled:YES];
                    size.height = TLAV_MAX_MESSAGE_HEIGHT;
                }
                if (self.title.length > 0) {
                    y += TLAV_MESSAGE_EDGE_TOP;
                }
                [self.messageView setFrame:CGRectMake(titleX, y, titleWidth, size.height)];
                y += (self.textField ? TLAV_TEXTFIEld_EDGE_TOP : TLAV_TITLE_EDGE_BOTTOM) + size.height;
            }
            else {
                y += self.textField ? TLAV_TITLE_EDGE_BOTTOM : TLAV_TITLE_EDGE_TOP;
            }
            
            if (self.textField) {
                [self.textField removeFromSuperview];
                [self.textField.layer setBorderColor:appearance.separatorColor.CGColor];
                CGFloat x = 20.0f;
                CGFloat height = 40.0f;
                [self.textField setFrame:CGRectMake(x, y, width - x * 2, height)];
                [self.contentView addSubview:self.textField];
                y += (TLAV_TITLE_EDGE_BOTTOM + height);
            }
            [self.contentView setFrame:CGRectMake(0, 0, width, y)];
        }
    }
    
    // 按钮
    {
        [self.seperatorView setHidden:YES];
        [self.collectionView setHidden:YES];
        if (self.items.count > 0) {
            // 分割线
            {
                [self.seperatorView setHidden:NO];
                CGFloat height = 1.0 / [UIScreen mainScreen].scale;
                [self.seperatorView setFrame:CGRectMake(0, self.contentView.frame.size.height - height, self.frame.size.width, height)];
                [self.seperatorView setBackgroundColor:appearance.separatorColor];
            }
            CGFloat buttonHeight = self.items.count == 2 ? appearance.itemHeight : appearance.itemHeight * self.items.count;
            [self.collectionView setHidden:NO];
            [self.collectionView setScrollEnabled:NO];
            if (buttonHeight > TLAV_MAX_ITEMS_HEIGHT) {
                buttonHeight = TLAV_MAX_ITEMS_HEIGHT;
                [self.collectionView setScrollEnabled:YES];
            }
            [self.collectionView setFrame:CGRectMake(0, y, width, buttonHeight)];
            y += buttonHeight;
        }
    }
    
    if (y < appearance.minViewHeight) {
        CGFloat offset = appearance.minViewHeight - y;
        {
            CGRect origin = self.contentView.frame;
            origin.origin.y += offset / 2.0f;
            [self.contentView setFrame:origin];
        }
        {
            CGRect origin = self.collectionView.frame;
            origin.origin.y += offset;
            [self.collectionView setFrame:origin];
        }
        {
            CGRect origin = self.seperatorView.frame;
            origin.origin.y += offset;
            [self.seperatorView setFrame:origin];
        }
        y = appearance.minViewHeight;
    }
    [self setFrame:CGRectMake(0, 0, width, y)];
}


@end
