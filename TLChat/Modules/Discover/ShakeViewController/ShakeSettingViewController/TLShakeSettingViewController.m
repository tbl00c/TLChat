//
//  TLShakeSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLShakeSettingViewController.h"
#import "NSFileManager+TLChat.h"

@implementation TLShakeSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"摇一摇设置"];
    
    [self p_initShakeSettingData];
}

#pragma mark - # Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"使用默认背景图片"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Shake_Image_Path"];
        [TLUIUtility showAlertWithTitle:@"已恢复默认背景图"];
    }
    else if ([item.title isEqualToString:@"换张背景图片"]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePickerController setAllowsEditing:YES];
        [self presentViewController:imagePickerController animated:YES completion:nil];
        [imagePickerController.rac_imageSelectedSignal subscribeNext:^(id x) {
            [imagePickerController dismissViewControllerAnimated:YES completion:^{
                UIImage *image = [x objectForKey:UIImagePickerControllerEditedImage];
                if (image == nil) {
                    image = [x objectForKey:UIImagePickerControllerOriginalImage];
                }
                NSData *imageData = (UIImagePNGRepresentation(image) ? UIImagePNGRepresentation(image) :UIImageJPEGRepresentation(image, 1));
                NSString *imageName = [NSString stringWithFormat:@"%lf.jpg", [NSDate date].timeIntervalSince1970];
                NSString *imagePath = [NSFileManager pathUserSettingImage:imageName];
                [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil];
                [[NSUserDefaults standardUserDefaults] setObject:imageName forKey:@"Shake_Image_Path"];
            }];
        } completed:^{
            [imagePickerController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - # Private Methods
- (void)p_initShakeSettingData
{
    TLSettingItem *item1 = TLCreateSettingItem(@"使用默认背景图片");
    item1.showDisclosureIndicator = NO;
    TLSettingItem *item2 = TLCreateSettingItem(@"换张背景图片");
    TLSettingItem *item3 = TLCreateSettingItem(@"音效");
    item3.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, (@[item1, item2, item3]));
    
    TLSettingItem *item5 = TLCreateSettingItem(@"打招呼的人");
    TLSettingItem *item6 = TLCreateSettingItem(@"摇到的历史");
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[item5, item6]));
    
    TLSettingItem *item7 = TLCreateSettingItem(@"摇一摇消息");
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, nil, (@[item7]));
    
    self.data = @[group1, group2, group3].mutableCopy;
}

@end
