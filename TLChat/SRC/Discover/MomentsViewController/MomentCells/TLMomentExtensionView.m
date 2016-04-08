
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
        [self addSubview:self.tableView];
        
        [self p_addMasonry];
        
        [self registerCellForTableView:self.tableView];
    }
    return self;
}


#pragma mark - # Private Methods -
- (void)p_addMasonry
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(20.0f);
        make.left.and.right.and.bottom.mas_equalTo(self);
    }];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
}

#pragma mark - # Getter -
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setScrollsToTop:NO];
        [_tableView setScrollEnabled:NO];
    }
    return _tableView;
}

@end
