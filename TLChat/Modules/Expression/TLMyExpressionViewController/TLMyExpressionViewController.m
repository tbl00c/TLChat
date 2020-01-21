//
//  TLMyExpressionViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMyExpressionViewController.h"
#import "TLExpressionDetailViewController.h"
#import "TLExpressionHelper.h"
#import "TLMyExpressionCell.h"

typedef NS_ENUM(NSInteger, TLMyExpressionVCSectionType) {
    TLMyExpressionVCSectionTypeMine,
    TLMyExpressionVCSectionTypeFunction,
};

@interface TLMyExpressionViewController () <TLMyExpressionCellDelegate>

@end

@implementation TLMyExpressionViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"我的表情")];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    
    @weakify(self);
    [self addRightBarButtonWithTitle:LOCSTR(@"排序") actionBlick:^{
    }];
    
    if (self.navigationController.rootViewController == self) {
        [self addLeftBarButtonWithTitle:LOCSTR(@"取消") actionBlick:^{
            @strongify(self);
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    
    [self loadMyExpressionVCUI];
}

#pragma mark - # UI
- (void)loadMyExpressionVCUI
{
    @weakify(self);
    self.clear();
    
    NSArray *expArray = [TLExpressionHelper sharedHelper].userEmojiGroups;
    if (expArray.count > 0) {
        self.addSection(TLMyExpressionVCSectionTypeMine).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        self.addCells(@"TLMyExpressionCell").toSection(TLMyExpressionVCSectionTypeMine).withDataModelArray(expArray).selectedAction(^ (id data) {
            @strongify(self);
            TLExpressionDetailViewController *detailVC = [[TLExpressionDetailViewController alloc] initWithGroupModel:data];
            PushVC(detailVC);
        });
        
        self.addSection(TLMyExpressionVCSectionTypeFunction).sectionInsets(UIEdgeInsetsMake(20, 0, 40, 0));
    }
    else {
        self.addSection(TLMyExpressionVCSectionTypeFunction).sectionInsets(UIEdgeInsetsMake(15, 0, 30, 0));
    }
    
    // 添加的表情
    self.addCell(CELL_ST_ITEM_NORMAL).toSection(TLMyExpressionVCSectionTypeFunction).withDataModel(TLCreateSettingItem(@"添加的表情")).selectedAction(^ (id data) {

    });
    
    // 购买的表情
    self.addCell(CELL_ST_ITEM_NORMAL).toSection(TLMyExpressionVCSectionTypeFunction).withDataModel(TLCreateSettingItem(@"购买的表情")).selectedAction(^ (id data) {

    });
}

#pragma mark - # Delegate
//MARK: TLMyExpressionCellDelegate
- (void)myExpressionCellDeleteButtonDown:(TLExpressionGroupModel *)group
{
    BOOL ok = [[TLExpressionHelper sharedHelper] deleteExpressionGroupByID:group.gId];
    if (ok) {
        self.deleteCell.byDataModel(group);
        if (self.sectionForTag(TLMyExpressionVCSectionTypeMine).dataModelArray.count == 0) {
            self.deleteSection(TLMyExpressionVCSectionTypeMine);
            self.sectionForTag(TLMyExpressionVCSectionTypeFunction).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        }
        [self reloadView];
    }
    else {
        [TLUIUtility showErrorHint:@"表情包删除失败"];
    }
}

@end
