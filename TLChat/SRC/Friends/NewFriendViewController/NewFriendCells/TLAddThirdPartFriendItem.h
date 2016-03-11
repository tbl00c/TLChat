//
//  TLAddThirdPartFriendItem.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLAddThirdPartFriendItem : UIButton

/**
 *  第三方类型
 *  {
 *      TLThirdPartFriendTypeContacts
 *      TLThirdPartFriendTypeQQ
 *      TLThirdPartFriendTypeGoogle
 *  }
 */
@property (nonatomic, strong) NSString *itemTag;

- (id)initWithImagePath:(NSString *)imagePath andTitle:(NSString *)title;

@end
