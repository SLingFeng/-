//
//  SelectGroupView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectDataPicker.h"

@interface SelectGroupView : UIView
@property (nonatomic, retain) MyLabel * titleLabel;
@property (nonatomic, retain) NSMutableArray<NSString *> * dataArray;
@property (nonatomic, copy) NSString* timeText;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, copy) void (^backTime)(NSString*, NSDate *,NSInteger);
-(instancetype)initWithTitle:(NSString *)title type:(SeleCtType)type;
@end
