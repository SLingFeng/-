//
//  MyTableView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MyTableViewStateNormal,//正常状态
    MyTableViewStateNoData,//没有数据
    MyTableViewStateFailedLoad,//加载失败
    MyTableViewStateError,//加载错误
    MyTableViewStateUnknownError,//未知错误
    /**
     自定义的状态
     需要设置 
     必须：loadTitle
     可选：loadButtonTitle loadDescription
     */
    MyTableViewStateCustomize,
} MyTableViewState;

@interface MyTableView : UITableView
//是否在加载
//@property (assign, nonatomic) BOOL loading;
/**
 * @author LingFeng, 2016-08-17 14:08:02
 *
 * 加载失败的文字 标题
 */
@property (copy, nonatomic) NSString * loadTitle;
/**
 正文内容
 */
@property (copy, nonatomic) NSString * loadDescription;
/**
 btn 加载失败的文字
 */
@property (copy, nonatomic) NSString * loadButtonTitle;
/**
 按钮方法
 */
@property (copy, nonatomic) void(^stateOnClickBlock)();

@property (assign, nonatomic) MyTableViewState tState;
#pragma mark -
/**
 设置头刷新（必须先调用
 
 @return MJRefreshNormalHeader
 */
-(MJRefreshNormalHeader *)headerSetup;
/**
 设置尾部加载（必须先调用
 
 @return MJRefreshAutoNormalFooter
 */
-(MJRefreshAutoNormalFooter *)footerSetup;
/**
 * @author LingFeng, 2016-06-30 14:06:26
 *
 * 下拉刷新方法
 */
@property (copy, nonatomic) void (^headerRefresh)();
/**
 * @author LingFeng, 2016-06-30 14:06:36
 *
 * 上拉加载方法
 */
@property (copy, nonatomic) void (^footerRefresh)();


@end
