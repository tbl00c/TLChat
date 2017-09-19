//
//  JSPatch.h
//  JSPatch SDK version 1.1
//
//  Created by bang on 15/7/28.
//  Copyright (c) 2015 bang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSPatch : NSObject

/*
 传入在平台申请的 appKey。会自动执行已下载到本地的 patch 脚本。
 建议在 -application:didFinishLaunchingWithOptions: 开头处调用
 */
+ (void)startWithAppKey:(NSString *)aAppKey;

/*
 与 JSPatch 平台后台同步，询问是否有 patch 更新，如果有更新会自动下载并执行
 */
+ (void)sync;

/*
 用于发布前测试脚本，调用后，会在当前项目的 bundle 里寻找 main.js 文件执行
 不能与 `+startWithAppKey:` 一起调用，测试完成后需要删除。
 */
+ (void)testScriptInBundle;

/*
 自定义log，使用方法：
 [JSPatch setLogger:^(NSString *msg) {
    //msg 是 JSPatch log 字符串，用你自定义的logger打出
 }];
 */
+ (void)setupLogger:(void (^)(NSString *))logger;
@end