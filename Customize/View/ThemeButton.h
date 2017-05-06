//
//  ThemeButton.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton
@property (nonatomic, copy) void(^click)();
-(instancetype)initWithNextBtn;
-(instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(NSString*)color fontText:(NSString*)text;
@end
