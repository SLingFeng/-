//
//  UMengShareMainView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "UMengShareMainView.h"

@interface UMengShareMainView ()
{
    MainView * _mainView;
}
@end

@implementation UMengShareMainView

-(instancetype)init {
    if (self == [super init]) {
        self.frame = kScreen;
        
        UIView * backgroudView = [[UIView alloc] initWithFrame:kScreen];
        backgroudView.backgroundColor = kCOLOR_WITH_RGBA(100, 100, 100, 0.25);
        [self addSubview:backgroudView];
        [backgroudView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];

        MainView * mainView = [[MainView alloc] initWithFrame:CGRectMake(0, kScreenH+AdaptiveHeight(160), kScreenW, AdaptiveHeight(160))];
        [self addSubview:mainView];
        kWEAKSELF(weakSelf);
        mainView.cancelClick = ^() {
            [weakSelf cancelTap];
        };
        mainView.sendType = ^(UMSocialPlatformType type) {
            if (weakSelf.formType) {
                [weakSelf cancelTap];
                weakSelf.formType(type);
            }
        };
//        mainView.sd_layout.bottomSpaceToView(self, -AdaptiveHeight(160)).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(AdaptiveHeight(160));
        _mainView = mainView;
        self.alpha = 0;
    }
    return self;
}

-(void)show {
    kWEAKSELF(weakSelf);
    kWEAKOBJ(weakOBJ, _mainView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 1;
        weakOBJ.frame = CGRectMake(0, kScreenH-AdaptiveHeight(160), kScreenW, AdaptiveHeight(160));
    }];
}

-(void)cancelTap {
    kWEAKSELF(weakSelf);
    kWEAKOBJ(weakOBJ, _mainView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.frame = CGRectMake(0, kScreenH+AdaptiveHeight(160), kScreenW, AdaptiveHeight(160));
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

-(void)dealloc {
    _mainView = nil;
    NSLog(@"%s", __func__);
}

@end

#pragma mark - 主视图
@implementation MainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray * type = @[@(UMSocialPlatformType_WechatSession),
                           @(UMSocialPlatformType_WechatTimeLine),
                           @(UMSocialPlatformType_Sina)];
        NSArray * titles = @[@"微信", @"朋友圈", @"微博"];
        NSArray * images = @[@"微信分享", @"朋友圈分享", @"微博分享"];
        for (int i=0; i<3; i++) {
            float x = JGG_X(AdaptiveWidth(47.5), AdaptiveWidth(60), (kScreenW-(AdaptiveWidth(60)*3)-AdaptiveWidth(47.5)*2)/2, i, 3);
            float y = JGG_Y(AdaptiveHeight(15), AdaptiveHeight(90), 20, i, 3);
            ShareIconView * siv = [[ShareIconView alloc] initWithFrame:CGRectMake(x, y, AdaptiveWidth(60), AdaptiveHeight(90)) title:titles[i] image:images[i]];
            NSNumber * num = type[i];
            siv.type = [num integerValue];
            [self addSubview:siv];
            kWEAKSELF(weakSelf);
            siv.typeTap = ^(UMSocialPlatformType type) {
                if (weakSelf.sendType) {
                    weakSelf.sendType(type);
                }
            };
        }
        
        UIButton * cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:cancelBtn];
        cancelBtn.sd_layout.topSpaceToView(self, AdaptiveHeight(115)).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    }
    return self;
}

-(void)cancelBtnClick {
    NSLog(@"cancel");
    if (self.cancelClick) {
        self.cancelClick();
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [CommonTools drawLineToHight:AdaptiveHeight(115) spaceForRightAndLetf:AdaptiveWidth(10)];
}

@end

@implementation ShareIconView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image {
    if (self == [super initWithFrame:frame]) {
        UIImageView * iconImageView = [[UIImageView alloc] init];
        [self addSubview:iconImageView];
//        iconImageView.backgroundColor = kColorRandomly;
        [iconImageView setImage:[UIImage imageNamed:image]];
        
        UILabel * titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        
        iconImageView.sd_layout.topSpaceToView(self, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(AdaptiveHeight(60));

        titleLabel.sd_layout.topSpaceToView(iconImageView, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
//        self.frame = CGRectMake(0, 0, AdaptiveWidth(60), AdaptiveHeight(70));
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTypeTap)]];
    }
    return self;
}

-(void)shareTypeTap {
    if (self.typeTap) {
        self.typeTap(self.type);
    }
}

@end
