//
//  TLChatBackgroundViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBackgroundViewController.h"
#import "TLChatBackgroundSelectViewController.h"
#import "TLChatNotificationKey.h"
#import "NSFileManager+TLChat.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLChatBackgroundVCSectionType) {
    TLChatBackgroundVCSectionTypeDefault,
    TLChatBackgroundVCSectionTypeDIY,
    TLChatBackgroundVCSectionTypeFunction,
};

@interface TLChatBackgroundViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation TLChatBackgroundViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    [self setTitle:LOCSTR(@"聊天背景")];
    
    [self loadChatBGSettingUI];
}

#pragma mark - # UI
- (void)loadChatBGSettingUI
{
    @weakify(self);
    self.clear();
    
    {
        NSInteger sectionTag = TLChatBackgroundVCSectionTypeDefault;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"选择背景图")).selectedAction(^ (id data) {
            @strongify(self);
            TLChatBackgroundSelectViewController *bgSelectVC = [[TLChatBackgroundSelectViewController alloc] init];
            PushVC(bgSelectVC);
        });
    }
    
    {
        NSInteger sectionTag = TLChatBackgroundVCSectionTypeDIY;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        
        // 相册
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"从手机相册中选择")).selectedAction(^ (id data) {
            @strongify(self);
            [self p_selectFromAlbum];
        });
        
        // 拍照
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"拍一张")).selectedAction(^ (id data) {
            @strongify(self);
            [self p_takePhoto];
        });
    }
    
    if (self.partnerID.length == 0) {
        NSInteger sectionTag = TLChatBackgroundVCSectionTypeFunction;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        self.addCell(CELL_ST_ITEM_BUTTON).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"将背景应用到所有聊天场景")).selectedAction(^ (id data) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:nil clickAction:^(NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    for (NSString *key in [NSUserDefaults standardUserDefaults].dictionaryRepresentation.allKeys) {
                        if ([key hasPrefix:@"CHAT_BG_"] && ![key isEqualToString:@"CHAT_BG_ALL"]) {
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
                        }
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHAT_VIEW_RESET object:nil];
                }
            } cancelButtonTitle:@"取消" destructiveButtonTitle:@"将背景应用到所有聊天场景" otherButtonTitles:nil];
            [actionSheet show];
        });
    }
    
    [self reloadView];
}

#pragma mark - # Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self p_setChatBackgroundImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - # Private Methods
- (void)p_selectFromAlbum
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePickerController setDelegate:self];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)p_takePhoto
{
    @weakify(self);
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setDelegate:self];
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [TLUIUtility showAlertWithTitle:@"错误" message:@"相机初始化失败"];
    }
    else {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)p_setChatBackgroundImage:(UIImage *)image
{
    image = [image scalingToSize:self.view.size];
    NSData *imageData = (UIImagePNGRepresentation(image) ? UIImagePNGRepresentation(image) :UIImageJPEGRepresentation(image, 1));
    NSString *imageName = [NSString stringWithFormat:@"%lf.jpg", [NSDate date].timeIntervalSince1970];
    NSString *imagePath = [NSFileManager pathUserChatBackgroundImage:imageName];;
    [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil];
    
    //TODO: 临时写法
    if (self.partnerID.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:imageName forKey:[@"CHAT_BG_" stringByAppendingString:self.partnerID]];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:imageName forKey:@"CHAT_BG_ALL"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHAT_VIEW_RESET object:nil];
}

@end
