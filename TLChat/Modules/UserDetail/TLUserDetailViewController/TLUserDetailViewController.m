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
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
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
//    // 2
//    arr = [[NSMutableArray alloc] init];
//    if (userInfo.detailInfo.phoneNumber.length > 0) {
//        TLInfo *tel = TLCreateInfo(@"电话号码", userInfo.detailInfo.phoneNumber);
//        tel.showDisclosureIndicator = NO;
//        [arr addObject:tel];
//    }
//    if (userInfo.detailInfo.tags.count == 0) {
//        TLInfo *remark = TLCreateInfo(@"设置备注和标签" , nil);
//        [arr insertObject:remark atIndex:0];
//    }
//    else {
//        NSString *str = [userInfo.detailInfo.tags componentsJoinedByString:@","];
//        TLInfo *remark = TLCreateInfo(@"标签", str);
//        [arr addObject:remark];
//    }
//    [data addObject:arr];
//    arr = [[NSMutableArray alloc] init];
//    
//    // 3
//    if (userInfo.detailInfo.location.length > 0) {
//        TLInfo *location = TLCreateInfo(@"地区", userInfo.detailInfo.location);
//        location.showDisclosureIndicator = NO;
//        location.disableHighlight = YES;
//        [arr addObject:location];
//    }
//    TLInfo *album = TLCreateInfo(@"个人相册", nil);
//    album.userInfo = userInfo.detailInfo.albumArray;
//    album.type = TLInfoTypeOther;
//    [arr addObject:album];
//    TLInfo *more = TLCreateInfo(@"更多", nil);
//    [arr addObject:more];
//    [data addObject:arr];
//    arr = [[NSMutableArray alloc] init];
//    
//    // 4
//    TLInfo *sendMsg = TLCreateInfo(@"发消息", nil);
//    sendMsg.type = TLInfoTypeButton;
//    sendMsg.titleColor = [UIColor whiteColor];
//    sendMsg.buttonBorderColor = [UIColor colorGrayLine];
//    [arr addObject:sendMsg];
//    if (![userInfo.userID isEqualToString:[TLUserHelper sharedHelper].userID]) {
//        TLInfo *video = TLCreateInfo(@"视频聊天", nil);
//        video.type = TLInfoTypeButton;
//        video.buttonBorderColor = [UIColor colorGrayLine];
//        video.buttonColor = [UIColor whiteColor];
//        [arr addObject:video];
//    }
//    [data addObject:arr];
    
    
    self.clear();
    
    // 基本信息
    self.addSection(TLUserDetailVCSectionTypeBaseInfo).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    self.addCell(@"TLUserDetailBaseInfoCell").toSection(TLUserDetailVCSectionTypeBaseInfo).withDataModel(userModel);
    
    // 基本信息
    self.addSection(TLUserDetailVCSectionTypeCustom).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    
    // 基本信息
    self.addSection(TLUserDetailVCSectionTypeDetailInfo).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    
    // 基本信息
    self.addSection(TLUserDetailVCSectionTypeFunction).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    
    [self reloadView];
}

@end
