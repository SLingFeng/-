//
//  MyLabel.h
//  RenCaiKu
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Font)
- (void)changeFont:(UIFont *)font;
- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(NSString*)color setText:(NSString*)title;
@end

@interface MyLabel : UILabel

@end
