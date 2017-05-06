//
//  PhotoSheetView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoSheetView : UIView
@property (nonatomic, copy) void(^click)(NSInteger);
-(void)show;
@end

@interface PhotoMainView : UIView
@property (nonatomic, copy) void(^btnClick)(NSInteger);
@end
