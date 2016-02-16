//
//  TLChatBaseViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController.h"
#import "TLChatToolBar.h"

@interface TLChatBaseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *chatTableView;

@property (nonatomic, strong) TLChatToolBar *chatToolBar;

@end

@implementation TLChatBaseViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.chatTableView];
    [self.view addSubview:self.chatToolBar];
    
    [self p_addMasonry];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) p_addMasonry
{
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.chatToolBar.mas_top);
    }];
    [self.chatToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_TABBAR);
    }];
}

#pragma mark - 
#pragma mark UITableViewDataSouce
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    return cell;
}

#pragma mark - Event Response
- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.chatToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.chatToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-keyboardFrame.size.height);
    }];
    [self.view layoutIfNeeded];
}


#pragma mark - Getter
- (UITableView *) chatTableView
{
    if (_chatTableView == nil) {
        _chatTableView = [[UITableView alloc] init];
        [_chatTableView setTableFooterView:[[UIView alloc] init]];
        [_chatTableView setDataSource:self];
        [_chatTableView setDelegate:self];
    }
    return _chatTableView;
}

- (UIToolbar *) chatToolBar
{
    if (_chatToolBar == nil) {
        _chatToolBar = [[TLChatToolBar alloc] init];
    }
    return _chatToolBar;
}

@end
