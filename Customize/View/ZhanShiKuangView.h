//
//  ZhanShiKuangView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhanShiKuangView : UIView
@property (retain, nonatomic) MyLabel * titleLabel;
@property (nonatomic, copy) void(^viewTap)();

-(instancetype)initWithTitle:(NSString *)titleText detailText:(NSString *)detailText image:(NSString *)image custom:(UIView *)custom;
@end
