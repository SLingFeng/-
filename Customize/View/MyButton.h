//
//  MyButton.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    MyStatusFailure,
    MyStatusSuccess,
    MyStatusEnabled,
} MyStatus;

@interface MyButton : UIButton
/**
 * @author LingFeng, 2016-06-21 09:06:46
 *
 * 默认失败 MyStatusFailure
 */
@property (nonatomic) MyStatus status;

/**
 点击事件TouchUpInside 回调
 */
@property (nonatomic, copy) void(^onClickBlock)(MyButton *sender);
@end
