//
//  TLLoginViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLLoginViewController.h"
#import "TLRootProxy.h"

#define     HEIGHT_ITEM     45.0f
#define     EDGE_LINE       20.0f
#define     WIDTH_TITLE     90.0f
#define     EDGE_DETAIL     15.0f

@interface TLLoginViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *originTitleLabel;
@property (nonatomic, strong) UILabel *originLabel;

@property (nonatomic, strong) UILabel *districtNumberLabel;
@property (nonatomic, strong) UITextField *phoneNumberTextField;

@property (nonatomic, strong) UILabel *passwordTitleLabel;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation TLLoginViewController

- (void)loadView {
    [super loadView];
    self.statusBarStyle = UIStatusBarStyleDefault;
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.cancelButton];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.originTitleLabel];
    [self.scrollView addSubview:self.originLabel];
    [self.scrollView addSubview:self.districtNumberLabel];
    [self.scrollView addSubview:self.phoneNumberTextField];
    [self.scrollView addSubview:self.passwordTitleLabel];
    [self.scrollView addSubview:self.passwordTextField];
    [self.scrollView addSubview:self.loginButton];
    
    [self p_addMasonry];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
    [self.scrollView addGestureRecognizer:tapGR];
    
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + BORDER_WIDTH_1PX)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [TLUIUtility hiddenLoading];
    [self.phoneNumberTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark - # Event Response
- (void)cancelButtonClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapView
{
    [TLUIUtility hiddenLoading];
    [self.phoneNumberTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)loginButtonClicked
{
    NSString *phoneNumber = self.phoneNumberTextField.text;
    if (phoneNumber.length != 11 && ![phoneNumber hasPrefix:@"1"]) {
        [TLUIUtility showErrorHint:LOCSTR(@"请输入正确的手机号")];
        return;
    }
    NSString *password = self.passwordTextField.text;
    
    [TLUIUtility showLoading:nil];
    TLRootProxy *proxy = [[TLRootProxy alloc] init];
    TLWeakSelf(self);
    [proxy userLoginWithPhoneNumber:phoneNumber password:password success:^(id datas) {
        [TLUIUtility hiddenLoading];
        if (weakself.loginSuccess) {
            weakself.loginSuccess();
        }
    } failure:^(NSString *errMsg) {
        [TLUIUtility showErrorHint:errMsg];
    }];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STATUSBAR_HEIGHT);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(NAVBAR_HEIGHT);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVBAR_HEIGHT + STATUSBAR_HEIGHT + 20);
        make.centerX.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(self.scrollView);
    }];
    
    UIView *(^crateLine)() = ^UIView *() {
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor colorGrayLine]];
        return view;
    };
    
    [self.originTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(EDGE_LINE);
        make.height.mas_equalTo(HEIGHT_ITEM);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(55);
        make.width.mas_equalTo(WIDTH_TITLE);
    }];
    [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.originTitleLabel.mas_right).mas_offset(EDGE_DETAIL);
        make.centerY.mas_equalTo(self.originTitleLabel);
        make.height.mas_equalTo(HEIGHT_ITEM);
        make.right.mas_equalTo(self.view).mas_offset(-EDGE_LINE);
    }];
    
    UIView *line1 = crateLine();
    [self.scrollView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.originTitleLabel.mas_bottom);
        make.left.mas_equalTo(EDGE_LINE);
        make.width.mas_equalTo(self.scrollView).mas_offset(-EDGE_LINE * 2);
        make.height.mas_equalTo(BORDER_WIDTH_1PX);
    }];
    
    [self.districtNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom);
        make.left.mas_equalTo(line1);
        make.height.mas_equalTo(HEIGHT_ITEM);
        make.width.mas_equalTo(WIDTH_TITLE);
    }];
    
    UIView *line1_1 = crateLine();
    [self.scrollView addSubview:line1_1];
    [line1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.mas_equalTo(self.districtNumberLabel);
        make.left.mas_equalTo(self.districtNumberLabel.mas_right);
        make.width.mas_equalTo(BORDER_WIDTH_1PX);
    }];
    
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.originLabel);
        make.centerY.mas_equalTo(self.districtNumberLabel);
        make.height.mas_equalTo(HEIGHT_ITEM);
        make.right.mas_equalTo(self.view).mas_offset(-EDGE_LINE);
    }];
    
    UIView *line2 = crateLine();
    [self.scrollView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.districtNumberLabel.mas_bottom);
        make.left.mas_equalTo(EDGE_LINE);
        make.width.mas_equalTo(self.scrollView).mas_offset(-EDGE_LINE * 2);
        make.height.mas_equalTo(BORDER_WIDTH_1PX);
    }];
    
    [self.passwordTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line2);
        make.top.mas_equalTo(line2.mas_bottom);
        make.height.mas_equalTo(HEIGHT_ITEM);
        make.width.mas_equalTo(self.districtNumberLabel);
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.originLabel);
        make.centerY.mas_equalTo(self.passwordTitleLabel);
        make.height.mas_equalTo(HEIGHT_ITEM);
        make.right.mas_equalTo(self.view).mas_offset(-EDGE_LINE);
    }];
    
    UIView *line3 = crateLine();
    [self.scrollView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTitleLabel.mas_bottom);
        make.left.mas_equalTo(EDGE_LINE);
        make.width.mas_equalTo(self.scrollView).mas_offset(-EDGE_LINE * 2);
        make.height.mas_equalTo(BORDER_WIDTH_1PX);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(line3);
        make.height.mas_equalTo(HEIGHT_ITEM);
        make.top.mas_equalTo(line3.mas_bottom).mas_offset(HEIGHT_ITEM);
    }];
}


#pragma mark - # Getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:LOCSTR(@"取消") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorGreenDefault] forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:28.0]];
        [_titleLabel setText:LOCSTR(@"使用手机号登录")];
    }
    return _titleLabel;
}

- (UILabel *)originTitleLabel
{
    if (!_originTitleLabel) {
        _originTitleLabel = [[UILabel alloc] init];
        [_originTitleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [_originTitleLabel setText:LOCSTR(@"国家/地区")];
    }
    return _originTitleLabel;
}
- (UILabel *)originLabel
{
    if (!_originLabel) {
        _originLabel = [[UILabel alloc] init];
        [_originLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [_originLabel setText:@"中国"];
    }
    return _originLabel;
}

- (UILabel *)districtNumberLabel
{
    if (!_districtNumberLabel) {
        _districtNumberLabel = [[UILabel alloc] init];
        [_districtNumberLabel setText:@"+86"];
    }
    return _districtNumberLabel;
}
- (UITextField *)phoneNumberTextField
{
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [[UITextField alloc] init];
        [_phoneNumberTextField setPlaceholder:LOCSTR(@"请填写手机号码")];
        [_phoneNumberTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_phoneNumberTextField setKeyboardType:UIKeyboardTypePhonePad];
    }
    return _phoneNumberTextField;
}

- (UILabel *)passwordTitleLabel
{
    if (!_passwordTitleLabel) {
        _passwordTitleLabel = [[UILabel alloc] init];
        [_passwordTitleLabel setText:LOCSTR(@"密码")];
    }
    return _passwordTitleLabel;
}
- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        [_passwordTextField setPlaceholder:LOCSTR(@"请填写密码")];
        [_passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_passwordTextField setSecureTextEntry:YES];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        UIButton *button = [[UIButton alloc] init];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:4.0f];
        [button.layer setBorderWidth:BORDER_WIDTH_1PX];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [button setBackgroundColor:[UIColor colorGreenDefault]];
        [button setTitle:LOCSTR(@"登录") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _loginButton = button;
    }
    return _loginButton;
}

@end
