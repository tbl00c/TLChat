//
//  TLGroupSearchResultViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"
#import "TLSearchResultControllerProtocol.h"

@interface TLGroupSearchResultViewController : TLViewController <TLSearchResultControllerProtocol>

- (instancetype)initWithJumpAction:(void (^)(__kindof UIViewController *vc))jumpAction;

@end
