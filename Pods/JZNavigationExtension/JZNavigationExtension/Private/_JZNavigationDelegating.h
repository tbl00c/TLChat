//
//  _JZNavigationControllerDelegate.h
//  
//
//  Created by Jazys on 8/29/16.
//  Copyright © 2016 Jazys. All rights reserved.
//

#import <UIKit/UINavigationController.h>

@interface _JZNavigationDelegating : NSObject <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

- (instancetype)initWithActionsPerformInDealloc:(dispatch_block_t)actionsPerformInDealloc;

@end

