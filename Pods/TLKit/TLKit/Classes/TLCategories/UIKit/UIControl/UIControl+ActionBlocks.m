//
//  UIControl+ActionBlocks.m
//  Pods
//
//  Created by 李伯坤 on 2017/8/31.
//
//

#import "UIControl+ActionBlocks.h"
#import <objc/runtime.h>

#define TL_UICONTROL_EVENT(methodName, eventName) \
-(void)methodName : (void (^)(void))eventBlock \
{ \
    objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC); \
    [self addTarget:self \
             action:@selector(methodName##Action:) \
   forControlEvents:UIControlEvent##eventName]; \
}\
-(void)methodName##Action:(id)sender \
{ \
    void (^block)() = objc_getAssociatedObject(self, @selector(methodName:)); \
    if (block) { \
        block(); \
    } \
}

@implementation UIControl (ActionBlocks)

TL_UICONTROL_EVENT(tt_touchDown, TouchDown)
TL_UICONTROL_EVENT(tt_touchDownRepeat, TouchDownRepeat)
TL_UICONTROL_EVENT(tt_touchDragInside, TouchDragInside)
TL_UICONTROL_EVENT(tt_touchDragOutside, TouchDragOutside)
TL_UICONTROL_EVENT(tt_touchDragEnter, TouchDragEnter)
TL_UICONTROL_EVENT(tt_touchDragExit, TouchDragExit)
TL_UICONTROL_EVENT(tt_touchUpInside, TouchUpInside)
TL_UICONTROL_EVENT(tt_touchUpOutside, TouchUpOutside)
TL_UICONTROL_EVENT(tt_touchCancel, TouchCancel)
TL_UICONTROL_EVENT(tt_valueChanged, ValueChanged)
TL_UICONTROL_EVENT(tt_editingDidBegin, EditingDidBegin)
TL_UICONTROL_EVENT(tt_editingChanged, EditingChanged)
TL_UICONTROL_EVENT(tt_editingDidEnd, EditingDidEnd)
TL_UICONTROL_EVENT(tt_editingDidEndOnExit, EditingDidEndOnExit)

@end
