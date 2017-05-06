//
//  MyViewToScroll.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewToScroll : UIView
@property (copy, nonatomic) void(^click)(NSInteger tag);
@end
