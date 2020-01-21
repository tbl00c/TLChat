//
//  TLExpressionSearchResultViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"
#import "TLSearchResultControllerProtocol.h"

@interface TLExpressionSearchResultViewController : TLViewController <TLSearchResultControllerProtocol>

@property (nonatomic, copy) void (^itemClickAction)(TLExpressionSearchResultViewController *searchController, id data);

@end
