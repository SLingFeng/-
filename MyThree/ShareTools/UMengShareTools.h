//
//  ShareTools.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UMSocialUIManager.h>

@interface UMengShareTools : NSObject


/**
 * @author LingFeng, 2016-07-14 14:07:52
 *
 * 注册－分享功能
 */
+(void)registerShare;
/**
 * @author LingFeng, 2016-07-14 14:07:07
 *
 * 弹出分享视图
 * @param controller 当前视图控制器
 * @param view 需要出现的view
 * @param image 需要分享的图片 默认没有nil
 * @param title 标题
 * @param text 内容
 * @param url 网页路径/应用路径
 */
+(void)showShareActionSheetToController:(UIViewController *)controller view:(UIView *)view shareImageArray:(NSArray <UIImage *> *)image title:(NSString *)title contentText:(NSString *)text url:(NSURL *)url type:(int)type;
+(void)showShareViewToController:(UIViewController *)controller title:(NSString *)title contentText:(NSString *)text url:(NSURL *)url image:(UIImage *)image;
/**
 * @author LingFeng, 2016-07-20 16:07:37
 *
 * 微博第三方登录
 */
+(void)loginToWeiBo:(void(^)(NSString *uid))callBackData;
/**
 微博

 @param callBackData 微博用户信息
 */
+(void)userInfoForWeiBo:(void(^)(UMSocialUserInfoResponse *userInfo))callBackData;
/**
 * @author LingFeng, 2016-07-20 16:07:40
 *
 * 腾讯QQ第三方登录
 */
+(void)loginToQQ:(void(^)(NSString *openid))callBackData;
/**
 腾讯QQ
 
 @param callBackData 腾讯QQ用户信息
 */
+(void)userInfoForQQ:(void(^)(UMSocialUserInfoResponse *userInfo))callBackData;
/**
 * @author LingFeng, 2016-07-20 16:07:41
 *
 * 微信朋友圈第三方登录
 */
+(void)loginToWeiXinFriend:(void(^)(NSString *openid))callBackData;
/**
 微信
 
 @param callBackData 微信用户信息
 */
+(void)userInfoForWeiXinFriend:(void(^)(UMSocialUserInfoResponse *userInfo))callBackData;

//取消所有
+(void)cancelAllPlatform;
@end
