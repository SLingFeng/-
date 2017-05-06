//
//  ShareTools.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//


#import "UMengShareTools.h"
#import "UMengShareMainView.h"


///在友盟官网生成的AppKey传入
NSString *const AppKey = @"5806cc5f67e58e818c00072a";

///在QQ开放平台申请的ID
NSString *const QQAppID = @"1105469013";

///在QQ开放平台申请的Key
NSString *const QQAppKey = @"xriF1MKvqFwhU1qY";

///在微信开放平台申请的ID
NSString *const WXAppID = @"wx0840753cc72e054e";

///在微信开放平台申请的应用密钥
NSString *const WXAppSecretKey = @"e21b7df01d1347ed0623153825c1c616";

///在微博开放平台申请的Key
NSString *const WeiboAppKey = @"1498020263";

///在微博开放平台申请的应用密钥
NSString *const WeiboAppSecretKey = @"420faca878fc211ec78807dd0da6f1d6";

///在微博开放平台申请的回调地址
NSString *const WeiboAppRedirectURL = @"http://sns.whalecloud.com";
/**
 * @author LingFeng, 2016-07-14 09:07:40
 *
 * 腾讯QQSDK头文件
 */

/**
 * @author LingFeng, 2016-07-14 09:07:42
 *
 * 微信SDK头文件
 */

/**
 * @author LingFeng, 2016-07-14 09:07:29
 *
 * 新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
 */


@implementation UMengShareTools

+(void)registerShare {
    //打开日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:AppKey];
    
    //各平台的详细配置
    //设置微信的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecretKey redirectURL:nil];
    //设置分享到QQ互联的appId和appKey
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID  appSecret:QQAppKey redirectURL:nil];
    //设置新浪的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WeiboAppKey  appSecret:WeiboAppSecretKey redirectURL:WeiboAppRedirectURL];
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

+(void)showShareViewToController:(UIViewController *)controller title:(NSString *)title contentText:(NSString *)text url:(NSURL *)url image:(UIImage *)image {
    UMengShareMainView * smv = [[UMengShareMainView alloc] init];
//    [controller.view addSubview:smv];
    [[UIApplication sharedApplication].keyWindow addSubview:smv];
    [smv show];
    smv.formType = ^(UMSocialPlatformType type) {
        NSLog(@"%ld", type);
        UMSocialMessageObject *messageObject = [UMengShareTools creatMessageObjectTitle:title contentText:text url:nil image:nil type:0];
        //调用分享接口
        
        [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//            NSString *message = nil;
            if (!error) {
//                message = [NSString stringWithFormat:@"分享成功"];
                [MyMBProgressHUD hudForText:@"分享成功"];
            }
            else{
//                if (error) {
                    if ((int)error.code == 2010) {
                        [MyMBProgressHUD hudForText:@"分享取消"];
                    }else if ((int)error.code == 2009) {
                        [MyMBProgressHUD hudForText:@"分享取消"];
                    }else {
                        [MyMBProgressHUD hudForText:[NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code] delay:5];

//                        message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                    }
//                }
//                else{
//                    message = [NSString stringWithFormat:@"分享失败"];
//                }
            }
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
//                                                            message:message
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                  otherButtonTitles:nil];
//            [alert show];
            
        }];

    };
}

+(void)showShareActionSheetToController:(UIViewController *)controller view:(UIView *)view shareImageArray:(NSArray <UIImage *> *)image title:(NSString *)title contentText:(NSString *)text url:(NSURL *)url type:(int)type {
//    __weak __typeof(&*view) weakView = view;
//    __weak __typeof(&*controller) weakSelf = controller;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession), @(UMSocialPlatformType_QQ), @(UMSocialPlatformType_Sina)]];

    UIImage * logo = [UIImage imageNamed:@"二维码"];
//    设置分享参数
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        UMSocialMessageObject *messageObject = [UMengShareTools creatMessageObjectTitle:title contentText:text url:nil image:logo type:type];
        //调用分享接口
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            NSString *message = nil;
            if (!error) {
                message = [NSString stringWithFormat:@"分享成功"];
            }
            else{
                if (error) {
                    if ((int)error.code == 2010) {
                        message = @"分享取消";
                    }else {
                        message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                    }
                }
                else{
                    message = [NSString stringWithFormat:@"分享失败"];
                }
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }];

    }];
}

//创建分享内容对象
+ (UMSocialMessageObject *)creatMessageObjectTitle:(NSString *)title contentText:(NSString *)text url:(NSString *)urlStr image:(UIImage *)image type:(int)type
{
    if (nil == title) {
        title = @"分享";
    }
    if (nil == text) {
        text = @"鑫子龙官方网站";
    }
    if (nil == urlStr) {
        urlStr = @"http://www.zlqxm.com";//@"http://wsq.umeng.com";
    }
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    image = [UIImage imageNamed:@"icon"];
    if (title) {
        //纯文本分享
        messageObject.text = text;
    }
    switch (type) {
        case 0:
            if (urlStr) {//创建网页分享内容对象
                UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:@"http://dev.umeng.com/images/tab2_1.png"];
                [shareObject setWebpageUrl:urlStr];
                messageObject.shareObject = shareObject;
            }
            break;
        case 1:
        {
            //创建图片对象
            UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:image];
            [shareObject setShareImage:@"http://dev.umeng.com/images/tab2_1.png"];
            messageObject.shareObject = shareObject;
            
            //                //@discuss linkedin平台需要传入的图片是url，如果图片不是https的，linkedin的sdk会崩溃，需要在info.plist中加入
            //                    <key>NSAppTransportSecurity</key>
            //                    <dict>
            //                    <key>NSAllowsArbitraryLoads</key>
            //                    <true/>
            //                    </dict>
            
            //                NSString* img_url = @"http://bbs.umeng.com/data/attachment/forum/201609/14/113141r2jqq0pjlooj0753.jpg";
            //                //NSString* img_url = @"https://content.linkedin.com/content/dam/developer/global/en_US/site/img/ipad_getstarted.png";
            //                UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:img_url];
            //                [shareObject setShareImage:img_url];
            
            //                NSString* img_url = @"http://dev.umeng.com/images/tab2_1.png";//@"http://bbs.umeng.com/data/attachment/forum/201609/14/113141r2jqq0pjlooj0753.jpg";
            //                //NSString* img_url = @"https://content.linkedin.com/content/dam/developer/global/en_US/site/img/ipad_getstarted.png";
            //                UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:img_url];
            //                [shareObject setShareImage:img_url];
            //                messageObject.shareObject = shareObject;
            
        }
            break;
        case 2:
        {
            UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:text thumImage:[UIImage imageNamed:@"icon"]];
            [shareObject setVideoUrl:@"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html"];
            messageObject.shareObject = shareObject;
        }
            
            break;
        case 3:
        {
            UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:text thumImage:[UIImage imageNamed:@"icon"]];
            [shareObject setMusicUrl:@"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3"];
            messageObject.shareObject = shareObject;
        }
            
            break;
        default:
            break;
    }
    return messageObject;
}

+(void)loginToWeiBo:(void(^)(NSString *uid))callBackData {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse = result;
        if (authresponse.uid) {
            if (callBackData) {
                callBackData(authresponse.uid);
            }
        }
    }];
}

+(void)userInfoForWeiBo:(void(^)(UMSocialUserInfoResponse *userInfo))callBackData {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        if (callBackData) {
            callBackData(userinfo);
        }
    }];
}

+(void)loginToQQ:(void(^)(NSString *openid))callBackData {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:[UIApplication sharedApplication].keyWindow completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse = result;
        if (authresponse.uid) {
            if (callBackData) {
                callBackData(authresponse.uid);
            }
        }
    }];
}

+(void)userInfoForQQ:(void(^)(UMSocialUserInfoResponse *userInfo))callBackData {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:[UIApplication sharedApplication].keyWindow completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        if (callBackData) {
            callBackData(userinfo);
        }
    }];
}

+(void)loginToWeiXinFriend:(void(^)(NSString *openid))callBackData {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse = result;
        if (authresponse.uid) {
            if (callBackData) {
                callBackData(authresponse.uid);
            }
        }
        NSLog(@"%@---%@", authresponse, error);
    }];
}

+(void)userInfoForWeiXinFriend:(void(^)(UMSocialUserInfoResponse *userInfo))callBackData {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        if (callBackData) {
            callBackData(userinfo);
        }
    }];
}

+(void)cancelAllPlatform {

    
}

@end
