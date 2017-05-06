//
//  UILabel+AlertActionFont.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "UILabel+AlertActionFont.h"

@implementation UILabel (AlertActionFont)

- (void)setAppearanceFont:(UIFont *)appearanceFont
{
    if(appearanceFont)
    {
        [self setFont:appearanceFont];
    }
}

- (UIFont *)appearanceFont
{
    return self.font;
}

@end
