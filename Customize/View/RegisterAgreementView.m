//
//  RegisterAgreementView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "RegisterAgreementView.h"

@implementation RegisterAgreementView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)createLoginView {
    self.backgroundColor = [UIColor redColor];
    UIImageView * tou = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    tou.image = [UIImage imageNamed:@"账号"];
    [self addSubview:tou];
    
    UIImageView * passImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 41, 40, 40)];
    passImageView.image = [UIImage imageNamed:@"密码"];
    [self addSubview:passImageView];
}

-(void)createUserAgreement {
    self.gouBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [_gouBtn setBackgroundImage:[UIImage imageNamed:@"未打钩"] forState:(UIControlStateNormal)];
    [_gouBtn setBackgroundImage:[UIImage imageNamed:@"打钩"] forState:(UIControlStateSelected)];
    [_gouBtn addTarget:self action:@selector(gouClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_gouBtn];
    
    MyLabel * label = [[MyLabel alloc] initWithFrame:CGRectMake(25, 0, 200, 30)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15.f];
    label.text = @"我已閱讀並同意人才庫";
    label.textColor = [SLFCommonTools getTextLightColor];
    [self addSubview:label];
    
    UIButton * agreementBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 140, 30)];
    [agreementBtn setTitle:@"《用戶使用協議》" forState:(UIControlStateNormal)];
    agreementBtn.titleLabel.font = [UIFont systemFontOfSize:15.F];
    [agreementBtn setTitleColor:[SLFCommonTools getTextLightColor] forState:(UIControlStateNormal)];
    [self addSubview:agreementBtn];
    
}

-(void)gouClick:(UIButton *)button {
    button.selected = !button.selected;
}

@end
