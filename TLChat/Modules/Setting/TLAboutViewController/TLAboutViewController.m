//
//  TLAboutViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAboutViewController.h"
#import "TLWebViewController.h"
#import "TLAppConfig.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLAboutVCSectionType) {
    TLAboutVCSectionTypeItems,
};

@interface TLAboutViewController ()

@property (nonatomic, strong) UILabel *cmpLabel;

@end

@implementation TLAboutViewController

- (void)loadView
{
    [super loadView];
    [self.navigationItem setTitle:LOCSTR(@"关于微信")];
    [self.collectionView setBackgroundColor:[UIColor colorGrayBG]];
    
    self.addSection(TLAboutVCSectionTypeItems);
    
    [self loadAboutUI];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.setFooter(@"TLAboutFooterView").toSection(TLAboutVCSectionTypeItems).withDataModel(@([self p_footerHeight]));
}

#pragma mark - # UI
- (void)loadAboutUI
{
    @weakify(self);
    {
        NSInteger sectionTag = TLAboutVCSectionTypeItems;
        
        // header
        NSString *versionInfo = [NSString stringWithFormat:@"TLChat %@", [TLAppConfig sharedConfig].version];
        self.setHeader(@"TLAboutHeaderView").toSection(sectionTag).withDataModel(versionInfo);
        
        // 评分
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"去评分")).selectedAction(^ (id data) {
            @strongify(self);
            TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"https://github.com/tbl00c/TLChat"];
            PushVC(webVC);
        });
        
        // 欢迎页
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"欢迎页"));
        
        // 功能介绍
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"功能介绍")).selectedAction(^ (id data) {
            @strongify(self);
            TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"https://github.com/tbl00c/TLChat/blob/master/README.md"];
            PushVC(webVC);
        });
        
        // footer
        self.setFooter(@"TLAboutFooterView").toSection(sectionTag).withDataModel(@([self p_footerHeight]));
    }
    
    [self reloadView];
}

#pragma mark - # Private
- (CGFloat)p_footerHeight
{
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.height;
    CGFloat headerHeight = 120.0f;
    CGFloat cellsHeight = self.sectionForTag(TLAboutVCSectionTypeItems).dataModelArray.count * 44.0f;
    CGFloat footerHeight = SCREEN_HEIGHT - statusHeight - navHeight - headerHeight - cellsHeight;
    return footerHeight;
}

@end
