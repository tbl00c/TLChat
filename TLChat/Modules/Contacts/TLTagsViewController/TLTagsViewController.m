//
//  TLTagsViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTagsViewController.h"
#import "TLFriendHelper.h"
#import "TLTagItemCell.h"
#import "TLUserGroup.h"

typedef NS_ENUM(NSInteger, TLTagsVCSectionType) {
    TLTagsVCSectionTypeItems,
};

@interface TLTagsViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@end

@implementation TLTagsViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"标签")];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addRightBarButtonWithTitle:LOCSTR(@"新建") actionBlick:^{
        
    }];
    
    self.tableView = self.view.addTableView(1)
    .backgroundColor([UIColor whiteColor]).separatorStyle(UITableViewCellSeparatorStyleNone)
    .tableFooterView([UIView new])
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;
    
    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *data = [TLFriendHelper sharedFriendHelper].tagsData;
    [self loadListUIWithData:data];
}

- (void)loadListUIWithData:(NSArray *)data
{
    self.tableViewAngel.clear();
    if (data.count == 0) {
        [self.tableView showEmptyViewWithTitle:LOCSTR(@"无标签")];
    }
    else {
        self.tableViewAngel.addSection(TLTagsVCSectionTypeItems);
        self.tableViewAngel.addCells(@"TLTagItemCell").toSection(TLTagsVCSectionTypeItems).withDataModelArray(data).selectedAction(^ (id data) {
            
        });
    }
    [self.tableView reloadData];
}

@end
