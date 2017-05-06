//
//  CollectSratView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 收藏星星状态
 
 - author: LingFeng
 - date: 2016-07-15 09:07:03
 */
typedef enum : NSUInteger {
    ZXXStatusNoCollect,
    ZXXStatusCollect,
} ZXXCStatus;

@interface CollectSratView : UIView
///收藏星星
@property (retain, nonatomic) UIImageView *starImageView;
@property (retain, nonatomic) MyLabel *collectJobLabel;
@property (assign, nonatomic) ZXXCStatus collectSatus;
/**
 * @author LingFeng, 2016-07-22 08:07:06
 *
 * 点击收藏方法
 */
@property (copy, nonatomic) void(^starClick)();
/**
 * @author LingFeng, 2016-07-22 08:07:37
 *
 * 设置收藏状态
 */
@property (copy, nonatomic) void(^starSetupSatus)(BOOL isCollect);
@end
