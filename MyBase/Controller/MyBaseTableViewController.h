//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyBaseViewController.h"
#import "MyTableView.h"

@interface MyBaseTableViewController : MyBaseViewController<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate>

@property (nonatomic, retain, nullable) MyTableView * tableView;
@property (nonatomic, retain, nonnull) UISearchController *searchController;
@property (nonatomic, retain, nonnull) NSMutableDictionary * contents;
-(void)neededTableViewStyle:(UITableViewStyle)style;
-(void)neededSearch;


/**
 对应cell存放字符串 key是section和row组成

 @param text 内容
 @param indexPath indexPath
 */
-(void)setupContents:(NSString * _Nullable)text indexPath:(NSIndexPath * _Nullable)indexPath;
/**
 获取存放的字符串

 @param indexPath indexPath description
 @return 字符串
 */
-(NSString * _Nullable)getContents:(NSIndexPath * _Nullable)indexPath;
/**
 移除对应cell存放的内容

 @param indexPath indexPath description
 */
-(void)removeContents:(NSIndexPath * _Nullable)indexPath;
@end
