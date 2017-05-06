//
//  MyLocation.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation

-(instancetype)init {
    if (self = [super init]) {

        _location = [[CLLocationManager alloc]init];
        //    每次使用使用期间 定位
        [_location requestWhenInUseAuthorization];
        //    是否开启定位授权
        _location.delegate = self;
        //    定位 在当前位置不更新位置 距离几米后重新定位 精度 double
        _location.distanceFilter = 5;
        //    期望 精度
        _location.desiredAccuracy = 10;
        
        //    开始定位
        [_location startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation * loc = locations.lastObject;
//    NSLog(@"纬%+.6f 经%+.6f",loc.coordinate.latitude, loc.coordinate.longitude);
    CLGeocoder * geo = [[CLGeocoder alloc]init];
    self.loc = loc;
    kWeakSelf(weakSelf);
    [geo reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        NSLog(@"%@",error);
        [placemarks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            NSLog(@"Adder:%@",obj);
            CLPlacemark * cp = obj;
            if (weakSelf.backAdder) {
                weakSelf.backAdder(cp);
            }
        }];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSMutableString *errorString = [[NSMutableString alloc] init];
    
    if ([error domain] == kCLErrorDomain) {
        
        // We handle CoreLocation-related errors here
        switch ([error code]) {
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
            case kCLErrorDenied:{
                [SLFAlert showAlertView:[SLFCommonTools currentViewController] title:nil text:@"打开定位服务来允许用工贝确定您的位置" determineTitle:@"去开启" cancelTitle:@"取消" cancel:1 alertClick:^{
                    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if([[UIApplication sharedApplication] canOpenURL:url]) {
                        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
            }
                break;
            case kCLErrorLocationUnknown:
                //...
                break;
            default:
                //...
                break;
        }
    } else {
        // We handle all non-CoreLocation errors here
    }
    
}

-(void)gotoSetupLocation {
    [SLFAlert showAlertView:[SLFCommonTools currentViewController] title:nil text:@"打开定位服务来允许用工贝确定您的位置" determineTitle:@"开启" cancelTitle:@"取消" cancel:1 alertClick:^{
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
}

- (void)stopLocation {
    [_location stopUpdatingLocation];
    _location.delegate = nil;
}

-(void)dealloc {
    [_location stopUpdatingLocation];
    _location.delegate = nil;
}

@end
