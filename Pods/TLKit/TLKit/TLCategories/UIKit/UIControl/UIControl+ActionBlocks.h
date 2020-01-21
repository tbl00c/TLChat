//
//  UIControl+ActionBlocks.h
//  Pods
//
//  Created by 李伯坤 on 2017/8/31.
//
//

#import <UIKit/UIKit.h>

@interface UIControl (ActionBlocks)

- (void)tt_touchDown:(void (^)(void))eventBlock;
- (void)tt_touchDownRepeat:(void (^)(void))eventBlock;
- (void)tt_touchDragInside:(void (^)(void))eventBlock;
- (void)tt_touchDragOutside:(void (^)(void))eventBlock;
- (void)tt_touchDragEnter:(void (^)(void))eventBlock;
- (void)tt_touchDragExit:(void (^)(void))eventBlock;
- (void)tt_touchUpInside:(void (^)(void))eventBlock;
- (void)tt_touchUpOutside:(void (^)(void))eventBlock;
- (void)tt_touchCancel:(void (^)(void))eventBlock;
- (void)tt_valueChanged:(void (^)(void))eventBlock;
- (void)tt_editingDidBegin:(void (^)(void))eventBlock;
- (void)tt_editingChanged:(void (^)(void))eventBlock;
- (void)tt_editingDidEnd:(void (^)(void))eventBlock;
- (void)tt_editingDidEndOnExit:(void (^)(void))eventBlock;

@end
