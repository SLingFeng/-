//
//  MyLocation.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyLocation : NSObject<CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager * location;
@property (nonatomic, retain) CLLocation * loc;
@property (nonatomic, copy) void(^backAdder)(CLPlacemark * cp);

//停止定位
- (void)stopLocation;
/**
 去系统设置 定位
 */
-(void)gotoSetupLocation;
@end
