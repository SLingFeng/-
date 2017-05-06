//
//  SLFHUD.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef void (^completionBlock)();

@interface SLFHUD : NSObject <MBProgressHUDDelegate>

@property (nonatomic, copy) completionBlock completion;

/**
 单例

 @return SLFHUD
 */
+ (SLFHUD *)share;

+ (void)showHudInView:(UIView *)view hint:(NSString *)hint;
/**
 隐藏Windows和所有hud
 */
+ (void)hideHud;

/**
 一直显示风火轮
 */
+ (void)showLoading;
/**
 一直显示风火轮

 @param hint 提示文字
 */
+ (void)showLoadingHint:(NSString *)hint;
/**
 带文字的hud 2s消失

 @param hint 文字
 */
+ (void)showHint:(NSString *)hint;
/**
 带文字的hud
 
 @param hint 文字
 @param delay 消失时间
 */
+ (void)showHint:(NSString *)hint delay:(NSTimeInterval)delay;

+ (void)showHint:(NSString *)hint yOffset:(float)yOffset;
/**
 hud隐藏后调用

 @param hint 文字
 @param delay 显示秒数
 @param block 隐藏后调用
 */
+ (void)showHint:(NSString *)hint delay:(NSTimeInterval)delay completion:(completionBlock)block;

@end
