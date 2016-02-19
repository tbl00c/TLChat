//
//  TLMacros.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#ifndef TLMacros_h
#define TLMacros_h

#pragma mark - SIZE
#define     SIZE_SCREEN         [UIScreen mainScreen].bounds.size
#define     WIDTH_SCREEN        [UIScreen mainScreen].bounds.size.width
#define     HEIGHT_SCREEN       [UIScreen mainScreen].bounds.size.height
#define     HEIGHT_STATUSBAR	20.0f
#define     HEIGHT_TABBAR       49.0f
#define     HEIGHT_NAVBAR       44.0f

#define mark - Default
#define     DEFAULT_AVATAR_PATH    @"default_head"

#pragma mark - Methods
#define     TLURL(urlString)    [NSURL URLWithString:urlString]
#define     TLColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]


#pragma mark - Path
#define     PATH_DOCUMENT       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]


#pragma mark - ThirdPart KEY
#define     UMENG_APPKEY       @"56b8ba33e0f55a15480020b0"

#endif /* TLMacros_h */
