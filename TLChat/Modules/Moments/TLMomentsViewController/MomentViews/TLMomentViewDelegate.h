//
//  TLMomentViewDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/5/2.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLMoment;
@class TLUser;
@protocol TLMomentViewDelegate <NSObject>

- (void)momentViewClickImage:(NSArray *)images atIndex:(NSInteger)index;

- (void)momentViewWithModel:(TLMoment *)moment didClickUser:(TLUser *)user;

- (void)momentViewWithModel:(TLMoment *)moment jumpToUrl:(NSString *)url;

@end
