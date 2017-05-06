//
//  OpenOneViewController.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "OpenOneViewController.h"

@interface OpenOneViewController ()<UIScrollViewDelegate>
@property (retain, nonatomic) UIScrollView * scroll;
@property (retain, nonatomic) UIPageControl * page;
@end

@implementation OpenOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scroll = [[UIScrollView alloc] initWithFrame:kScreen];
    _scroll.delegate = self;
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(kScreenW*3, 0);
    [self.view addSubview:_scroll];
    
    self.page = [[UIPageControl alloc] init];
    _page.numberOfPages = 3;
    _page.pageIndicatorTintColor = [UIColor lightGrayColor];
    _page.currentPageIndicatorTintColor = [SLFCommonTools getBackgroundColor];
    [_page addTarget:self action:@selector(pageNumberChange:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:_page];
    
    _page.sd_layout.bottomSpaceToView(self.view, 30).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(30);
    
    NSInteger num = 3;
    for (int i=0; i<=num; i++) {
        UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW * i, 0, kScreenW, kScreenH)];
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页%d", i]];
        [_scroll addSubview:iv];
        if (i == 3) {
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [btn addTarget:self action:@selector(goNext) forControlEvents:(UIControlEventTouchUpInside)];
            btn.frame = CGRectMake(kScreenW * 2, kScreenH-140, kScreenW, 70);
            [_scroll addSubview:btn];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger pageNum = _scroll.contentOffset.x/kScreenW;
    _page.currentPage = pageNum;
}

-(void)pageNumberChange:(UIPageControl *)sender {
    NSInteger pageNum = sender.currentPage;
    [_scroll setContentOffset:CGPointMake(kScreenW*pageNum, 0) animated:YES];
}

-(void)goNext {
    [SLFCommonTools setupTabbarViewControllers:[UIApplication sharedApplication].keyWindow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
