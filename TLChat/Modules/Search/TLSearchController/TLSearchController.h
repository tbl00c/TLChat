//
//  TLSearchController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLSearchResultControllerProtocol.h"

@interface TLSearchController : UISearchController

@property (nonatomic, assign) BOOL enableVoiceInput;

+ (TLSearchController *)createWithResultsContrller:(UIViewController<TLSearchResultControllerProtocol> *)resultVC;

@end
