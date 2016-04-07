//
//  TLMomentsViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/5.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewController.h"
#import "TLMomentsProxy.h"

@interface TLMomentsViewController : TLTableViewController

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) TLMomentsProxy *proxy;

@end
