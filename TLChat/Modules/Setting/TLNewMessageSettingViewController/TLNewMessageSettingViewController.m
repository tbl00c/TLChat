//
//  TLNewMessageSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLNewMessageSettingViewController.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLNewMessageSettingVCSectionType) {
    TLNewMessageSettingVCSectionTypeOn,
    TLNewMessageSettingVCSectionTypeDetail,
    TLNewMessageSettingVCSectionTypeOff,
};

@implementation TLNewMessageSettingViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"新消息通知")];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    
    [self loadNewMessageSettingUI];
}

#pragma mark - # UI
- (void)loadNewMessageSettingUI
{
    self.clear();
    
    {
        NSInteger sectionTag = TLNewMessageSettingVCSectionTypeOn;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        self.setHeader(VIEW_ST_HEADER).toSection(sectionTag).withDataModel(@"微信未打开时");
        
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"新消息通知")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"语音和视频通话提醒")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    {
        NSInteger sectionTag = TLNewMessageSettingVCSectionTypeDetail;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 5, 0));
        
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"通知显示消息详情")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
    }
    
    {
        NSInteger sectionTag = TLNewMessageSettingVCSectionTypeOff;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        self.setHeader(VIEW_ST_HEADER).toSection(sectionTag).withDataModel(@"微信打开时");
        
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"声音")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"震动")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    [self reloadView];
}

@end
