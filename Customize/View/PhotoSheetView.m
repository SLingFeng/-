//
//  PhotoSheetView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "PhotoSheetView.h"

@interface PhotoSheetView ()
{
    PhotoMainView * _pmv;
}
@end

@implementation PhotoSheetView

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
    kWeakSelf(weakSelf);
    PhotoMainView * pmv = [[PhotoMainView alloc] initWithFrame:CGRectMake(0, kScreenH+149, kScreenW, 149)];
    [self addSubview:pmv];
    pmv.btnClick = ^(NSInteger tag) {
        if (tag == 2) {
            [weakSelf performSelector:@selector(cancelTap)];
        }else {
            if (weakSelf.click) {
                weakSelf.click(tag);
                [weakSelf performSelector:@selector(cancelTap)];
            }
        }
    };
    _pmv = pmv;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];
}


-(void)show {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _pmv);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 1;
        weakOBJ.frame = CGRectMake(0, kScreenH-149, kScreenW, 149);
    }];
}

-(void)cancelTap {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _pmv);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.frame = CGRectMake(0, kScreenH+149, kScreenW, 149);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation PhotoMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

-(void)setView {
    self.backgroundColor = [UIColor whiteColor];
    NSArray * arr = @[@"拍照", @"从相册上传", @"取消"];
    UIButton * tempBtn;
    for (int i=0; i<arr.count; i++) {
        UIButton * btn = [[UIButton alloc] init];
        btn.tag = i+30;
        [btn setTitle:arr[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[SLFCommonTools colorHex:@"999999"] forState:(UIControlStateNormal)];
        btn.titleLabel.font = [SLFCommonTools pxFont:28];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
        switch (i) {
            case 0:
                btn.sd_layout.topSpaceToView(self, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(45);
                break;
            case 1:
                btn.sd_layout.topSpaceToView(tempBtn, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(45);
                break;
            default:
            {
                btn.sd_layout.topSpaceToView(tempBtn, 10).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(49);
                        [btn setTitleColor:[SLFCommonTools colorHex:@"333333"] forState:(UIControlStateNormal)];
                btn.titleLabel.font = [SLFCommonTools pxFont:36];
            }
                break;
        }

//        [btn updateLayout];
        tempBtn = btn;
    }

}

-(void)btnClick:(UIButton *)btn {
    if (self.btnClick) {
        self.btnClick(btn.tag-30);
    }
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [SLFCommonTools drawLineToY:45 spaceForRightAndLetf:10 color:[SLFCommonTools colorHex:@"999999"] lineW:0.5];
    [SLFCommonTools drawLineToY:90 spaceForRightAndLetf:0 color:[SLFCommonTools colorHex:@"c9c9c9"] lineW:10];

}

@end


