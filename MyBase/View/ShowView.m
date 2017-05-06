//
//  ShowView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "ShowView.h"

@implementation ShowView
-(instancetype)init {
    if (self = [super init]) {
        [self setView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

-(void)setView {
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    self.alpha = 0;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];
}


-(void)show {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _bottomView);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 1;
        weakOBJ.frame = CGRectMake(0, kScreenH-_bottomHeight, kScreenW, _bottomHeight);
    }];
}

-(void)cancelTap {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _bottomView);
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.frame = CGRectMake(0, kScreenH+_bottomHeight, kScreenW, _bottomHeight);
    } completion:^(BOOL finished) {
        [weakOBJ removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}
@end
