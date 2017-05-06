//
//  PaySheetView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "PaySheetView.h"

#define psvHeight 450
@interface PaySheetView ()
{
    PaySheetInfoView * _psv;
}
@end

@implementation PaySheetView

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
    PaySheetInfoView * psv = [[PaySheetInfoView alloc] initWithFrame:CGRectMake(0, kScreenH+psvHeight, kScreenW, psvHeight)];
    [self addSubview:psv];
    psv.btnClick = ^(NSInteger tag) {
        if (weakSelf.click) {
            weakSelf.click(tag);
            [weakSelf performSelector:@selector(cancelTap)];
        }
    };
    _psv = psv;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];
}


-(void)show {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _psv);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 1;
        weakOBJ.frame = CGRectMake(0, kScreenH-psvHeight, kScreenW, psvHeight);
    }];
}

-(void)cancelTap {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _psv);
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.frame = CGRectMake(0, kScreenH+psvHeight, kScreenW, psvHeight);
    } completion:^(BOOL finished) {
        [weakOBJ removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

@end

@implementation PaySheetInfoView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

-(void)setView {
    self.backgroundColor = [UIColor whiteColor];
    NSArray * titles = @[@"支付宝支付", @"微信支付"];
    MyLabel * title = [[MyLabel alloc] init];
    title.text = @"请选择支付方式";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [SLFCommonTools pxFont:32];
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    MyLabel * tempLabel;
    for (int i=0; i<titles.count; i++) {
        MyLabel * label = [[MyLabel alloc] init];
        label.tag = i+30;
        label.textColor = [SLFCommonTools colorHex:@"333333"];
        label.font = [SLFCommonTools pxFont:32];
        label.textAlignment = NSTextAlignmentLeft;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)]];
        label.text = titles[i];
        
        [self addSubview:label];
        
        UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:titles[i]]];
        [self addSubview:iv];
        
        switch (i) {
            case 0:
            {
                label.sd_layout.topSpaceToView(self, 51).leftSpaceToView(self, 50).rightSpaceToView(self, 10).heightIs(50);
                iv.sd_layout.centerYEqualToView(label).widthIs(25).heightIs(25).leftSpaceToView(self, 10);
            }
                break;
            case 1:
            {
                label.sd_layout.topSpaceToView(tempLabel, 0).leftSpaceToView(self, 50).rightSpaceToView(self, 10).heightIs(50);
                iv.sd_layout.centerYEqualToView(label).widthIs(25).heightIs(25).leftSpaceToView(self, 10);
            }
                break;
            default:
            
                break;
        }
        tempLabel = label;
    }
}

-(void)btnClick:(UITapGestureRecognizer *)btn {
    if (self.btnClick) {
        self.btnClick(btn.view.tag-30);
    }
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [SLFCommonTools drawLineToY:50 spaceForRightAndLetf:0 color:[SLFCommonTools colorHex:@"c9c9c9"] lineW:0.5];
    [SLFCommonTools drawLineToY:101 spaceForRightAndLetf:10 color:[SLFCommonTools colorHex:@"c9c9c9"] lineW:0.5];
    [SLFCommonTools drawLineToY:151 spaceForRightAndLetf:10 color:[SLFCommonTools colorHex:@"c9c9c9"] lineW:0.5];
}

@end
