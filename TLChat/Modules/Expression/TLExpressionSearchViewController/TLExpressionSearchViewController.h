//
//  TLExpressionSearchViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"
#import "TLSearchControllerProtocol.h"

@interface TLExpressionSearchViewController : TLViewController <TLSearchControllerProtocol>

@property (nonatomic, copy) void (^itemClickAction)(TLExpressionSearchViewController *searchController, id data);

@end
