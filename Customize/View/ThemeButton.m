//
//  ThemeButton.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "ThemeButton.h"

@implementation ThemeButton


-(instancetype)init {
    if (self = [super init]) {
        [self setBtn];
    }
    return self;
}
- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(NSString*)color fontText:(NSString*)text {
    if (self = [super init]) {
        [self setTitleColor:[SLFCommonTools colorHex:color] forState:(UIControlStateNormal)];
        self.titleLabel.font = [UIFont systemFontOfSize:kAH(fontSize)];
        [self setTitle:text forState:UIControlStateNormal];
        [self addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

-(void)btnClick:(UIButton *)btn {
    if (self.click) {
        self.click();
    }
}

-(void)setBtn {
    self.layer.cornerRadius = 12.5f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = RGBCOLOR(44, 157, 247).CGColor;
    self.layer.borderWidth = 0.5;
    self.backgroundColor = [SLFCommonTools colorHex:@"e9f5fe"];
    [self setTitleColor:RGBCOLOR(44, 157, 247) forState:(UIControlStateNormal)];
    self.titleLabel.font = [SLFCommonTools pxFont:28];
}

-(instancetype)initWithNextBtn {
    if (self = [super init]) {
        [self setBtn1];
    }
    return self;
}

-(void)setBtn1 {
    self.layer.cornerRadius = 25.f;
    self.layer.masksToBounds = YES;
    [self setBackgroundColor:[SLFCommonTools getNavBarColor]];
    self.titleLabel.font = [SLFCommonTools pxFont:32];
    [self setTitleColor:RGBCOLOR(254, 254, 254) forState:(UIControlStateNormal)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
