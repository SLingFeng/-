//
//  SLFHUD.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "SLFHUD.h"

#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;
static SLFHUD * HUD = nil;

@implementation SLFHUD

+(SLFHUD *)share {
    @synchronized(self){
        if (HUD == nil) {
            //重写 alloc
            HUD = [[super allocWithZone:NULL]init];
        }
        return HUD;
    }
}
//重写 alloc
+(id)allocWithZone:(struct _NSZone *)zone{
    return [self share];
}
//重写 copy
+(id)copyWithZone:(struct _NSZone *)zone{
    return self;
}

- (MBProgressHUD *)Hud {
    return objc_getAssociatedObject([SLFHUD share], HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD {
    objc_setAssociatedObject([SLFHUD share], HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)showHudInView:(UIView *)view hint:(NSString *)hint {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    [view addSubview:HUD];
    [HUD show:YES];
    [[SLFHUD share] setHUD:HUD];
}

+ (void)showLoadingHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    [view addSubview:HUD];
    [HUD show:YES];
    [[SLFHUD share] setHUD:HUD];
}

+ (void)showLoading {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    [HUD show:YES];
    [[SLFHUD share] setHUD:HUD];
}

+ (void)showHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
//    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

+ (void)showHint:(NSString *)hint delay:(NSTimeInterval)delay {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    //    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
}

+ (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
//    hud.yOffset = 180;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

+ (void)hideHud {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [MBProgressHUD hideAllHUDsForView:view animated:1];
    [[[SLFHUD share] Hud] hide:YES];
}

+ (void)showHint:(NSString *)hint delay:(NSTimeInterval)delay completion:(completionBlock)block {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.delegate = [SLFHUD share];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    [hud hide:YES afterDelay:delay];
    [SLFHUD share].completion = ^() {
        if (block) {
            block();
        }
    };
}

-(void)hudWasHidden:(MBProgressHUD *)hud {
    if ([SLFHUD share].completion) {
        [SLFHUD share].completion();
    }
}

@end
