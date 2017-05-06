//
//  BaseViewController.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyBaseViewController.h"
#import "YGBLoginViewController.h"
#import "YGBFirstViewController.h"
#import "MainViewController.h"

@interface MyBaseViewController ()

@end

@implementation MyBaseViewController

-(void)loadView {
    [super loadView];
    self.view.backgroundColor = [SLFCommonTools getBackgroundLightColor];//[UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [SLFCommonTools setupSatuts:self bai:1];
}

-(void)pushViewController:(UIViewController *)vc {
    @autoreleasepool {
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:1];
    }
}
-(void)showLoginVC {
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[[YGBLoginViewController alloc] init]];
    [self presentViewController:nav animated:1 completion:nil];
}
-(void)showLoginVCWithLoginComplete:(LoginCompleteBlock)loginCompleteBlock {
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[[YGBLoginViewController alloc] init]];
    [self presentViewController:nav animated:1 completion:nil];
    [self setLoginCompleteBlock:^() {
        if (loginCompleteBlock) {
            loginCompleteBlock();
        }
    }];
}

- (void)hiddeLoginVC {
    [self dismissViewControllerAnimated:1 completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:1];
}

-(void)setNavigationTitle:(NSString *)title {
//    self.navigationItem.title = title;
    UINavigationController * nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController * vc = nav.topViewController;
    vc.navigationItem.title = title;
}

- (UINavigationController *)topNavigationController {
   UINavigationController * nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    for (id vc in nav.viewControllers) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabVC = vc;
            return tabVC;
        }
    }
    
    UIViewController * vc = nav.topViewController;
    return (UINavigationController *)nav.topViewController;
}

- (void)popToViewController:(Class)vcClass {
    [self popToViewController:vcClass obj:nil];
}

- (void)popToViewController:(Class)vcClass obj:(id)obj {
    kWeakSelf(weakSelf);
    UINavigationController * nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    YGBFirstViewController * fvc = (YGBFirstViewController *)nav.topViewController;
    NSLog(@"%@",fvc.navigationController.viewControllers);
    for (MyBaseViewController * vc in fvc.navigationController.viewControllers) {
        if ([vc isKindOfClass:vcClass]) {
            if (self.BackBlock) {
                weakSelf.BackBlock(obj);
            }
            [fvc.navigationController popToViewController:vc animated:1];
            return;
        }
    }
}

-(void)dealloc {
    NSLog(@"---------------\n\rdealloc:%@\n\r-----------------", NSStringFromClass([self class]));
}

@end

@implementation UIViewController (MyBase)

- (UINavigationController *)topNavigationController {
    UINavigationController * nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    return nav;
}

-(void)setNavigationTitle:(NSString *)title {
    //    self.navigationItem.title = title;
    UINavigationController * nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController * vc = nav.topViewController;
    vc.navigationItem.title = title;
}

@end
