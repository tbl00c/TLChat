//
//  TLShakeSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLShakeSettingViewController.h"
#import "TLShakeHelper.h"

@interface TLShakeSettingViewController ()

@property (nonatomic, strong) TLShakeHelper *helper;

@end

@implementation TLShakeSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"摇一摇设置"];
    
    self.helper = [[TLShakeHelper alloc] init];
    self.data = self.helper.shakeSettingData;
}

#pragma mark - Delegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"使用默认背景图片"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Shake_Image_Path"];
        [UIAlertView bk_alertViewWithTitle:@"已恢复默认背景图"];
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

@end
