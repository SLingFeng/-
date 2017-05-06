//
//  MyTableView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyTableView.h"

@interface MyTableView ()<DZNEmptyDataSetDelegate, DZNEmptyDataSetSource> {
    NSDictionary *_attributes;
}

@end

@implementation MyTableView

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setMyTableView];
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setMyTableView];
    }
    return self;
}

-(void)setMyTableView {
    self.emptyDataSetDelegate = self;
    self.emptyDataSetSource = self;
    self.tableFooterView = [[UIView alloc] init];
    //状态颜色字体
    _attributes = @{NSFontAttributeName : [SLFCommonTools pxFont:34], NSForegroundColorAttributeName : [SLFCommonTools colorHex:@"333333"]};

    
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerR)];
//    footer.automaticallyChangeAlpha = YES;
//    footer.automaticallyHidden = YES;
//    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
//    [footer setTitle:@"正在加载更多的数据" forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"沒有了" forState:MJRefreshStateNoMoreData];
//    self.mj_footer = footer;
}

-(MJRefreshNormalHeader *)headerSetup {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerR)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    self.mj_header = header;
    return header;
}

-(MJRefreshAutoNormalFooter *)footerSetup {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerR)];
    footer.automaticallyChangeAlpha = YES;
    footer.automaticallyHidden = YES;
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多的数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
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
//标题
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {

    NSString *text;

    switch (self.tState) {
        case MyTableViewStateNormal:
            return nil;
            break;
        case MyTableViewStateNoData: {
            text = @"暂无数据";
        }
            break;
        case MyTableViewStateFailedLoad: {
            text = @"加载失败";
        }
            break;
        case MyTableViewStateError: {
            text = @"加载出错";
        }
            break;
        case MyTableViewStateUnknownError: {
            text = @"未知错误";
        }
            break;
        case MyTableViewStateCustomize: {
            text = _loadTitle;
        }
            break;
            
        default:
            return nil;
            break;
    }
    if (kStringIsEmpty(text)) {
        return nil;
    }
    return [[NSMutableAttributedString alloc] initWithString:text attributes:_attributes];
}
//正文内容
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = nil;
    
    switch (self.tState) {
        case MyTableViewStateNormal:
            return nil;
            break;
        case MyTableViewStateNoData: {
//            text = @"暂无数据";
        }
            break;
        case MyTableViewStateFailedLoad: {
//            text = @"加载失败";
        }
            break;
        case MyTableViewStateError: {
//            text = @"加载出错";
        }
            break;
        case MyTableViewStateUnknownError: {
            text = @"未知错误";
        }
            break;
        case MyTableViewStateCustomize: {
            if (!kStringIsEmpty(_loadDescription)) {
                text = _loadDescription;
            }
            return nil;
        }
            break;
            
        default:
            return nil;
            break;
    }
    if (kStringIsEmpty(text)) {
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:text attributes:_attributes];

}
//按钮
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = nil;
    switch (self.tState) {
        case MyTableViewStateNormal:
            return nil;
            break;
        case MyTableViewStateNoData: {
            text = @"点击刷新";
        }
            break;
        case MyTableViewStateFailedLoad: {
            text = @"点击刷新";
        }
            break;
        case MyTableViewStateError: {
            text = @"点击刷新";
        }
            break;
        case MyTableViewStateUnknownError: {
            text = @"点击刷新";
        }
            break;
        case MyTableViewStateCustomize: {
            if (kStringIsEmpty(_loadButtonTitle)) {
//                text = @"点击刷新";
            }else {
                text = _loadButtonTitle;
            }
        }
            break;
            
        default:
            return nil;
            break;
    }
    if (kStringIsEmpty(text)) {
        return nil;
    }
    NSDictionary * attributes = @{NSFontAttributeName : [SLFCommonTools pxFont:32], NSForegroundColorAttributeName : k666666};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}


- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -150;
}
//-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
//    return -300;
//}


//source
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.stateOnClickBlock) {
        self.stateOnClickBlock();
    }
}
-(BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)setTState:(MyTableViewState)tState {
    _tState = tState;
    [self reloadEmptyDataSet];
    [self reloadData];
}
//- (void)setLoading:(BOOL)loading{
//    if (_loading != loading) {
//        _loading = loading;
//    }
//    [self reloadEmptyDataSet];
//}



@end
