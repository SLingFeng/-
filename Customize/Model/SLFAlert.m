//
//  SLFAlert.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "SLFAlert.h"
#import "UILabel+AlertActionFont.h"

@interface SLFAlert ()
{
    UIView *_backgroundView;
    UIView *_alertView;
}
@end

@implementation SLFAlert

static SLFAlert * instance = nil;
+(SLFAlert *)shareSLFAlert
{
    if (!instance) {
        instance = [[SLFAlert alloc]init];
    }
    return instance;
}
+(SLFAlert *)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

//+(UIAlertAction *)defaultAction {
//    UIAlertAction * action
//    
//    return action;
//}

+(void)showAlertView:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle cancel:(BOOL)cancel alertClick:(alertClick)alertClick {
    if (weakSelf == nil) {
        weakSelf = [SLFCommonTools currentViewController];
    }
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:(UIAlertControllerStyleAlert)];
    
    
    if (cancel) {
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [cancelAction setValue:k666666 forKey:@"_titleTextColor"];

        [alertController addAction:cancelAction];
    }
    
    UIAlertAction * queRen = [UIAlertAction actionWithTitle:determine style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        if (alertClick) {
            alertClick();
        }
    }];
//    [queRen setValue:k666666 forKey:@"_titleTextColor"];
    [alertController addAction:queRen];
    
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    UIFont *font = [SLFCommonTools pxFont:32];
    [appearanceLabel setAppearanceFont:font];

    [SLFAlert setupTextFont:title text:text ac:alertController];

    [weakSelf presentViewController:alertController animated:YES completion:nil];
}

+(void)showActionSheetView:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle cancel:(BOOL)cancel alertClick:(alertClick)alertClick {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:(UIAlertControllerStyleActionSheet)];
    if (cancel) {
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
    }
    UIAlertAction * queRen = [UIAlertAction actionWithTitle:determine style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        //        if ([CommonTools shareTools].alertClick) {
        //            [CommonTools shareTools].alertClick();
        //        }
        if (alertClick) {
            alertClick();
        }
    }];
    [queRen setValue:k666666 forKey:@"_titleTextColor"];
    [alertController addAction:queRen];
    
    [SLFAlert setupTextFont:title text:text ac:alertController];
//    UILabel *appearanceLabel;
//    if (IS_IOS9) {
//        appearanceLabel = [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]];
//    }else {
//        appearanceLabel = [UILabel my_appearanceWhenContainedIn:@[UIAlertController.class]];
//    }
//    appearanceLabel.appearanceFont = [CommonTools pxFont:26];
//     修改字体大小
//    appearanceLabel = [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]];
//    [appearanceLabel changeFont:[CommonTools pxFont:26]];
    
    [weakSelf presentViewController:alertController animated:YES completion:nil];
}

+(void)setupTextFont:(NSString *)title text:(NSString *)text ac:(UIAlertController *)alertController {
    NSDictionary * style = @{@"font" : [SLFCommonTools pxFont:28],
                             @"font2" : [SLFCommonTools pxFont:20],
                             @"color" : k666666,
                             @"color2" : k999999};
    //title
    if (nil != title) {
        NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertTitleStr addAttribute:NSFontAttributeName value:[SLFCommonTools pxFont:32] range:NSMakeRange(0, title.length)];
        [alertTitleStr addAttribute:NSForegroundColorAttributeName value:k111111 range:NSMakeRange(0, title.length)];
        [alertController setValue:alertTitleStr forKey:@"attributedTitle"];
    }
    
    //message
    if (nil != text) {
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:text];
        [alertMessageStr addAttribute:NSFontAttributeName value:[SLFCommonTools pxFont:32] range:NSMakeRange(0, text.length)];
        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:k666666 range:NSMakeRange(0, title.length)];
        [alertController setValue:alertMessageStr forKey:@"attributedMessage"];
    }
}

+(void)showActionSheetView:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text textArr:(NSArray<NSString *> *)textArr alertClickIndex:(alertClickIndex)alertClickIndex {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:(UIAlertControllerStyleActionSheet)];
    for (int i=0; i<textArr.count; i++) {
        NSString * str = textArr[i];
        [alertController addAction:[UIAlertAction actionWithTitle:str style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (alertClickIndex) {
                alertClickIndex(i+1);
            }
        }]];
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (alertClickIndex) {
            alertClickIndex(0);
        }
    }]];

    [weakSelf presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 自定义alert

+ (instancetype)showAlertWithTitle:(NSString *)title checkTitle:(NSString *)checkTitle block:(alertClickIndex)block {
    return [[SLFAlert alloc] initWithTitle:title leftTitle:nil rightTitle:checkTitle block:block];
}

+ (instancetype)showAlertWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle block:(alertClickIndex)block {
    return [[SLFAlert alloc] initWithTitle:title leftTitle:leftTitle rightTitle:rightTitle block:block];
}

- (instancetype)initWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle block:(alertClickIndex)block {
    if (self = [super init]) {
        
        _backgroundView = [[UIView alloc] initWithFrame:kScreen];
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
        
        UIView * b = [[UIView alloc] initWithFrame:kScreen];
        b.backgroundColor = [SLFCommonTools colorHex:@"000000" alpha:0.6];
        [_backgroundView addSubview:b];
        
        _alertView = [[UIView alloc] init];
        [_backgroundView addSubview:_alertView];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = 1;
        _alertView.layer.cornerRadius = kMainCornerRadius;

        kWeakObj(weakAlert, _alertView);
        kWeakSelf(weakSelf);
        
        MyLabel * titleLabel = [[MyLabel alloc] initWithFontSize:(32/2) fontColor:@"111111" setText:title];
        titleLabel.font = [SLFCommonTools pxFont:32];
        [_alertView addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        MyButton * rightBtn = [MyButton buttonWithType:(UIButtonTypeSystem)];
        [_alertView addSubview:rightBtn];
        [rightBtn setTitle:rightTitle forState:(UIControlStateNormal)];
        [rightBtn setTitleColor:kFF0000 forState:(UIControlStateNormal)];
        rightBtn.titleLabel.font = [SLFCommonTools pxFont:32];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(24);
            make.left.and.right.offset(0);
            make.centerX.equalTo(weakAlert);
        }];
        
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(132, 46));
            make.right.and.bottom.offset(0);
        }];
        
        if (leftTitle != nil) {
            MyButton * leftBtn = [MyButton buttonWithType:(UIButtonTypeSystem)];
            [_alertView addSubview:leftBtn];
            [leftBtn setTitle:leftTitle forState:(UIControlStateNormal)];
            [leftBtn setTitleColor:k666666 forState:(UIControlStateNormal)];
            leftBtn.titleLabel.font = [SLFCommonTools pxFont:32];
            
            [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(132, 46));
                make.left.and.bottom.offset(0);
            }];
            

            
            [leftBtn setOnClickBlock:^(MyButton *sender) {
                [weakSelf cancelTap];
                if (block) {
                    block(0);
                }
            }];
            [SLFCommonTools lineDash:_alertView hight:50 x:132 y:70 color:@"bfbfbf" lineW:0.5];
        }else {
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(46);
                make.left.and.right.and.bottom.offset(0);
            }];
        }
        
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_backgroundView);
            make.width.mas_equalTo(264);
            make.height.mas_equalTo(120);
            make.top.equalTo(titleLabel.mas_top);
            make.bottom.equalTo(rightBtn.mas_bottom);
        }];

        
        [_alertView setupAutoHeightWithBottomView:rightBtn bottomMargin:0];
        
        [SLFCommonTools line:_alertView y:70 leftSpace:0 rightSpace:264 color:@"bfbfbf" lineW:0.5];
        
        
        
        [rightBtn setOnClickBlock:^(MyButton *sender) {
            [weakSelf cancelTap];
            if (block) {
                block(1);
            }
        }];
        
//        [self show];
    }
    return self;
}


-(void)show {
    kWeakObj(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 animations:^{
        weakOBJ.alpha = 1;
    }];
}

-(void)cancelTap {
    kWeakObj(weakOBJ, _backgroundView);
//    [UIView animateWithDuration:0.35 animations:^{
//        weakOBJ.alpha = 0;
//    } completion:^(BOOL finished) {
        [weakOBJ removeFromSuperview];
//    }];
}


@end
