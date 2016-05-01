//
//  TLChatBackgroundSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBackgroundSettingViewController.h"
#import "TLCommonSettingHelper.h"
#import "UIImage+Size.h"

#import "TLChatBackgroundSelectViewController.h"
#import "TLChatViewController.h"

@interface TLChatBackgroundSettingViewController () <TLActionSheetDelegate>

@end

@implementation TLChatBackgroundSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"聊天背景"];
    
    self.data = [TLCommonSettingHelper chatBackgroundSettingData];
}

#pragma mark - Delegate
//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.data.count > 0) {
        return self.partnerID.length > 0 ? self.data.count - 1 : self.data.count;
    }
    return 0;
}

//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"选择背景图"]) {
        TLChatBackgroundSelectViewController *bgSelectVC = [[TLChatBackgroundSelectViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bgSelectVC animated:YES];
    }
    else if ([item.title isEqualToString:@"从手机相册中选择"]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
        [imagePickerController.rac_imageSelectedSignal subscribeNext:^(id x) {
            [imagePickerController dismissViewControllerAnimated:YES completion:^{
                UIImage *image = [x objectForKey:UIImagePickerControllerOriginalImage];
                [self p_setChatBackgroundImage:image];
            }];
        } completed:^{
            [imagePickerController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    else if ([item.title isEqualToString:@"拍一张"]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [UIAlertView bk_alertViewWithTitle:@"错误" message:@"相机初始化失败"];
        }
        else {
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:imagePickerController animated:YES completion:nil];
            [imagePickerController.rac_imageSelectedSignal subscribeNext:^(id x) {
                [imagePickerController dismissViewControllerAnimated:YES completion:^{
                    UIImage *image = [x objectForKey:UIImagePickerControllerOriginalImage];
                    [self p_setChatBackgroundImage:image];
                }];
            } completed:^{
                [imagePickerController dismissViewControllerAnimated:YES completion:nil];
            }];
            
        }
    }
    else if ([item.title isEqualToString:@"将背景应用到所有聊天场景"]) {
        TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"将背景应用到所有聊天场景" otherButtonTitles:nil];
        [actionSheet show];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//MARK: TLActionSheetDelegate
- (void)actionSheet:(TLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        for (NSString *key in [NSUserDefaults standardUserDefaults].dictionaryRepresentation.allKeys) {
            if ([key hasPrefix:@"CHAT_BG_"] && ![key isEqualToString:@"CHAT_BG_ALL"]) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
            }
        }
        [[TLChatViewController sharedChatVC] resetChatVC];
    }
}

#pragma mark - Private Methods -
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
    
    [[TLChatViewController sharedChatVC] resetChatVC];
}

@end
