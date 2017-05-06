//
//  MyCollectionView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyCollectionView.h"

@interface MyCollectionView ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation MyCollectionView


-(void)awakeFromNib {
    [super awakeFromNib];
    [self setCollection];
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self setCollection];
    }
    return self;
}

-(void)setCollection {
    self.emptyDataSetDelegate = self;
    self.emptyDataSetSource = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerR)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    self.mj_header = header;
}

-(MJRefreshAutoNormalFooter *)footerSetup {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerR)];
    footer.automaticallyChangeAlpha = YES;
    footer.automaticallyHidden = YES;
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多的数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"沒有了" forState:MJRefreshStateNoMoreData];
    return footer;
}

-(void)headerR {
    if (self.headerRefresh) {
        self.headerRefresh();
    }
}

-(void)footerR {
    if (self.footerRefresh) {
        self.footerRefresh();
    }
}

#pragma mark - 空白页
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (self.loading) {
        NSString *text = @"沒有网络下拉重新加載";
        NSDictionary * att = @{NSFontAttributeName : [UIFont systemFontOfSize:20], NSForegroundColorAttributeName : [UIColor blackColor]};
        return [[NSMutableAttributedString alloc] initWithString:text attributes:att];
    }else {
        return nil;
    }
    
}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 0;
}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}
//source
-(BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)setLoading:(BOOL)loading{
    if (_loading != loading) {
        _loading = loading;
    }
    [self reloadEmptyDataSet];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
