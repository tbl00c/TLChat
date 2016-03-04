//
//  TLSettingHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLSettingGroup.h"

typedef void (^ CompleteBlock)(NSMutableArray *data);

@interface TLSettingHelper : NSObject

@property (nonatomic, strong) NSMutableArray *mineSettingData;

@end
