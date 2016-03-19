//
//  TLCommonSettingHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLSettingGroup.h"

@interface TLCommonSettingHelper : NSObject

@property (nonatomic, strong) NSMutableArray *commonSettingData;

+ (NSMutableArray *)chatBackgroundSettingData;

@end
