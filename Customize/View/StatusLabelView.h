//
//  StatusLabelView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface StatusLabelView : UIView
@property (nonatomic, retain) MyLabel * title;
@property (nonatomic, copy) NSString * contentText;
@property (nonatomic, assign) BOOL status;
-(instancetype)initWithTitle:(NSString *)title status:(BOOL)status;
/**
 设置内容

 @param text 内容
 */
-(void)setContentText:(NSString *)text;
@end

@interface ImageLableView : UIView
@property (nonatomic, retain) MyLabel * title;
@property (nonatomic, copy) NSString * contentText;
-(instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;
@end

