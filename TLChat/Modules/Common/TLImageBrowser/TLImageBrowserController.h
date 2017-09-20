//
//  TLImageBrowserController.h
//  TLChat
//
//  Created by 李伯坤 on 16/5/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLImageBrowserController : UIViewController

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, assign) NSInteger curIndex;

- (id)initWithImages:(NSArray *)images curImageIndex:(NSInteger)index curImageRect:(CGRect)rect;

- (void)show;

@end
