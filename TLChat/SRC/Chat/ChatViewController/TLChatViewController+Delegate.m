//
//  TLChatViewController+Delegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatViewController+Delegate.h"
#import "TLExpressionViewController.h"
#import "TLMyExpressionViewController.h"

@implementation TLChatViewController (Delegate)

#pragma mark - Delegate -
//MARK: TLMoreKeyboardDelegate
- (void)moreKeyboard:(id)keyboard didSelectedFunctionItem:(TLMoreKeyboardItem *)funcItem
{
    if (funcItem.type == TLMoreKeyboardItemTypeCamera || funcItem.type == TLMoreKeyboardItemTypeImage) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        if (funcItem.type == TLMoreKeyboardItemTypeCamera) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
            }
            else {
                [UIAlertView bk_alertViewWithTitle:@"错误" message:@"相机初始化失败"];
                return;
            }
        }
        else {
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        [self presentViewController:imagePickerController animated:YES completion:nil];
        [imagePickerController.rac_imageSelectedSignal subscribeNext:^(id x) {
            [imagePickerController dismissViewControllerAnimated:YES completion:^{
                UIImage *image = [x objectForKey:UIImagePickerControllerOriginalImage];
                [self sendImageMessage:image];
            }];
        } completed:^{
            [imagePickerController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"选中”%@“ 按钮", funcItem.title] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}

//MARK: TLEmojiKeyboardDelegate
- (void)emojiKeyboardEmojiEditButtonDown
{
    TLExpressionViewController *expressionVC = [[TLExpressionViewController alloc] init];
    TLNavigationController *navC = [[TLNavigationController alloc] initWithRootViewController:expressionVC];
    [self presentViewController:navC animated:YES completion:nil];
}

- (void)emojiKeyboardMyEmojiEditButtonDown
{
    TLMyExpressionViewController *myExpressionVC = [[TLMyExpressionViewController alloc] init];
    TLNavigationController *navC = [[TLNavigationController alloc] initWithRootViewController:myExpressionVC];
    [self presentViewController:navC animated:YES completion:nil];
}

@end
