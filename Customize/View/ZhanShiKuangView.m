//
//  ZhanShiKuangView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "ZhanShiKuangView.h"

@implementation ZhanShiKuangView

-(instancetype)initWithTitle:(NSString *)titleText detailText:(NSString *)detailText image:(NSString *)image custom:(UIView *)custom {
    if (self = [super init]) {
        [self createToTitle:titleText detailText:detailText image:image custom:custom];
    }
    return self;
}

-(void)createToTitle:(NSString *)titleText detailText:(NSString *)detailText image:(NSString *)image custom:(UIView *)custom {
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = 1;
    self.backgroundColor = [UIColor whiteColor];
    
    kWeakSelf(weakSelf);
    UIImageView * imageView = nil;
    if (image != nil) {
        imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:image];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.size.mas_equalTo(@24);
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
        }];
    }
    
    MyLabel * title = nil;
    if (titleText != nil || ![titleText isEqualToString:@""]) {
        title = [[MyLabel alloc] init];
        title.text = titleText;
        title.font = [SLFCommonTools pxFont:28];
        [self addSubview:title];
        self.titleLabel = title;
        CGSize size =[titleText sizeWithAttributes:@{NSFontAttributeName:title.font}];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            if (image != nil) {
                make.left.equalTo(imageView.mas_right).with.offset(5);
            }else {
                make.left.offset(10);
            }
            make.centerY.equalTo(weakSelf);
            if (detailText != nil) {
                make.size.mas_equalTo(CGSizeMake(size.width+2, size.height));
            }else {
                make.size.mas_equalTo(CGSizeMake(size.width+1, size.height));
            }
        }];
    }else {
        
    }
    MyLabel * detailLabel = nil;
    if (![SLFCommonTools kongGe:detailText]) {
        detailLabel = [[MyLabel alloc] init];
        detailLabel.text = detailText;
        [self addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.offset(-15);
        }];
    }
    
    if (custom != nil) {
        [self addSubview:custom];
        [custom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.width.mas_equalTo(51);
            make.height.mas_equalTo(31);
        }];
    }
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapClick:)]];
}

-(void)viewTapClick:(UITapGestureRecognizer *)sender {
    if (self.viewTap) {
        self.viewTap();
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
