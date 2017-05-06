//
//  MyTimeButton.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"

@interface MyTimeButton : MyButton
/**
 禁用时间
 */
@property (assign, nonatomic) NSInteger timeNum;
/**
 * @author LingFeng, 2016-08-11 09:08:40
 *
 * 点击按钮开始倒计时方法 点击完成后有回调 btn.onClickStartTiming();
 */
@property (copy, nonatomic) void(^onClickStartTiming)();
/**
 * @author LingFeng, 2016-09-07 11:09:38
 *
 * 重置时间
 */
-(void)resetTime;
/**
 * @author LingFeng, 2016-08-11 09:08:46
 *
 * 停止时间（放在视图控制器中viewDidDisappear中\如果不是控制器放在dealloc中）
 */
-(void)stopTime;
@end
