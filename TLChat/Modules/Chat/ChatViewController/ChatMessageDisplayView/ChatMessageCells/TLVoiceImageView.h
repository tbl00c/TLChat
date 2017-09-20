//
//  TLVoiceImageView.h
//  TLChat
//
//  Created by 李伯坤 on 16/7/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLVoiceImageView : UIImageView

@property (nonatomic, assign) BOOL isFromMe;

- (void)startPlayingAnimation;

- (void)stopPlayingAnimation;

@end
