//
//  UINavigationController+JZPrivate.m
//  navbarTest
//
//  Created by 李伯坤 on 2017/11/22.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UINavigationController+JZPrivate.h"
#import "UINavigationController+JZExtension.h"
#import "_JZNavigationDelegating.h"
#import <objc/runtime.h>

@implementation UINavigationController (JZPrivate)

__attribute__((constructor)) static void JZ_Inject(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        void (^jz_method_swizzling)(Class, SEL, SEL) = ^(Class class, SEL originalSelector, SEL swizzledSelector) {
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        };
        
        jz_method_swizzling([UINavigationController class], @selector(setDelegate:), @selector(jz_setDelegate:));
        jz_method_swizzling([UINavigationController class], @selector(viewDidLoad), @selector(jz_viewDidLoad));
        jz_method_swizzling([UINavigationController class], @selector(pushViewController:animated:), @selector(jz_pushViewController:animated:));
    });
}

#pragma mark - # Methods Swizzling
- (void)jz_viewDidLoad {
    //    NSAssert(!self.delegate, @"Set delegate should be invoked when viewDidLoad");
    self.delegate = self.delegate;
    [self.interactivePopGestureRecognizer setValue:@NO forKey:@"canPanVertically"];
    self.interactivePopGestureRecognizer.delegate = self.jz_navigationDelegate;
    [self jz_viewDidLoad];
}

- (void)jz_setDelegate:(NSObject <UINavigationControllerDelegate> *)delegate {
    
    if ([self.delegate isEqual:delegate]) {
        return;
    }
    
    static NSString *_JZNavigationDelegatingTrigger = @"_JZNavigationDelegatingTrigger";
    
    if (![self.delegate isEqual:self.jz_navigationDelegate]) {
        objc_setAssociatedObject(self.delegate, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        @try {
            [(NSObject *)self.delegate removeObserver:self.delegate forKeyPath:_JZNavigationDelegatingTrigger context:_cmd]; }
        @catch (NSException *exception) {
        }
    }
    if (!delegate) {
        delegate = self.jz_navigationDelegate;
    } else {
        NSAssert([delegate isKindOfClass:[NSObject class]], @"Must inherit form NSObject!");
        
        [delegate addObserver:delegate forKeyPath:_JZNavigationDelegatingTrigger options:NSKeyValueObservingOptionNew context:_cmd];
        
        __unsafe_unretained typeof(delegate) unretained_delegate = delegate;
        objc_setAssociatedObject(delegate, _cmd, [[_JZNavigationDelegating alloc] initWithActionsPerformInDealloc:^{
            @try {
                [unretained_delegate removeObserver:unretained_delegate forKeyPath:_JZNavigationDelegatingTrigger context:_cmd]; }
            @catch (NSException *exception) {
            }
        }], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        void (^jz_add_replace_method)(id, SEL, IMP) = ^(id object, SEL sel, IMP imp) {
            Method method = class_getInstanceMethod([_JZNavigationDelegating class], sel);
            const char *types = method_getTypeEncoding(method);
            class_addMethod([object class], sel, imp, types);
            class_replaceMethod(object_getClass(object), sel, method_getImplementation(method), types);
        };
        jz_add_replace_method(delegate, @selector(navigationController:willShowViewController:animated:), imp_implementationWithBlock(^{}));
    }
    
    [self jz_setDelegate:delegate];
}

- (void)jz_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.jz_isPushing = YES;
    [self jz_pushViewController:viewController animated:animated];
    
    // IOS11 fix
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

#pragma mark - # operation
- (void)setJz_operation:(UINavigationControllerOperation)jz_operation {
    objc_setAssociatedObject(self, @selector(jz_operation), @(jz_operation), OBJC_ASSOCIATION_ASSIGN);
}
- (UINavigationControllerOperation)jz_operation {
    UINavigationControllerOperation operation = [objc_getAssociatedObject(self, _cmd) integerValue];
    
    if (operation == UINavigationControllerOperationNone) {
        if ([self.viewControllers containsObject:[self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey]]) {
            operation = UINavigationControllerOperationPush;
        } else {
            operation = UINavigationControllerOperationPop;
        }
        self.jz_operation = operation;
    }
    
    return operation;
}

#pragma mark - # Delegate
- (void)setJz_navigationDelegate:(_JZNavigationDelegating *)jz_navigationDelegate {
    objc_setAssociatedObject(self, @selector(jz_navigationDelegate), jz_navigationDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (_JZNavigationDelegating *)jz_navigationDelegate {
    _JZNavigationDelegating *jz_navigationDelegate = objc_getAssociatedObject(self, _cmd);
    if (!jz_navigationDelegate) {
        jz_navigationDelegate = [[_JZNavigationDelegating alloc] initWithNavigationController:self];
        self.jz_navigationDelegate = jz_navigationDelegate;
    }
    return jz_navigationDelegate;
}

@end

