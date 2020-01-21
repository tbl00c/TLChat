//
//  ZZFLEXMacros.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/11/27.
//  Copyright © 2017年 lbk. All rights reserved.
//

#ifndef ZZFLEXMacros_h
#define ZZFLEXMacros_h

#define     ZZFLEXLog(fmt, ...)     NSLog((@"【ZZFLEX】" fmt), ##__VA_ARGS__)

#define     BORDER_WIDTH_1PX        ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#endif /* ZZFLEXMacros_h */
