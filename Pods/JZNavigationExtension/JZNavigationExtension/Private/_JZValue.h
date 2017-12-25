//
//  _JZValue.h
//  navbarTest
//
//  Created by 李伯坤 on 2017/11/23.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _JZValue : NSObject

+ (_JZValue *)valueWithWeakObject:(id)anObject;
@property (weak, readonly) id weakObjectValue;

@end
