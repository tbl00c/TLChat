
//
//  TLMomentExtensionView.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionView.h"
#import "TLMomentExtensionView+TableView.h"

@interface TLMomentExtensionView ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TLMomentExtensionView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor grayColor]];
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(10.0f);
            make.left.and.right.and.bottom.mas_equalTo(self);
        }];
        
        [self registerCellForTableView:self.tableView];
    }
    return self;
}

- (void)setExtension:(TLMomentExtension *)extension
{
    _extension = extension;
    [self.tableView reloadData];
}

#pragma mark - # Getter -
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setBackgroundColor:[UIColor redColor]];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setScrollsToTop:NO];
        [_tableView setScrollEnabled:NO];
    }
    return _tableView;
}

@end
