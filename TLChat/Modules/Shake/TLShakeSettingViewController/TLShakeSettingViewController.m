//
//  TLShakeSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLShakeSettingViewController.h"
#import "NSFileManager+TLChat.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLShakeSettingVCSectionType) {
    TLShakeSettingVCSectionTypeUI,
    TLShakeSettingVCSectionTypeHistory,
    TLShakeSettingVCSectionTypeMessage,
};

@interface TLShakeSettingViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation TLShakeSettingViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    [self setTitle:LOCSTR(@"摇一摇设置")];
    
    [self loadShakeSettingUI];
}

#pragma mark - # UI
- (void)loadShakeSettingUI
{
    @weakify(self);
    self.clear();
    
    // UI
    {
        NSInteger sectionTag = TLShakeSettingVCSectionTypeUI;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        
        // 默认背景图
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"使用默认背景图片")).selectedAction(^ (id data) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Shake_Image_Path"];
            [TLUIUtility showAlertWithTitle:@"已恢复默认背景图"];
        });
        
        // 换张背景图
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"换张背景图片")).selectedAction(^ (id data) {
            @strongify(self);
            [self p_changeShakeBGImage];
        });
        
        // 音效
        TLSettingItem *voiceItem = TLCreateSettingItem(@"音效");
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(voiceItem).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    // 历史
    {
        NSInteger sectionTag = TLShakeSettingVCSectionTypeHistory;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 打招呼的人
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"打招呼的人")).selectedAction(^ (id data) {

        });
        
        // 摇到的历史
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"摇到的历史")).selectedAction(^ (id data) {

        });
    }
    
    // 消息
    {
        NSInteger sectionTag = TLShakeSettingVCSectionTypeMessage;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 40, 0));
        
        // 摇一摇消息
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"摇一摇消息")).selectedAction(^ (id data) {

        });
    }
    
    [self reloadView];
}

#pragma mark - # Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    NSData *imageData = (UIImagePNGRepresentation(image) ? UIImagePNGRepresentation(image) :UIImageJPEGRepresentation(image, 1));
    NSString *imageName = [NSString stringWithFormat:@"%lf.jpg", [NSDate date].timeIntervalSince1970];
    NSString *imagePath = [NSFileManager pathUserSettingImage:imageName];
    [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil];
    [[NSUserDefaults standardUserDefaults] setObject:imageName forKey:@"Shake_Image_Path"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - # Private Methods
- (void)p_changeShakeBGImage
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePickerController setAllowsEditing:YES];
    [imagePickerController setDelegate:self];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

@end
