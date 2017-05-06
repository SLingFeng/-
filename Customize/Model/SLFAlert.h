//
//  SLFAlert.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^alertClick)();
typedef void(^alertClickIndex)(NSInteger index);

@interface SLFAlert : NSObject

//@property (copy, nonatomic) void (^alertClick)();
+(SLFAlert *)shareSLFAlert;

+(void)showAlertView:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle cancel:(BOOL)cancel alertClick:(alertClick)alertClick;

+(void)showActionSheetView:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle cancel:(BOOL)cancel alertClick:(alertClick)alertClick;

/**
 展示多个选择 Sheet

 @param weakSelf vc
 @param title 标题
 @param text 副标题
 @param textArr 需要展示多个的文字
 @param alertClickIndex 选择的个数 取消是0 从上到下1，2，3，4，+
 */
+(void)showActionSheetView:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text textArr:(NSArray<NSString *> *)textArr alertClickIndex:(alertClickIndex)alertClickIndex;
//-----------上面是系统的

/**
 提示框 只有确定
 
 @param title 标题
 @param checkTitle 确定按钮 红色
 @param block 点击回调 左0 右1
 @return SLFAlert
 */
+ (instancetype)showAlertWithTitle:(NSString *)title checkTitle:(NSString *)checkTitle block:(alertClickIndex)block;

/**
 提示框

 @param title 标题
 @param leftTitle 左边按钮 标题
 @param rightTitle 右边按钮 标题
 @param block 点击回调 左0 右1
 @return SLFAlert
 */
+ (instancetype)showAlertWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle block:(alertClickIndex)block;
- (instancetype)initWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle block:(alertClickIndex)block;

@end
