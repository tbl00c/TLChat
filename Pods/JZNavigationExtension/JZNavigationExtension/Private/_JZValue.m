//
//  _JZValue.m
//  navbarTest
//
//  Created by 李伯坤 on 2017/11/23.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "_JZValue.h"

@implementation _JZValue
@synthesize weakObjectValue = _weakObjectValue;

+ (_JZValue *)valueWithWeakObject:(id)anObject {
    _JZValue *value = [[self alloc] init];
    value->_weakObjectValue = anObject;
    return value;
}

@end
