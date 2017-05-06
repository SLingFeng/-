//
//  BaseViewController.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginCompleteBlock)(void);

@interface MyBaseViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) id obj;
/**
 页数
 */
@property (nonatomic, assign) NSInteger pageIndex;
/**
 键盘处理
 */
@property (nonatomic, strong) ZYKeyboardUtil *keyboardUtil;
/**
 设置导航条标题

 @param title text
 */
-(void)setNavigationTitle:(NSString *)title;
/**
 push到下一页面，隐藏Tabbar

 @param vc 需要的vc
 */
-(void)pushViewController:(UIViewController *)vc;


/**
 只弹出登录界面
 */
-(void)showLoginVC;
@property (nonatomic, copy) LoginCompleteBlock loginCompleteBlock;
/**
 *弹出登录界面（登录结束后有回调）
 */
-(void)showLoginVCWithLoginComplete:(LoginCompleteBlock)loginCompleteBlock;
/**
 隐藏登录页面
 */
- (void)hiddeLoginVC;
/**
 顶级导航条

 @return 导航条
 */
- (UINavigationController *)topNavigationController;
/**
 pop 回已存在的vc

 @param vcClass vc class
 */
- (void)popToViewController:(Class)vcClass;
- (void)popToViewController:(Class)vcClass obj:(id)obj;
@property (nonatomic, copy) void(^BackBlock)(id back);
@end

@interface UIViewController (MyBase)
/**
 顶级导航条
 
 @return 导航条
 */
- (UINavigationController *)topNavigationController;

-(void)setNavigationTitle:(NSString *)title;

@end
