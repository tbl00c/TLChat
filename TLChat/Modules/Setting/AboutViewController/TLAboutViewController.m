//
//  TLAboutViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAboutViewController.h"
#import "TLAppConfig.h"
#import "TLAboutHeaderView.h"

#define     HEIGHT_TOPVIEW      100.0f

@interface TLAboutViewController ()

@property (nonatomic, strong) UILabel *cmpLabel;

@end

@implementation TLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"关于微信"];
    
    [self p_initAboutData];
    
    [self.tableView registerClass:[TLAboutHeaderView class] forHeaderFooterViewReuseIdentifier:@"TLAboutHeaderView"];

    [self.tableView.tableFooterView addSubview:self.cmpLabel];
    [self p_addMasonry];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    float footerHeight = SCREEN_HEIGHT - self.tableView.contentSize.height - NAVBAR_HEIGHT - HEIGHT_SETTING_TOP_SPACE;
    [self.tableView.tableFooterView setHeight:footerHeight];
}

#pragma mark - # Delegate
//MARK: UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        TLAboutHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLAboutHeaderView"];
        [headerView setImagePath:@"AppLogo"];
        [headerView setTitle:[NSString stringWithFormat:@"微信 TLChat %@", [TLAppConfig sharedConfig].version]];
        return headerView;
    }
    return nil;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return HEIGHT_TOPVIEW;
    }
    return 0;
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.cmpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.tableView.tableFooterView);
        make.bottom.mas_equalTo(self.tableView.tableFooterView).mas_offset(-1);
    }];
}

- (void)p_initAboutData
{
    TLSettingItem *item1 = TLCreateSettingItem(@"去评分");
    TLSettingItem *item2 = TLCreateSettingItem(@"欢迎页");
    TLSettingItem *item3 = TLCreateSettingItem(@"功能介绍");
    TLSettingItem *item4 = TLCreateSettingItem(@"系统通知");
    TLSettingItem *item5 = TLCreateSettingItem(@"举报与投诉");
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, (@[item1, item2, item3, item4, item5]));
    self.data = @[group1].mutableCopy;
}

#pragma mark - # Getters
- (UILabel *)cmpLabel
{
    if (_cmpLabel == nil) {
        _cmpLabel = [[UILabel alloc] init];
        [_cmpLabel setText:@"高仿微信 仅供学习\nhttps://github.com/tbl00c/TLChat"];
        [_cmpLabel setTextAlignment:NSTextAlignmentCenter];
        [_cmpLabel setTextColor:[UIColor grayColor]];
        [_cmpLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_cmpLabel setNumberOfLines:2];
    }
    return _cmpLabel;
}

@end
