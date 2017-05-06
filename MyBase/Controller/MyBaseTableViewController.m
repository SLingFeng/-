//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyBaseTableViewController.h"

@interface MyBaseTableViewController ()
{
    // 搜索结果界面
    UIViewController<UISearchResultsUpdating, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource> *_searchResultViewController;

}

@end

@implementation MyBaseTableViewController

-(void)loadView {
    [super loadView];
//    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [SLFCommonTools getBackgroundColor];
}

-(void)neededTableViewStyle:(UITableViewStyle)style {
    self.tableView = [[MyTableView alloc] initWithFrame:CGRectZero style:(style)];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(10, 0, 0, 0));
    _tableView.backgroundColor = [SLFCommonTools getBackgroundColor];
    _tableView.tState = MyTableViewStateNormal;
    self.contents = [NSMutableDictionary dictionaryWithCapacity:1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView * line;
    if ([cell viewWithTag:999] != nil) {
        line = [cell viewWithTag:999];
    }
    UIRectCorner rc = -1;
    if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1){//只有一个
        line.hidden = 1;
        rc = UIRectCornerAllCorners;
    }else if (indexPath.row == 0) {//最顶端的Cell（两个向下圆弧和一条线）
        line.hidden = 0;
        rc = UIRectCornerTopLeft | UIRectCornerTopRight;
    }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {//最底端的Cell（两个向上的圆弧和一条线）
        line.hidden = 1;
        rc = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }else {//中间的Cell
        line.hidden = 0;
        return;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.contentView.bounds byRoundingCorners:rc cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cell.contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    cell.layer.mask = maskLayer;
}
*/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:1];
}

#pragma mark - search 
-(void)neededSearch {
    self.automaticallyAdjustsScrollViewInsets = 0;
//    _searchResultViewController = [
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
//    _searchController.hidesNavigationBarDuringPresentation = NO;
    // 必须要让searchBar自适应才会显示
//    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.delegate = self;
    [_searchController.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//    _searchController.searchBar.backgroundImage = [UIImage imageWithColor:[SLFCommonTools getBackgroundColor]];
//    _searchController.searchBar.frame = CGRectMake(12, 0, kContentViewWidth, 44);
    //把searchBar 作为 tableView的头视图
    self.tableView.tableHeaderView = _searchController.searchBar;
    self.definesPresentationContext = YES;

}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
//    [self unpinHeaderView];
//    [searchController.searchResultsController layoutSubviewsFrame];
    
}
- (void)didPresentSearchController:(UISearchController *)searchController {
    
}
- (void)willDismissSearchController:(UISearchController *)searchController {
//    [searchController.searchResultsController layoutSubviewsFrame];
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    
}
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//    [self.searchDisplayController setActive:YES animated:YES];
    [searchBar setShowsCancelButton:YES animated:YES];   //  动画显示取消按钮
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:NO];    // 取消按钮回收
    [searchBar resignFirstResponder];                                // 取消第一响应值,键盘回收,搜索结束
}

#pragma mark - 设置内容
-(void)setupContents:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    NSString * key = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.section, (long)indexPath.row];
    [_contents setObject:text forKey:key];
}

-(void)removeContents:(NSIndexPath *)indexPath {
    NSString * key = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.section, (long)indexPath.row];
    [_contents removeObjectForKey:key];
}

-(NSString *)getContents:(NSIndexPath *)indexPath {
    NSString * key = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.section, (long)indexPath.row];
    return [_contents objectForKey:key];
}

//-(NSArray *)getContents {
//    for (NSString * in <#collection#>) {
//        <#statements#>
//    }
//}

@end
