//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//
#import "NewFeatureController.h"
#import "YGBFirstViewController.h"
#define KCount 3
@interface NewFeatureController ()<UIScrollViewDelegate>
@property(nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic,weak) UIButton *shareBtn;

@end

@implementation NewFeatureController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    MyLocation *location = [[MyLocation alloc] init];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, kScreenW, kScreenH+20)];
    self.automaticallyAdjustsScrollViewInsets = YES;
    scrollView.delegate = self;
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    scrollView.contentSize = CGSizeMake(scrollW * KCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
   
    for (int i = 0; i < KCount; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * scrollW, 0, scrollW, scrollH)];
        NSString *imageName = [NSString stringWithFormat:@"引导页%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        
        if (i == KCount -1) {
            UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            startBtn.layer.cornerRadius = kAW(5);
            startBtn.layer.masksToBounds = YES;
            startBtn.layer.borderWidth = 1;
            startBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            startBtn.centerX = imageView.width *0.37;
//            startBtn.centerY = imageView.height * 0.79;
//            startBtn.height = KHight(55);
//            startBtn.width = [CommonTools getImageWidth:KWidth(324/2) ImageHight:KHight(165/2) otherHight:KHight(50)];
            [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:startBtn];
            [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.offset(kAW(125));
                make.height.offset(kAH(33));
                make.centerX.equalTo(imageView);
                make.bottom.offset(-kAH(31));
            }];
        }
//        else {
//            UIButton *jumptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            //        [jumptBtn setImage:[UIImage imageNamed:@"跳过"] forState:UIControlStateNormal];
//            //        [jumptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            jumptBtn.centerX = imageView.width *0.76;
//            jumptBtn.centerY = imageView.height * 0.86;
//            jumptBtn.height = KHight(30);
//            jumptBtn.width = [CommonTools getImageWidth:KWidth(204/2) ImageHight:KHight(90/2) otherHight:KHight(30)];
//            [jumptBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
//            [imageView addSubview:jumptBtn];
//        }
    }
}
//开始按钮
-(void)startClick {
    [SLFHUD showLoading];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[YGBAppConfigModel getPaht]]) {
            [RequestPost apiForGetAppConfigSuccess:^(BOOL go) {
                [SLFHUD hideHud];
                UINavigationController *navigationController = nil;
                navigationController = [[UINavigationController alloc] initWithRootViewController:[[YGBFirstViewController alloc] init]];
                [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;
            }];
    }else {
        [SLFHUD hideHud];
        UINavigationController *navigationController = nil;
        navigationController = [[UINavigationController alloc] initWithRootViewController:[[YGBFirstViewController alloc] init]];
        [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
