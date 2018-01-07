//
//  TLUserDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUserDetailViewController.h"
#import "TLFriendDetailSettingViewController.h"
#import "TLFriendHelper+Detail.h"
#import "TLUserDetailBaseKVCell.h"
#import "TLChatViewController.h"
#import "TLLaunchManager.h"
#import "TLUserHelper.h"
#import "MWPhotoBrowser.h"

typedef NS_ENUM(NSInteger, TLUserDetailVCSectionType) {
    TLUserDetailVCSectionTypeBaseInfo,
    TLUserDetailVCSectionTypeCustom,
    TLUserDetailVCSectionTypeDetailInfo,
    TLUserDetailVCSectionTypeFunction,
};

@implementation TLUserDetailViewController

- (instancetype)initWithUserModel:(TLUser *)userModel
{
    if (self = [super init]) {
        _userModel = userModel;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"详细资料"];
    [self.collectionView setBackgroundColor:[UIColor colorGrayBG]];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    @weakify(self);
    [self addRightBarButtonWithImage:TLImage(@"nav_more") actionBlick:^{
        @strongify(self);
        TLFriendDetailSettingViewController *detailSetiingVC = [[TLFriendDetailSettingViewController alloc] initWithUserModel:self.userModel];
        PushVC(detailSetiingVC);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadUIWithUserModel:self.userModel];
}

#pragma mark - # UI
- (void)loadUIWithUserModel:(TLUser *)userModel
{
    @weakify(self);
    
    self.clear();
    
    // 基本信息
    self.addSection(TLUserDetailVCSectionTypeBaseInfo).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    self.addCell(@"TLUserDetailBaseInfoCell").toSection(TLUserDetailVCSectionTypeBaseInfo).withDataModel(userModel).eventAction(^ id(NSInteger eventType, id data) {
        @strongify(self);
        TLUser *userModel = data;
        NSURL *url = TLURL(userModel.avatarURL);
        MWPhoto *photo = [MWPhoto photoWithURL:url];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:@[photo]];
        UINavigationController *broserNavC = [[UINavigationController alloc] initWithRootViewController:browser];
        [self presentViewController:broserNavC animated:NO completion:nil];
        return nil;
    });
    
    // 自定义信息
    self.addSection(TLUserDetailVCSectionTypeCustom).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    // 电话号码
    if (userModel.detailInfo.phoneNumber.length > 0) {
        TLUserDetailKVModel *model = createUserDetailKVModel(@"电话号码", userModel.detailInfo.phoneNumber);
        model.hiddenArrow = YES;
        self.addCell(@"TLUserDetailPhoneKVCell").toSection(TLUserDetailVCSectionTypeCustom).withDataModel(model);
    }
    // 备注及标签
    if (userModel.detailInfo.tags.count == 0) {
        self.addCell(@"TLUserDetailTitleCell").toSection(TLUserDetailVCSectionTypeCustom).withDataModel(@"设置备注和标签");
    }
    else {
        NSString *tags = [userModel.detailInfo.tags componentsJoinedByString:@","];
        self.addCell(@"TLUserDetailTagsKVCell").toSection(TLUserDetailVCSectionTypeCustom).withDataModel(createUserDetailKVModel(@"标签", tags));
    }
    
    // 详细信息
    self.addSection(TLUserDetailVCSectionTypeDetailInfo).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    // 地区
    if (userModel.detailInfo.location.length > 0) {
        TLUserDetailKVModel *model = createUserDetailKVModel(@"地区", userModel.detailInfo.location);
        model.selectable = NO;
        model.hiddenArrow = YES;
        self.addCell(@"TLUserDetailNormalKVCell").toSection(TLUserDetailVCSectionTypeDetailInfo).withDataModel(model);
    }
    // 相册
    if (userModel.detailInfo.albumArray.count > 0) {
        TLUserDetailKVModel *model = createUserDetailKVModel(@"个人相册", userModel.detailInfo.albumArray);
        self.addCell(@"TLUserDetailAlbumCell").toSection(TLUserDetailVCSectionTypeDetailInfo).withDataModel(model);
    }
    // 其他
    self.addCell(@"TLUserDetailTitleCell").toSection(TLUserDetailVCSectionTypeDetailInfo).withDataModel(@"更多");
    
    // 功能
    self.addSection(TLUserDetailVCSectionTypeFunction).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    // 发消息
    self.addCell(@"TLUserDetailChatButtonCell").toSection(TLUserDetailVCSectionTypeFunction).withDataModel(@"发消息").eventAction(^ id(NSInteger eventType, id data) {
        @strongify(self);
        TLChatViewController *chatVC = [[TLChatViewController alloc] initWithUserId:self.userModel.userID];
        
        if ([TLLaunchManager sharedInstance].tabBarController.selectedIndex != 0) {
            [self.navigationController popToRootViewControllerAnimated:NO];
            UINavigationController *navC = [TLLaunchManager sharedInstance].tabBarController.childViewControllers[0];
            [[TLLaunchManager sharedInstance].tabBarController setSelectedIndex:0];
            [chatVC setHidesBottomBarWhenPushed:YES];
            [navC pushViewController:chatVC animated:YES];
        }
        else {
            PushVC(chatVC);
        }
        return nil;
    });
    // 语音聊天
    if (![userModel.userID isEqualToString:[TLUserHelper sharedHelper].userID]) {
        self.addCell(@"TLUserDetailViewChatButtonCell").toSection(TLUserDetailVCSectionTypeFunction).withDataModel(@"视频聊天").eventAction(^ id(NSInteger eventType, id data) {
            @strongify(self);
            return nil;
        });
    }
    
    [self reloadView];
}

@end
