//
//  JSPatch.h
//  JSPatch Platform SDK version 1.6.6
//
//  Created by bang on 15/7/28.
//  Copyright (c) 2015 bang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JPCallbackType){
    JPCallbackTypeUnknow        = 0,
    JPCallbackTypeRunScript     = 1,    //执行脚本
    JPCallbackTypeUpdate        = 2,    //脚本有更新
    JPCallbackTypeUpdateDone    = 3,    //已拉取新脚本
    JPCallbackTypeCondition     = 4,    //条件下发
    JPCallbackTypeGray          = 5,    //灰度下发
    JPCallbackTypeUpdateFail    = 6,    //脚本拉取错误
    JPCallbackTypeException     = 7,    //配置错误
    JPCallbackTypeJSException   = 8,    //js脚本执行出错
};

typedef NS_ENUM(NSInteger, JPErrorCode) {
    JPErrorUntar = 5001,
    JPErrorUntarScript,
    JPErrorMD5NotMatch,
    JPErrorScriptFileMissing,
    JPErrorKeyFileMissing,
    JPErrorDecryptMd5,
    JPErrorNetworkError,
};

@interface JSPatch : NSObject

#pragma mark - 主要API

/*
 传入在平台申请的 appKey。会自动执行已下载到本地的 patch 脚本。
 建议在 -application:didFinishLaunchingWithOptions: 开头处调用
 */
+ (void)startWithAppKey:(NSString *)aAppKey;

/*
 与 JSPatch 平台后台同步，发请求询问后台是否有 patch 更新，如果有更新会自动下载并执行
 可调用多次（App启动时调用或App唤醒时调）
 */
+ (void)sync;

/*
 用于发布前测试脚本。先把脚本放入项目中，调用后，会在当前项目的 bundle 里寻找 main.js 文件执行
 可以使用 `+setupTestScriptFileName` 接口修改测试的文件名
 测试完成后请删除，改为调用 +startWithAppKey: 和 +sync
 */
+ (void)testScriptInBundle;


#pragma mark - 设置

/*
 自定义log，使用方法：
 [JSPatch setLogger:^(NSString *msg) {
    //msg 是 JSPatch log 字符串，用你自定义的logger打出
 }];
 在 `+startWithAppKey:` 之前调用
 */
+ (void)setupLogger:(void (^)(NSString *))logger;

/*
 定义用户属性
 用于条件下发，例如: 
    [JSPatch setupUserData:@{@"userId": @"100867", @"location": @"guangdong"}];
 详见在线文档
 在 `+sync:` 之前调用
 */
+ (void)setupUserData:(NSDictionary *)userData;


/*
 事件回调
   type: 事件类型，详见 JPCallbackType 定义
   data: 回调数据
   error: 事件错误, 
        domain: @"jspatch.com",
        error.code: JPErrorCode,
        userInfo: @{@"message": msg,
                    @"additionalError": error,
                    @"retryTimes": retryTimes
                   }
 在 `+startWithAppKey:` 之前调用
 */
+ (void)setupCallback:(void (^)(JPCallbackType type, NSDictionary *data, NSError *error))callback;

/*
 自定义RSA key
 publicKey: 平台上传脚本时 privateKey 对应的 publicKey
 在 `+sync:` 之前调用，详见 JSPatch 平台文档
 */
+ (void)setupRSAPublicKey:(NSString *)publicKey;


/*
 进入开发模式
 平台下发补丁时选择开发预览模式，会只对调用了这个方法的客户端生效。
 在 `+sync:` 之前调用，建议在 #ifdef DEBUG 里调。
 */
+ (void)setupDevelopment;


/*
 使用http请求
 SDK所有请求默认使用 https，若有特殊需求可以通过这个接口降为 http
 在 `+sync:` 之前调用。
 */
+ (void)setupHttp;


/*
 设置测试脚本文件名
 与 `+testScriptInBundle` 配合，默认测试脚本名为 main.js，可以通过这个接口修改
 在 `+testScriptInBundle` 之前调用。
 */
+ (void)setupTestScriptFileName:(NSString *)fileName;


#pragma mark - Debug

/*
 在状态栏显示调试按钮，点击可以看到所有 JSPatch 相关的 log 和内容
 */
+ (void)showDebugView;

/*
 直接弹起 DebugViewController 显示所有 JSPatch 相关的 log 和内容
 */
+ (void)presentDebugViewController;


#pragma mark - 在线参数
/*
 请求在线参数
 默认30分钟内多次调用只请求一次，若要实时性更强，请使用 +updateConfigWithAppKey:withInterval: 接口
 */
+ (void)updateConfigWithAppKey:(NSString *)appKey;

/*
 请求在线参数
 @param interval 在线参数请求间隔，单位秒，例如 60*10 表示10分钟内多次调用只发起一次请求
 */
+ (void)updateConfigWithAppKey:(NSString *)appKey withInterval:(CGFloat)interval;

/*
 获取已缓存在本地的所有在线参数
 */
+ (NSDictionary *)getConfigParams;

/*
 根据键值获取已缓存在本地的一个在线参数
 */
+ (NSString *)getConfigParam:(NSString *)key;

/*
 设置在线参数请求完成的回调
 */
+ (void)setupUpdatedConfigCallback:(void (^)(NSDictionary *configs, NSError *error))cb;
@end
