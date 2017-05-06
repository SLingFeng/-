//
//  UMengShareMainView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>
@interface UMengShareMainView : UIView
-(void)show;
@property (copy, nonatomic) void(^formType)(UMSocialPlatformType);
@end

@interface MainView : UIView
@property (copy, nonatomic) void(^cancelClick)();
@property (copy, nonatomic) void(^sendType)(UMSocialPlatformType);
@end

@interface ShareIconView : UIView
@property (assign, nonatomic) UMSocialPlatformType type;
@property (copy, nonatomic) void(^typeTap)(UMSocialPlatformType);
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image;
@end
