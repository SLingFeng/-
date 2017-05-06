//
//  LabelView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//
#import <UIKit/UIKit.h>

/**
 出来的样式
 工种：水电工
 */
@interface LabelView : UIView

/**
 主label
 */
@property (nonatomic, retain) MyLabel *firstLabel;
/**
 副label
 */
@property (nonatomic, retain) MyLabel *secondLabel;

-(void)setFirstText:(NSString *)firstText secondText:(NSString *)secondText;

-(void)setFirstText:(NSString *)firstText firstColor:(UIColor *)fc secondText:(NSString *)secondText secondColor:(UIColor *)sc;
@end
