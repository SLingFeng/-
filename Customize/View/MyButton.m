//
//  MyButton.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton {
    UIColor *_diseColor;
}

-(instancetype)init {
    if (self = [super init]) {
        [self setupButton];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupButton];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupButton];
    }
    return self;
}

+(instancetype)buttonWithType:(UIButtonType)buttonType {
    MyButton * btn = [super buttonWithType:buttonType];
    [btn setupButton];
    return btn;
}

-(void)setupButton {
    
//    [self setTitleColor:RGBCOLOR(51, 51, 51) forState:(UIControlStateNormal)];
//    //    圆角
//    self.layer.cornerRadius = 3;
//    [self setBackgroundColor:[SLFCommonTools getBackgroundColor]];
//    self.status = MyStatusEnabled;
    [self addTarget:self action:@selector(onClic:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)onClic:(MyButton *)sender {
    if (self.onClickBlock) {
        self.onClickBlock(sender);
    }
}

- (void)setStatus:(MyStatus)status {
    _status = status;
    if (status == MyStatusEnabled) {
//        self.enabled = 1;
        [self setBackgroundColor:kFF7E00];
    }else if (status == MyStatusFailure) {
//        self.enabled = 0;
        [self setBackgroundColor:k999999];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
