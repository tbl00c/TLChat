//
//  TLTextDisplayView.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/16.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTextDisplayView : UIView

@property (nonatomic, strong) NSAttributedString *attrString;

- (void)showInView:(UIView *)view withAttrText:(NSAttributedString *)attrText animation:(BOOL)animation;

@end
