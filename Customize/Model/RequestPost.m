//
//  RequestPost.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "RequestPost.h"
#import <Reachability/Reachability.h>

#define Key @"qplskdjcvj"

static RequestPost * rp = nil;
@implementation RequestPost

+(RequestPost *)shareTools {
    @synchronized(self){
        if (rp == nil) {
            //重写 alloc
            rp = [[super allocWithZone:NULL]init];
            rp.allTaskRequset = [[NSMutableDictionary alloc] initWithCapacity:10];
        }
        return rp;
    }
}
//重写 alloc
+(id)allocWithZone:(struct _NSZone *)zone{
    return [self shareTools];
}
//重写 copy
+(id)copyWithZone:(struct _NSZone *)zone{
    return self;
}

+(AFHTTPSessionManager *)mySessionMageager {
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = 15;
    session.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"application/javascript", @"application/x-javascript", @"text/x-javascript", @"text/x-json", @"application/x-www-form-urlencoded", @"multipart/form-data", nil];
    [RequestPost setHttpHeader:session];
    return session;
}

#pragma mark - 设置HTTPHeader
+(void)setHttpHeader:(AFHTTPSessionManager *)session {
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    NSString * device = @"device_1.0.0";
    NSString * md = [NSString stringWithFormat:@"%@%@%@",timeSp, Key, device];
    NSString *codeAll = [NSString MD5:md isUp:0];
    NSString *code = [codeAll substringToIndex:28];
    [session.requestSerializer setValue:timeSp forHTTPHeaderField:@"check-time"];
    [session.requestSerializer setValue:code forHTTPHeaderField:@"check-md5"];
    if ([GVUserDefaults standardUserDefaults].ygbUserToken != nil && ![[GVUserDefaults standardUserDefaults].ygbUserToken isEqualToString:@""]) {
        [session.requestSerializer setValue:[GVUserDefaults standardUserDefaults].ygbUserToken forHTTPHeaderField:@"check-token"];
    }
}

+ (void)GET:(NSString *)URLString
                   parameters:(id)parameters success:(void (^)(NSDictionary * response))success failure:(void (^)(NSError * error))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    for (NSString * temp in [[RequestPost shareTools].allTaskRequset allKeys]) {
        if ([URLString isEqualToString:temp]) {
            return;
        }
    }
    [SLFHUD showLoading];
    NSURLSessionDataTask * nowTask = [[RequestPost mySessionMageager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SLFHUD hideHud];
        NSDictionary * data = responseObject;
        if ([RequestPost check:data]) {
            if (data != nil) {
                if (success) {
                    success(data);
                }
            }else {
                [task cancel];
            }
        }
        for (NSURLSessionDataTask * tempTask in [[RequestPost shareTools].allTaskRequset allValues]) {
            if (tempTask == task) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SLFHUD hideHud];
        NSLog(@"error---->\n:%@", error);
        NSLog(@"errorCode---->:\n%ld", (long)error.code);
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        if([error.localizedDescription isEqualToString:@"Request failed: unauthorized (401)"]) {
            failure(error);
        }else if ([error.localizedDescription isEqualToString:@"似乎已断开与互联网的连接。"]) {
            [SLFHUD showHint:@"未连接网络"];
            failure(error);
        }else if ([error.localizedDescription isEqualToString:@"请求超时。"]) {
            [SLFHUD showHint:@"请求超时"];
            failure(error);
        }else if ([error.localizedDescription isEqualToString:@"未能连接到服务器。"]) {
            [SLFHUD showHint:@"未能连接到服务器"];
            failure(error);
        }else {
            [SLFHUD showHint:[NSString stringWithFormat:@"错误信息:%@", [error localizedDescription]]];
            failure(error);
        }
        
        [task cancel];
        for (NSURLSessionDataTask * tempTask in [[RequestPost shareTools].allTaskRequset allValues]) {
            if (tempTask == task) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    }];
    [[RequestPost shareTools].allTaskRequset setObject:nowTask forKey:URLString];
}

+ (void)POST:(NSString *)URLString
                    parameters:(id) parameters success:(void (^)(NSDictionary * response))success failure:(void (^)(NSError * error))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    for (NSDictionary * temp in [[RequestPost shareTools].allTaskRequset allValues]) {
        if ((NSDictionary *)parameters == temp) {
            return;
        }
    }
    [SLFHUD showLoading];
    [[RequestPost mySessionMageager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SLFHUD hideHud];
        NSDictionary * data = responseObject;
        if ([RequestPost check:data]) {
            if (data != nil) {
                if (success) {
                    success(data);
                }
            }else {
                [task cancel];
            }
        }
        for (NSDictionary * temp in [[RequestPost shareTools].allTaskRequset allValues]) {
            if ((NSDictionary *)parameters == temp) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SLFHUD hideHud];
        NSLog(@"error-->:\n%@", error);
        NSLog(@"errorCode---->:\n%ld", (long)error.code);
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        if([error.localizedDescription isEqualToString:@"Request failed: unauthorized (401)"]) {
            failure(error);
        }else if ([error.localizedDescription isEqualToString:@"似乎已断开与互联网的连接。"]) {
            [SLFHUD showHint:@"未连接网络"];
            failure(error);
        }else if ([error.localizedDescription isEqualToString:@"请求超时。"]) {
            [SLFHUD showHint:@"请求超时"];
            failure(error);
        }else if ([error.localizedDescription isEqualToString:@"未能连接到服务器。"]) {
            [SLFHUD showHint:@"未能连接到服务器"];
            failure(error);
        }else {
            [SLFHUD showHint:[NSString stringWithFormat:@"错误信息:%@", [error localizedDescription]]];
            failure(error);
        }
        
        [task cancel];
        for (NSDictionary * temp in [[RequestPost shareTools].allTaskRequset allValues]) {
            if ((NSDictionary *)parameters == temp) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    }];
    if (parameters != nil) {
        [[RequestPost shareTools].allTaskRequset setObject:(NSDictionary *)parameters forKey:URLString];
    }
}

+ (void)POST:(NSString *)URLString
  parameters:(id) parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(NSDictionary * response))success failure:(void (^)(NSError * error))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    for (NSDictionary * temp in [[RequestPost shareTools].allTaskRequset allValues]) {
        if ((NSDictionary *)parameters == temp) {
            return;
        }
    }
    
    [SLFHUD showLoading];
    [[RequestPost mySessionMageager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SLFHUD hideHud];
        NSDictionary * data = responseObject;
        if ([RequestPost check:data]) {
            if (data != nil) {
                if (success) {
                    success(data);
                }
            }else {
                [task cancel];
            }
        }
        for (NSDictionary * temp in [[RequestPost shareTools].allTaskRequset allValues]) {
            if ((NSDictionary *)parameters == temp) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SLFHUD hideHud];
        NSLog(@"error-->:\n%@", error);
        NSLog(@"errorCode---->:\n%ld", (long)error.code);
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        if([error.localizedDescription isEqualToString:@"Request failed: unauthorized (401)"]) {
            failure(error);
        }else if ([error.localizedDescription isEqualToString:@"似乎已断开与互联网的连接。"]) {
            [SLFHUD showHint:@"未连接网络"];
            failure(error);
        }else if ([error.localizedDescription isEqualToString:@"请求超时。"]) {
            [SLFHUD showHint:@"请求超时"];
            failure(error);
        }else if ([error.localizedDescription isEqualToString:@"未能连接到服务器。"]) {
            [SLFHUD showHint:@"未能连接到服务器"];
            failure(error);
        }else {
            [SLFHUD showHint:[NSString stringWithFormat:@"错误信息:%@", [error localizedDescription]]];
            failure(error);
        }
        
        [task cancel];
        for (NSDictionary * temp in [[RequestPost shareTools].allTaskRequset allValues]) {
            if ((NSDictionary *)parameters == temp) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    }];
    if (parameters != nil) {
        [[RequestPost shareTools].allTaskRequset setObject:(NSDictionary *)parameters forKey:URLString];
    }
}

+ (BOOL)check:(NSDictionary *)request {
    if ([request[@"code"] integerValue] == 1) {
        //token 错误
//        [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController popToRootViewControllerAnimated:1];
//        [[GVUserDefaults standardUserDefaults] removeUserInfo];
        [SLFHUD showHint:@"token 错误,请重新登录"];
        return 0;
    }else if ([request[@"code"] integerValue] == 2) {
//        会话过期
        [SLFHUD showHint:@"会话过期"];
        return 0;
    }else if ([request[@"code"] integerValue] == 3) {
//        非法请求
        [SLFHUD showHint:@"非法请求"];
        return 0;
    }else {
        return 1;
    }
}

#pragma mark - 网络连接
+(void)checkNetwork:(void(^)(BOOL isGo))networkStatus {

    Reachability * reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    reach.reachableBlock = ^(Reachability * reach) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
            if (networkStatus) {
                networkStatus(YES);
            }
        });
    };
    reach.unreachableBlock = ^(Reachability*reach)
    {
        if (networkStatus) {
            networkStatus(NO);
        }
        NSLog(@"UNREACHABLE!");
    };
    [reach startNotifier];

}

#pragma mark - 更新app
#define APP_URL @"http://itunes.apple.com/cn/lookup?id=1152760635"
+(void)requestToUpdateApp:(void(^)(NSString *versionStr, NSString *releaseNotes, NSString *trackViewUrl))callBackData {
    NSString * appUrl = APP_URL;
    kWeakObj(weakAppUrl, appUrl);
//    [RequestPost requestToUpdateAppLink:^(NSString *linkAppUpdate) {
    
//        if (linkAppUpdate != nil) {
//            if ([linkAppUpdate isEqualToString:@""]) {
//                
//            }else {
//                weakAppUrl = linkAppUpdate;
//            }
            [[RequestPost mySessionMageager] GET:weakAppUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //        NSLog(@"%@",responseObject);
                /*responseObject是个字典{}，有两个key
                 
                 KEYresultCount = 1//表示搜到一个符合你要求的APP
                 results =（）//这是个只有一个元素的数组，里面都是app信息，那一个元素就是一个字典。里面有各种key。其中有 trackName （名称）trackViewUrl = （下载地址）version （可显示的版本号）等等
                 */
                //具体实现为
                NSArray *arr = [responseObject objectForKey:@"results"];
                NSDictionary *dic = [arr firstObject];
                NSString *versionStr = [dic objectForKey:@"version"];
                NSString *trackViewUrl = [dic objectForKey:@"trackViewUrl"];
                NSString *releaseNotes = [dic objectForKey:@"releaseNotes"];//更新日志
                
                //NSString* buile = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleVersionKey];build号
                NSString* thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
                
                if ([RequestPost compareVersionsFormAppStore:versionStr WithAppVersion:thisVersion]) {
                    
                    if (callBackData) {
                        callBackData(versionStr, releaseNotes, trackViewUrl);
                    }
                }else {
                    if (callBackData) {
                        callBackData(nil, nil, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error---->\n:%@", error);
                [task cancel];
                if (callBackData) {
                    callBackData(nil, nil, nil);
                }
            }];
//        }
        
//    }];
    
}
//比较版本的方法，在这里我用的是Version来比较的
+ (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion WithAppVersion:(NSString*)AppVersion{
    
    BOOL littleSunResult = false;
    if (AppStoreVersion == nil) {
        return littleSunResult;
    }
    
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [AppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
    
}
/*
#pragma mark - 上传图片

+(void)POST:(NSString *)URLString
 parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>  _Nonnull formData))constructingBody success:(void (^)(id _Nullable response))success failure:(void (^)(BOOL isError))failure {
    [[RequestPost mySessionMageager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (constructingBody) {
            constructingBody(formData);
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSDictionary *dic = responseObject;
        //        if (dic[@"success"]) {
        //
        if (success) {
            success(responseObject);
        }
        //        }else{
        //            //            取消这次的请求
        //            [task cancel];
        //        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(YES);
        }
        NSLog(@"error-->:\n%@", error);
    }];
    
    
}
//单张
+(void)uploadImage:(UIImage *)image block:(void(^)())callBackData {
    [RequestPost POST:@""  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imgData = UIImageJPEGRepresentation(image, 1);
        //        上传的参数名
        NSString *name = @"myUpload";
        //上传的filename
        //2. 利用时间戳当做图片名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *imageName = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
        [formData appendPartWithFileData:imgData
                                    name:name
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } success:^(id  _Nullable response) {
        //        [AccessImageModel setUp];
        //        AccessImageModel *accessImage = [AccessImageModel mj_objectWithKeyValues:response];
        //        if (callBackData) {
        //            callBackData(accessImage);
        //        }
    } failure:^(BOOL isError) {
        
    }];
}

+(void)uploadImageS:(NSArray <UIImage *>*)imageArray block:(void(^)())callBackData {
    [RequestPost POST:@""  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i<imageArray.count; i++) {
            UIImage *uploadImage = imageArray[i];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(uploadImage, 1) name:[NSString stringWithFormat:@"参数%d",i+1] fileName:@"test.jpg" mimeType:@"image/jpg"];
        }
        
    } success:^(id  _Nullable response) {
        //        [AccessImageModel setUp];
        //        AccessImageModel *accessImage = [AccessImageModel mj_objectWithKeyValues:response];
        //        if (callBackData) {
        //            callBackData(accessImage);
        //        }
    } failure:^(BOOL isError) {
        
    }];
}*/

#pragma mark - 0.获取系统参数数据字典
+ (void)apiForGetAppConfigSuccess:(void(^)(BOOL go))bolck {
    [[RequestPost mySessionMageager] POST:kURL_GetAppConfig parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * response = responseObject;
        YGBAppConfigModel * config = [[YGBAppConfigModel alloc] initWithDictionary:response[@"data"] error:nil];
        bolck([config saveAppConfig]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        bolck(NO);
    }];
}
#pragma mark - 用户登录
//1.1获取登录验证码
+ (void)apiForSendLoginMessage:(NSString *)phone block:(callDoneAndText)block {
    [RequestPost POST:kURL_SendLoginMessage parameters:@{@"usertel" : phone, @"deviceid" : [OpenUDID value]} success:^(NSDictionary *response) {
        block(response[@"data"][@"success"], response[@"msg"]);
    } failure:^(NSError *error) {
        
    }];
}
//1.2用户登录
+ (void)apiForLoginCheck:(NSString *)phone yzm:(NSString *)yzm block:(callDoneAndText)block {
    [RequestPost POST:kURL_LoginCheck parameters:@{@"usertel" : phone, @"yzm" : yzm} success:^(NSDictionary *response) {
        if ([response[@"data"][@"success"] boolValue] == YES) {
            [GVUserDefaults standardUserDefaults].ygbUserToken = response[@"data"][@"token"];
            YGBUserInfoModel * uim = [[YGBUserInfoModel alloc] initWithDictionary:response[@"data"][@"userinfo"] error:nil];
            [GVUserDefaults standardUserDefaults].ygbmpin = response[@"data"][@"orderinfo"][@"ygbmpin"];
//            [GVUserDefaults standardUserDefaults].ygbstar = response[@"data"][@"orderinfo"][@"star"];
//            [GVUserDefaults standardUserDefaults].ygborder = response[@"data"][@"orderinfo"][@"order"];
            [uim setupUserInfo];
        }
        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//1.3获取验证码
+ (void)apiForGetCodeMessage:(NSString *)phone block:(callDoneAndText)block {
    [RequestPost POST:kURL_CodeMessage parameters:@{@"usertel" : phone}
              success:^(NSDictionary *response) {
              block([response[@"data"][@"success"] boolValue], response[@"msg"]);
              } failure:^(NSError *error) {
                  block(0, [error localizedDescription]);
              }];
}
//1.4校验验证码
+ (void)apiForGetCodeCheck:(NSString *)yzm block:(callDoneAndText)block{
    [RequestPost POST:kURL_CodeCheck parameters:@{@"yzm" : yzm}
              success:^(NSDictionary *response) {
                  block([response[@"data"][@"success"] boolValue], response[@"msg"]);
              } failure:^(NSError *error) {
                  block(0, [error localizedDescription]);
              }];

}
#pragma mark - 一级页面
//2.1 获取一级页
+ (void)apiForFirstViewWithblock:(void(^)(YGBFirstViewModel * model))block{
    NSString *tmp=[GVUserDefaults standardUserDefaults].cityId?[GVUserDefaults standardUserDefaults].cityId:@"101230201";
    [RequestPost POST:kURL_GetFirstView parameters:@{@"lcity":tmp} success:^(NSDictionary *response) {
        YGBFirstViewModel * model = [[YGBFirstViewModel alloc] initWithDictionary:response[@"data"] error:nil];
        if (block) {
            block(model);
        }
    } failure:^(NSError *error) {
        block (nil);
    }];
}
//2.2 获取首页
+ (void)apiForHomeView:(NSString *)type block:(void(^)(YGBSencondViewModel * model))block {
    NSLog(@"%@",[GVUserDefaults standardUserDefaults].ygbUserId);
    [RequestPost POST:kURL_HomeInfo parameters:@{@"userid":[GVUserDefaults standardUserDefaults].ygbUserId, @"type" : type, @"pageNumber" : @"1", @"pageSize" : @"1"} success:^(NSDictionary *response) {
//        NSLog(@"2.2 获取首页:----%@-----\n\n", response);
        YGBSencondViewModel * model = [[YGBSencondViewModel alloc]initWithDictionary:response[@"data"] error:nil];
        if (block) {
            block(model);
        }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
#pragma mark - 3.用工
//3.1获取需求列表息（分页）
+ (void)apiForGetDemandList:(NSString *)type searchText:(NSString *)searchText pageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBDemandListModel * demand))block {
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userid" : kURL_USER_ID,
                                                                                @"type" : type,
                                                                                @"pageNumber" : pageNumber,
                                                                                @"pageSize" : pageSize}];
    
    if (!kStringIsEmpty(searchText)) {
        [dic setObject:searchText forKey:@"keywords"];
    }
    [RequestPost POST:kURL_GetDemandList parameters:dic success:^(NSDictionary *response) {
                                                          YGBDemandListModel * demand = [[YGBDemandListModel alloc] initWithDictionary:response[@"data"] error:nil];
                                                          block(demand);
                                                      } failure:^(NSError *error) {
                                                          block(nil);
                                                      }];
}
//3.1.1获取需求列表息（20条）
+ (void)apiForGetDemandListLimit:(NSString *)type city:(NSString *)city block:(void(^)(YGBDemandListModel * demand))block {
    [RequestPost POST:kURL_GetDemandList parameters:@{@"userid" : [GVUserDefaults standardUserDefaults].ygbUserId, @"lcity" : city} success:^(NSDictionary *response) {
        YGBDemandListModel * demand = [[YGBDemandListModel alloc] initWithDictionary:response[@"data"] error:nil];
        block(demand);
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//3.2获取需求订单详情
+ (void)apiForGetDemandDetail:(NSString *)ygbdid type:(NSString *)type block:(void(^)(YGBDemandDetailModel * detail))block  {
    [RequestPost POST:kURL_GetDemandDetail parameters:@{@"ygbdid" : kStringIsEmpty(ygbdid)?@"":ygbdid, @"type" : type} success:^(NSDictionary *response) {
        YGBDemandDetailModel * detail = [[YGBDemandDetailModel alloc] initWithDictionary:response[@"data"] error:nil];
        block(detail);
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//3.3 用工家教抢单
+ (void)apiForJoborder:(NSString *)ygbdid type:(NSString *)type block:(callDoneAndTextAndObj)block {
//    ygbmcstate：状态：0审核中1认证通过2认证未通过 3未认证
    NSString * userID =  [GVUserDefaults standardUserDefaults].ygbUserId;
    [RequestPost POST:kURL_Joborder parameters:@{@"userid" : userID, @"orderid" : ygbdid, @"type" : type} success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"msg"], response[@"data"][@"ygbmcstate"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription], @"0");
    }];
}
//3.4填写用户信息（完善资料）
+ (void)apiForUpdateInfo:(YGBPerfertModel *)perfer logo:(UIImage *)logo appendfixz:(UIImage *)appendfixz appendfixf:(UIImage *)appendfixf appendfixh:(UIImage *)appendfixh muArray:(NSMutableArray *)array block:(callDoneAndText)block{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:13];
    
    [dic setObject:[GVUserDefaults standardUserDefaults].ygbUserId forKey:@"ygbmid"];
    [dic setObject:perfer.ygbmsex forKey:@"ygbmsex"];
    [dic setObject:perfer.ygbmpin forKey:@"ygbmpin"];
    [dic setObject:perfer.ygbmname forKey:@"ygbmname"];
    [dic setObject:perfer.ygbmjob forKey:@"ygbmjob"];
    [dic setObject:perfer.ygbmjobage forKey:@"ygbmjobage"];
    [dic setObject:perfer.type forKey:@"type"];
    [dic setObject:perfer.ygbdarea forKey:@"ygbmarea"];
    [dic setObject:perfer.ygbmaddress forKey:@"ygbmaddress"];
    
    if (!kStringIsEmpty(perfer.ygbmcid)) {
        [dic setObject:perfer.ygbmcid forKey:@"ygbmcid"];
    }else{
        [dic setObject:@"" forKey:@"ygbmcid"];
    }
    
    [dic setObject:@"2" forKey:@"utype"];
    
//    [dic setObject:kStringIsEmpty(perfer.appendfix)?@"":perfer.appendfix forKey:@"appendfix"];
    [RequestPost POST:kURL_UpdateInfo parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imgData = UIImageJPEGRepresentation(logo, kQuality);
        NSData *imgData2 = UIImageJPEGRepresentation(appendfixz, kQuality);
        NSData *imgData3 = UIImageJPEGRepresentation(appendfixf, kQuality);
        NSData *imgData4 = UIImageJPEGRepresentation(appendfixh, kQuality);
        
        //        上传的参数名
        NSString *name = @"logo";
        NSString *name2 = @"appendfixz";
        NSString *name3 = @"appendfixf";
        NSString *name4 = @"appendfixh";
        //上传的filename
        //2. 利用时间戳当做图片名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *imageName = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
        [formData appendPartWithFileData:imgData
                                    name:name
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:imgData2
                                    name:name2
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:imgData3
                                    name:name3
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:imgData4
                                    name:name4
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        for (int i = 0; i < array.count; i++) {
            UIImage *img = array[i];
            NSData *imgData5 = UIImageJPEGRepresentation(img, kQuality);
            NSString *name5 = @"appendfix";
            [formData appendPartWithFileData:imgData5
                                        name:name5
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
    } success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"data"][@"ygbmlogo"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
//    [RequestPost POST:kURL_UpdateInfo parameters:dic success:^(NSDictionary *response) {
//        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
//    } failure:^(NSError *error) {
//        block(0, [error localizedDescription]);
//    }];
}
//3.5取消订单
+ (void)apiForCancelorder:(NSString *)orderid type:(NSString *)type block:(callDoneAndText)block {
    [RequestPost POST:kURL_Cancelorder parameters:@{@"userid" : [GVUserDefaults standardUserDefaults].ygbUserId, @"orderid" : orderid, @"type" : type} success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//3.5.1取消需求单
+ (void)apiForCanceldemand:(NSString *)ygbdid type:(NSString *)type block:(callDoneAndText)block {
    [RequestPost POST:kURL_Canceldemand parameters:@{@"userid" : [GVUserDefaults standardUserDefaults].ygbUserId, @"ygbdid" : ygbdid, @"type" : type} success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//3.6开始施工/家教
+ (void)apiForStartorder:(NSString *)orderid type:(NSString *)type block:(callDoneAndText)block {
    [RequestPost POST:kURL_Startorder parameters:@{@"userid" : [GVUserDefaults standardUserDefaults].ygbUserId, @"orderid" : orderid, @"type" : type} success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//3.6.1施工/家教完成
+ (void)apiForFinishorder:(NSString *)orderid type:(NSString *)type block:(callDoneAndText)block {
    [RequestPost POST:kURL_Finishorder parameters:@{@"userid" : [GVUserDefaults standardUserDefaults].ygbUserId, @"orderid" : orderid, @"type" : type} success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//3.7 新增用工需求订单
+ (void)apiForAddygOrder:(YGBAddygOrderModel *)order block:(callDoneAndTextAndObj)block {
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:11];
    [dic setObject:[GVUserDefaults standardUserDefaults].ygbUserId forKey:@"ygbmid"];
    [dic setObject:order.ygbdtype forKey:@"ygbdtype"];
    [dic setObject:order.ygbdprovince forKey:@"ygbdprovince"];
    [dic setObject:order.ygbdcity forKey:@"ygbdcity"];
    [dic setObject:order.ygbdarea forKey:@"ygbdarea"];
    [dic setObject:order.ygbdaddress forKey:@"ygbdaddress"];
    [dic setObject:order.ygbdkind forKey:@"ygbdkind"];
    [dic setObject:order.ygbdtimearrival forKey:@"ygbdtimearrival"];
    [dic setObject:kStringIsEmpty(order.ygbdremark)?@"":order.ygbdremark forKey:@"ygbdremark"];
    [dic setObject:order.ygbdworkers forKey:@"ygbdworkers"];
    [dic setObject:order.ygbddays forKey:@"ygbddays"];
    [dic setObject:order.ygbdtel forKey:@"ygbdtel"];
    [dic setObject:order.ygbdcontacts forKey:@"ygbdcontacts"];
    [dic setObject:kStringIsEmpty(order.ygbdaddprice)?@"0":order.ygbdaddprice forKey:@"ygbdaddprice"];

    [dic setObject:order.ygbdlng forKey:@"ygbdlng"];
    [dic setObject:order.ygbdlat forKey:@"ygbdlat"];

    [dic setObject:kStringIsEmpty(order.ygbdamount)?@"0":order.ygbdamount forKey:@"ygbdamount"];

    [RequestPost POST:kURL_Addygorder parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (order.imagesArr.count != 0) {
            for (UIImage * image in order.imagesArr) {
                NSData *imgData = UIImageJPEGRepresentation(image, kQuality);
                NSString *name = @"appendfix";
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *imageName = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
                [formData appendPartWithFileData:imgData
                                            name:name
                                        fileName:fileName
                                        mimeType:@"image/jpeg"];
            }
        }
    } success:^(NSDictionary *response) {
        YGBPayModel * pay = [[YGBPayModel alloc] initWithDictionary:response[@"data"] error:nil];
        pay.price = [NSString stringWithFormat:@"%.2f", [response[@"data"][@"ygbdamount"] doubleValue]];
        pay.pulsType = 1;
        block([response[@"data"][@"success"] boolValue], response[@"msg"], pay);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription], nil);
    }];

}
//3.8 订单付款
+ (void)apiForPayhOrder:(NSString *)orderid type:(NSString *)type block:(callDoneAndText)block {
    [RequestPost POST:kURL_Payhorder parameters:@{@"userid" : [GVUserDefaults standardUserDefaults].ygbUserId, @"orderid" : orderid, @"type" : type} success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"data"][@"sumamount"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//3.9 新增家教需求订单
+ (void)apiForAddjjorder:(YGBAddJjOrderModel *)order block:(callDoneAndTextAndObj)block {
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:11];

    [dic setObject:[GVUserDefaults standardUserDefaults].ygbUserId forKey:@"ygbmid"];
    [dic setObject:order.ygbtime forKey:@"ygbtime"];
    
    [dic setObject:order.ygbdgprovince forKey:@"ygbdgprovince"];
    [dic setObject:order.ygbdgcity forKey:@"ygbdgcity"];
    [dic setObject:order.ygbdgarea forKey:@"ygbdgarea"];
    [dic setObject:order.ygbdgaddress forKey:@"ygbdgaddress"];
    [dic setObject:order.ygbdgmounttime forKey:@"ygbdgmounttime"];
    [dic setObject:order.ygbdgmoment forKey:@"ygbdgmoment"];
    [dic setObject:kStringIsEmpty(order.ygbdgremark)?@"":order.ygbdgremark forKey:@"ygbdgremark"];
    [dic setObject:order.ygbdgsubject forKey:@"ygbdgsubject"];
    [dic setObject:order.ygbdgsex forKey:@"ygbdgsex"];
    [dic setObject:order.ygbeducation forKey:@"ygbeducation"];
    [dic setObject:order.ygbdgdays forKey:@"ygbdgdays"];
    [dic setObject:order.ygbdgtel forKey:@"ygbdgtel"];
    [dic setObject:order.ygbdgcontacts forKey:@"ygbdgcontacts"];

    [dic setObject:order.ygbdglng forKey:@"ygbdglng"];
    [dic setObject:order.ygbdglat forKey:@"ygbdglat"];
    
    [dic setObject:kStringIsEmpty(order.ygbdgamount)?@"0":order.ygbdgamount forKey:@"ygbdamount"];
    
    [RequestPost POST:kURL_Addjjorder parameters:dic success:^(NSDictionary *response) {
        YGBPayModel * pay = [[YGBPayModel alloc] initWithDictionary:response[@"data"] error:nil];
        pay.pulsType = 1;
        pay.price = [response[@"data"][@"ygbdgamount"] stringValue];
        pay.ygbdamount = response[@"data"][@"ygbdgamount"];
        block([response[@"data"][@"success"] boolValue], response[@"msg"], pay);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription], nil);
    }];
}
//需求列表筛选
+ (void)apiForGetDemandList2:(YGBFiterDemandModel *)model block:(void(^)(YGBDemandListModel * list))block {
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:4];
    model.userid = [GVUserDefaults standardUserDefaults].ygbUserId;
    
    if (!kObjectIsEmpty(model.userid)) {
        [dic setObject:model.userid forKey:@"userid"];
    }
    if (!kObjectIsEmpty(model.type)) {
        [dic setObject:model.type forKey:@"type"];
    }
    if (!kObjectIsEmpty(model.pageNumber)) {
        [dic setObject:model.pageNumber forKey:@"pageNumber"];
    }
    if (!kObjectIsEmpty(model.pageSize)) {
        [dic setObject:model.pageSize forKey:@"pageSize"];
    }
    if (!kObjectIsEmpty(model.lat)) {
        [dic setObject:model.lat forKey:@"lat"];
    }
    if (!kObjectIsEmpty(model.lng)) {
        [dic setObject:model.lng forKey:@"lng"];
    }
    if (!kObjectIsEmpty(model.subject)) {
        [dic setObject:model.subject forKey:@"subject"];
    }
    if (!kObjectIsEmpty(model.moment)) {
        [dic setObject:model.moment forKey:@"moment"];
    }
    if (!kObjectIsEmpty(model.distance)) {
        [dic setObject:model.distance forKey:@"distance"];
    }
    if (!kObjectIsEmpty(model.days)) {
        [dic setObject:model.days forKey:@"days"];
    }
    if (!kObjectIsEmpty(model.kind)) {
        [dic setObject:model.kind forKey:@"kind"];
    }
    if (!kObjectIsEmpty(model.workers)) {
        [dic setObject:model.workers forKey:@"workers"];
    }
    
    [RequestPost POST:kURL_getDemandList2 parameters:dic success:^(NSDictionary *response) {
        NSError * error;
        YGBDemandListModel * demand = [[YGBDemandListModel alloc] initWithDictionary:response[@"data"] error:&error];
        block(demand);
    } failure:^(NSError *error) {
        block(nil);
    }];
}

#pragma mark - 我的
//5.1.获取个人信息
+ (void)apiForGetInfo:(void(^)(YGBUserModel * user))block {
    [RequestPost POST:kURL_GetInfo parameters:@{@"userid" : kURL_USER_ID} success:^(NSDictionary *response) {
        YGBUserModel * user = [[YGBUserModel alloc] initWithDictionary:response[@"data"] error:nil];
        [user.userinfo setupUserInfo];
        if (block) {
            block(user);
        }
    } failure:^(NSError *error) {
        block (nil);
    }];
}

+ (void)apiForGetInfo:(NSString *)otherID block:(void(^)(YGBUserModel * user))block {
    [RequestPost POST:kURL_GetInfo parameters:@{@"userid" : otherID} success:^(NSDictionary *response) {
        YGBUserModel * user = [[YGBUserModel alloc] initWithDictionary:response[@"data"] error:nil];
        if (block) {
            block(user);
        }
    } failure:^(NSError *error) {
        block (nil);
    }];
}

//5.2.我的订单
+ (void)apiForGetmyorder:(NSString *)type ygbotype:(NSString *)ygbotype pageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBMyOrderModel * order))block {
    [RequestPost POST:kURL_Getmyorder parameters:@{@"userid" : kURL_USER_ID,
                                                   @"type" : type,
                                                   @"ygbotype" : ygbotype,
                                                   @"pageNumber" : pageNumber,
                                                   @"pageSize" : pageSize}
              success:^(NSDictionary *response) {
                  YGBMyOrderModel *order = [[YGBMyOrderModel alloc] initWithDictionary:response[@"data"] error:nil];
                  if (block) {
                      block(order);
                  }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.3 订单详情
+ (void)apiForGetmyorderDetail:(NSString *)type WithYgboid:(NSString *)ygboid block:(void(^)(YGBMyOrderDetailModel * detail))block {
    [RequestPost POST:kURL_GetmyorderDetail parameters:@{@"ygboid" : ygboid,
                                                           @"type" : type}
              success:^(NSDictionary *response) {
                  YGBMyOrderDetailModel * detail = [[YGBMyOrderDetailModel alloc] initWithDictionary:response[@"data"] error:nil];
                  if (block) {
                      block(detail);
                  }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.4 我的发布
+ (void)apiForGetpublishList:(NSString *)type ygbotype:(NSString *)ygbotype ygbdauditing:(NSString *)ygbdauditing ygbdstate:(NSString *)ygbdstate pageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBMyPublishListModel * list))block {
    [RequestPost POST:kURL_GetpublishList parameters:@{@"userid" : kURL_USER_ID,
                                                           @"type" : type,
                                                           @"ygbotype" : ygbotype,
                                                           @"ygbdauditing" : ygbdauditing,
                                                            @"ygbdstate":ygbdstate,
                                                           @"pageNumber" : pageNumber,
                                                           @"pageSize" : pageSize}
              success:^(NSDictionary *response) {
                  YGBMyPublishListModel * list = [[YGBMyPublishListModel alloc] initWithDictionary:response[@"data"] error:nil];
                  if (block) {
                      block(list);
                  }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.5 发布详情
+ (void)apiForGetmypublishDetail:(NSString *)ygbdid type:(NSString *)type block:(void(^)(YGBMyPublishDetailModel * detail))block {
    [RequestPost POST:kURL_GetmypublishDetail parameters:@{@"ygbdid" : ygbdid,
                                                           @"type" : type}
              success:^(NSDictionary *response) {
                  YGBMyPublishDetailModel * detail = [[YGBMyPublishDetailModel alloc] initWithDictionary:response[@"data"] error:nil];
                  if (block) {
                      block(detail);
                  }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.6开票
+ (void)apiForAddreceipt:(YGBAddreceiptModel *)addrecipt andOrderId:(NSString *)orderid block:(callDoneAndText)block {
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:11];
    if (!kObjectIsEmpty(orderid)) {
        [dic setObject:orderid forKey:@"orderid"];
    }
    [dic setObject:addrecipt.ygbrtype forKey:@"ygbrtype"];
    [dic setObject:addrecipt.ygbrname forKey:@"ygbrname"];
    [dic setObject:addrecipt.ygbrcontent forKey:@"ygbrcontent"];
    [dic setObject:addrecipt.ygbramount forKey:@"ygbramount"];
    [dic setObject:addrecipt.ygbrcontact forKey:@"ygbrcontact"];
    [dic setObject:addrecipt.ygbrtel forKey:@"ygbrtel"];
    [dic setObject:[GVUserDefaults standardUserDefaults].ygbUserId  forKey:@"ygbmid"];
    [dic setObject:addrecipt.ygbrprovince forKey:@"ygbrprovince"];
    [dic setObject:addrecipt.ygbrcity forKey:@"ygbrcity"];
    [dic setObject:addrecipt.ygbrarea forKey:@"ygbrarea"];
    [dic setObject:addrecipt.ygbraddress forKey:@"ygbraddress"];
    
    [RequestPost POST:kURL_Addreceipt parameters:dic success:^(NSDictionary *response) {
        if ([response[@"data"][@"success"] boolValue]) {
            block(1, response[@"msg"]);
        }
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//5.7发票信息列表
+ (void)apiForGetreceiptlistPageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBReceiptListModel *receiptList))block {
    [RequestPost POST:kURL_Getreceiptlist parameters:@{@"userid" : kURL_USER_ID,
                                                       @"pageNumber" : pageNumber,
                                                       @"pageSize" : pageSize}
              success:^(NSDictionary *response) {
                  YGBReceiptListModel *receiptList = [[YGBReceiptListModel alloc] initWithDictionary:response[@"data"] error:nil];
                  if (block) {
                      block(receiptList);
                  }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.8我的钱包
+ (void)apiForGetmymoneyBlock:(void(^)(YGBMyWalletModel *wall))block {
    [RequestPost POST:kURL_Getmymoney parameters:@{@"userid" : kURL_USER_ID} success:^(NSDictionary *response) {
        YGBMyWalletModel *wall = [[YGBMyWalletModel alloc] initWithDictionary:response[@"data"] error:nil];
        if (block) {
            block(wall);
        }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.9我的钱包-交易记录
+ (void)apiForGetpayhostoryNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize Block:(void(^)(YGBPayHostoryModel * pay))block {
    [RequestPost POST:kURL_Getpayhostory parameters:@{@"userid" : kURL_USER_ID,
                                                      @"pageNumber" : pageNumber,
                                                      @"pageSize" : pageSize}
              success:^(NSDictionary *response) {
        YGBPayHostoryModel * pay = [[YGBPayHostoryModel alloc] initWithDictionary:response[@"data"] error:nil];
        if (block) {
            block(pay);
        }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.10绑定银行卡
+ (void)apiForBindBandCard:(NSString *)bankno ygbmbank:(NSString *)ygbmbank ygbmbankarea:(NSString *)ygbmbankarea ygbmbankname:(NSString *)ygbmbankname ygbmbanktel:(NSString *)ygbmbanktel  block:(void(^)(YGBMyWalletModel *wall))block {
    [RequestPost POST:kURL_BindBandCard parameters:@{@"userid" : kURL_USER_ID,
                                                     @"bankno" : bankno,
                                                     @"ygbmbank":ygbmbank,
                                                     @"ygbmbankarea":ygbmbankarea,
                                                     @"ygbmbankname":ygbmbankname,
                                                     @"ygbmbanktel":ygbmbanktel}
              success:^(NSDictionary *response) {
                  YGBMyWalletModel *wall = [[YGBMyWalletModel alloc] initWithDictionary:response[@"data"] error:nil];
                  if (block) {
                      block(wall);
                  }
                  
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.11 提现
+ (void)apiForGetBankMoney:(NSString *)bankno amount:(NSString *)amount block:(void(^)(YGBMyWalletModel *wall))block {
    [RequestPost POST:kURL_GetBankMoney parameters:@{@"userid" : kURL_USER_ID,
                                                     @"bankno" : bankno,
                                                     @"amount" : amount}
              success:^(NSDictionary *response) {
                  YGBMyWalletModel *wall = [[YGBMyWalletModel alloc] initWithDictionary:response[@"data"] error:nil];
                  if (block) {
                      block(wall);
                  }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.10提现完成
+ (void)apiForgetBankMoneyFinish:(NSString *)bankno amount:(NSString *)amount ygbchargeamount:(NSString *)ygbchargeamount block:(callDoneAndText)block {
    [RequestPost POST:kURL_GetBankMoneyFinish parameters:@{@"userid" : kURL_USER_ID,
                                                     @"bankno" : bankno,
                                                     @"amount" : amount,
                                                    @"ygbchargeamount":ygbchargeamount}
              success:^(NSDictionary *response) {
                  block([response[@"data"][@"success"] boolValue], response[@"msg"]);
              } failure:^(NSError *error) {
                  block(0, [error localizedDescription]);
              }];
}

//5.12 提现记录
+ (void)apiForGetMoneyHistoryBlock:(void(^)(YGBMoneyHistoryModel *history))block {
    [RequestPost POST:kURL_GetMoneyHistory parameters:@{@"userid" : kURL_USER_ID} success:^(NSDictionary *response) {
        YGBMoneyHistoryModel *history = [[YGBMoneyHistoryModel alloc] initWithDictionary:response[@"data"][@"moneyarray"] error:nil];
        if (block) {
            block(history);
        }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.13 评价记录
+ (void)apiForgetRankHistoryBlock:(void(^)(YGBRankHistoryModel *rank))block {
    [RequestPost POST:kURL_GetRankHistory parameters:@{@"userid" : kURL_USER_ID} success:^(NSDictionary *response) {
        YGBRankHistoryModel *rank = [[YGBRankHistoryModel alloc] initWithDictionary:response[@"data"] error:nil];
        if (block) {
            block(rank);
        }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.14我的优惠券
+ (void)apiForGetcouponlist:(NSString *)state number:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBCouponListModel * coupon))block {
    [RequestPost POST:kURL_Getcouponlist parameters:@{@"userid" : kURL_USER_ID,
                                                      @"state" : state,
                                                      @"pageNumber" : pageNumber,
                                                      @"pageSize" : pageSize}
              success:^(NSDictionary *response) {
        YGBCouponListModel * coupon = [[YGBCouponListModel alloc] initWithDictionary:response[@"data"] error:nil];
        if (block) {
            block(coupon);
        }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.15修改个人信息
+ (void)apiForUpdateInfo:(UIImage *)logo ygbmsex:(NSString *)ygbmsex ygbmaddress:(NSString *)ygbmaddress ygbmtel:(NSString *)ygbmtel ygbdarea:(NSString *)ygbdarea block:(callDoneAndText)block {
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:5];
//    if (ygbmname != nil) {
//        [dic setObject:ygbmname forKey:@"logo"];
//    }
    [dic setObject:[GVUserDefaults standardUserDefaults].ygbUserId forKey:@"ygbmid"];
    if (ygbmsex != nil) {
        [dic setObject:ygbmsex forKey:@"ygbmsex"];
    }
    if (ygbmtel != nil) {
        [dic setObject:ygbmtel forKey:@"ygbmtel"];
    }
    if (ygbdarea != nil) {
        [dic setObject:ygbdarea forKey:@"ygbmarea"];
    }
    if (ygbmaddress != nil) {
        [dic setObject:ygbmaddress forKey:@"ygbmaddress"];
    }
    
    [dic setObject:@"1" forKey:@"utype"];
    
    [RequestPost POST:kURL_UpdateInfo parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imgData = UIImageJPEGRepresentation(logo, kQuality);
        //        上传的参数名
        NSString *name = @"logo";
        //上传的filename
        //2. 利用时间戳当做图片名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *imageName = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
        [formData appendPartWithFileData:imgData
                                    name:name
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"data"][@"ygbmlogo"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
//    [RequestPost POST:kURL_UpdateInfo parameters:dic success:^(NSDictionary *response) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
}
//5.16 修改头像
+ (void)apiForUpdateImage:(UIImage *)image block:(callDoneAndText)block {
    [SLFHUD showLoadingHint:@"正在上传，稍等~~"];
    [RequestPost POST:kURL_UpdateImage parameters:@{@"userid" : kURL_USER_ID} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       
    } success:^(NSDictionary *response) {
        [SLFHUD hideHud];
        block([response[@"data"][@"success"] boolValue], response[@"data"][@"ygbmlogo"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//5.17上传身份证
+ (void)apiForUpdateidcardWithZeng:(UIImage *)zengImage fanImage:(UIImage *)fanImage shouImage:(UIImage *)shouImage block:(callDoneAndText)block {
    [SLFHUD showLoadingHint:@"正在上传，稍等~~"];
    [RequestPost POST:kURL_Updateidcard parameters:@{@"userid" : kURL_USER_ID} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //正面 反面
        NSArray * titlesArr = @[@"appendfixz", @"appendfixf", @""];
        
        for (int i=0; i<titlesArr.count; i++) {
            NSData *imgData;
            if (i == 0) {
                imgData = UIImageJPEGRepresentation(zengImage, kQuality);
            }else if (i == 1) {
                imgData = UIImageJPEGRepresentation(fanImage, kQuality);
            }else if (i == 2) {
                imgData = UIImageJPEGRepresentation(shouImage, kQuality);
            }
            NSString *name = titlesArr[i];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *imageName = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
            [formData appendPartWithFileData:imgData
                                        name:name
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
    } success:^(NSDictionary *response) {
        [SLFHUD hideHud];
        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        [SLFHUD hideHud];
        block(0, [error localizedDescription]);
    }];
}
//5.18 上传证书
+ (void)apiForUpdatecertificate:(UIImage *)appendfix type:(NSString *)type block:(callDoneAndText)block {
    [SLFHUD showLoadingHint:@"正在上传，稍等~~"];
    [RequestPost POST:kURL_Updateidcard parameters:@{@"userid" : kURL_USER_ID} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imgData = UIImageJPEGRepresentation(appendfix, kQuality);
        NSString *name = @"appendfix";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *imageName = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
        [formData appendPartWithFileData:imgData
                                    name:name
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } success:^(NSDictionary *response) {
        [SLFHUD hideHud];
        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        [SLFHUD hideHud];
        block(0, [error localizedDescription]);
    }];
}
//5.19修改支付密码

+ (void)apiForUpdatepaypwWithPhone:(NSString *)phone pw:(NSString *)pw type:(NSString *)type block:(callDoneAndText)block {
//    type=0 更新支付密码 ，type=1验证密码
    [RequestPost POST:kURL_Updatepaypw parameters:@{@"usertel" : phone, @"pwd" : pw, @"type" : type} success:^(NSDictionary *response) {

        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//5.20 我的认证
+ (void)apiForGetcertificateListBlock:(void(^)(YGBCertificateModel * cer))block {
    [RequestPost POST:kURL_GetcertificateList parameters:@{@"userid" : kURL_USER_ID} success:^(NSDictionary *response) {
        YGBCertificateModel * cer = [[YGBCertificateModel alloc] initWithDictionary:response[@"data"] error:nil];
        if (block) {
            block(cer);
        }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//5.21 认证详情
+ (void)apiForGetcertificateDetail:(NSString *)ygbmcid block:(void(^)(YGBCertificateDetailModel * cdm))block {
    [RequestPost POST:kURL_GetcertificateDetail parameters:@{@"ygbmcid" : ygbmcid} success:^(NSDictionary *response) {
        YGBCertificateDetailModel * cdm = [[YGBCertificateDetailModel alloc] initWithDictionary:response[@"data"] error:nil];
        if (block) {
            block(cdm);
        }
    } failure:^(NSError *error) {
        block(nil);
    }];
}
#pragma mark - 消息
//6.1 系统消息
+ (void)apiForGetSystemNoticeBlock:(void(^)(YGBNoticeModel * notic))block {
    [RequestPost POST:kURL_GetSystemNotice parameters:@{@"userid" : kURL_USER_ID} success:^(NSDictionary *response) {
        YGBNoticeModel * notic = [[YGBNoticeModel alloc] initWithDictionary:response[@"data"] error:nil];
        block(notic);
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//6.2系统消息详情
+ (void)apiForGetDetailNotice:(NSString *)noticeID block:(void(^)(YGBNoticeInfoModel * notInfo))block {
    [RequestPost POST:kURL_GetDetailNotice parameters:@{@"ygbmsid" : noticeID} success:^(NSDictionary *response) {
        YGBNoticeInfoModel * notInfo = [[YGBNoticeInfoModel alloc] initWithDictionary:response[@"data"] error:nil];
        block(notInfo);
    } failure:^(NSError *error) {
        block(nil);
    }];
}
#pragma mark - 7.反馈
//7.1 添加用户反馈信息
+ (void)apiForAddfeedback:(NSString *)contentText block:(callDoneAndText)block {
    [RequestPost POST:kURL_Addfeedback parameters:@{@"ygbmid" : kURL_USER_ID, @"ygbfcontent" : contentText} success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//7.2 查看反馈列表
+ (void)apiForGetfeedbacklistBlock:(void(^)(YGBFeedBackListModel * list))block {
    [RequestPost POST:kURL_Getfeedbacklist parameters:@{@"userid" : kURL_USER_ID} success:^(NSDictionary *response) {
        YGBFeedBackListModel * list = [[YGBFeedBackListModel alloc] initWithDictionary:response[@"data"] error:nil];
        block(list);
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//7.3 查看系统反馈详情
+ (void)apiForGetfeedbackdetail:(NSString *)ygbmsid block:(void(^)(YGBFeedBackDetailModel * detail))block {
    [RequestPost POST:kURL_Getfeedbackdetail parameters:@{@"ygbmsid" : ygbmsid} success:^(NSDictionary *response) {
        YGBFeedBackDetailModel * detail = [[YGBFeedBackDetailModel alloc] initWithDictionary:response[@"data"] error:nil];
        block(detail);
    } failure:^(NSError *error) {
        block(nil);
    }];
}
#pragma mark - 8.评价
//8.1添加评价
+ (void)apiForAddevaluate:(YGBAddevaluateListModel *)evaList block:(callDoneAndText)block {
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:11];
    [dic setObject:evaList.ygbestar forKey:@"ygbestar"];
    [dic setObject:evaList.ygboid forKey:@"ygboid"];
    [dic setObject:kStringIsEmpty(evaList.ygbeevaluate)?@"":evaList.ygbeevaluate forKey:@"ygbeevaluate"];
    [dic setObject:kStringIsEmpty(evaList.ygbeevaluatemc)?@"":evaList.ygbeevaluatemc forKey:@"ygbeevaluatemc"];
    [dic setObject:[GVUserDefaults standardUserDefaults].ygbUserId forKey:@"ygbmid"];
    
    [RequestPost POST:kURL_Addevaluate parameters:dic success:^(NSDictionary *response) {
        block([response[@"data"][@"success"] boolValue], response[@"msg"]);
    } failure:^(NSError *error) {
        block(0, [error localizedDescription]);
    }];
}
//8.2查看评价列表
+ (void)apiForGetevaluatelistType:(NSString *)type objecttype:(NSString *)objecttype pageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBAddevaluateModel * eval))block {
    [RequestPost POST:kURL_Getevaluatelist parameters:@{@"ygbmid" : kURL_USER_ID,
                                                        @"type":type,
                                                        @"objecttype":objecttype,
                                                        @"pageNumber" : pageNumber,
                                                        @"pageSize" : pageSize}
              success:^(NSDictionary *response) {
        YGBAddevaluateModel *eval = [[YGBAddevaluateModel alloc] initWithDictionary:response[@"data"] error:nil];
        block(eval);
    } failure:^(NSError *error) {
        block(nil);
    }];
}
//9.1 应用简介
+ (void)apiForGetAppIntroduceblock:(callDoneAndText)block {
    [RequestPost POST:kURL_GetAppIntroduce parameters:nil
              success:^(NSDictionary *response) {
                  block([response[@"data"][@"success"] boolValue], response[@"data"][@"introduce"]);
              } failure:^(NSError *error) {
                  block(0, [error localizedDescription]);
              }];
}
//支付宝
+ (void)apiForAliPay:(YGBPayModel *)pay block:(callDoneAndText)block {
    
//    NSMutableString * URLAppend = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@?%@", kURL_AliPay, sign]];
//    NSString * utfURL = [URLAppend stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//
//    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:utfURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSString *signStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            if (kStringIsEmpty(signStr)) {
//                block(NO, @"订单不存在!");
//            }else {
//                block(YES, signStr);
//            }
//        });
//        
//    }];
//    [task resume];
//    [[RequestPost mySessionMageager] POST:URLAppend parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
    
    NSString *string = [NSString stringWithFormat:@"orderId=%@&userId=%@&category=%@&type=%@&ygbcId=%@&price=%@", pay.orderid, [GVUserDefaults standardUserDefaults].ygbUserId, [GVUserDefaults standardUserDefaults].typeYgOrJj?@"1":@"0", pay.pulsType?@"1":@"0", kStringIsEmpty(pay.ygbcId)?@"-1":pay.ygbcId, pay.price];
    
    
    [RequestPost POST:kURL_AliPay parameters:@{@"orderId" : pay.orderid,
                                               @"userId" : [GVUserDefaults standardUserDefaults].ygbUserId,
                                               @"category" : [GVUserDefaults standardUserDefaults].typeYgOrJj?@"1":@"0",
                                               @"type" : pay.pulsType?@"1":@"0",
                                               @"ygbcId" : kStringIsEmpty(pay.ygbcId)?@"-1":pay.ygbcId,
                                               @"price" : pay.price} success:^(NSDictionary *response) {
                                                   
                  BOOL error = [response[@"data"][@"success"] boolValue];
                  block(error, response[@"data"][@"data"]);
              } failure:^(NSError *error) {
                  block(NO, [error localizedDescription]);
              }];
}

//微信支付
+ (void)apiForWXPay:(NSString *)orderId category:(NSString *)category type:(NSString *)type ygbcId:(NSString *)ygbcId price:(NSString *)price {
    
    [RequestPost POST:kURL_wxPay
           parameters:@{@"orderId" : orderId,
                        @"userId" : kURL_USER_ID,
                        @"category" : category,
                        @"type" : type,
                        @"mobile" : [GVUserDefaults standardUserDefaults].ygbUserPhone,
                        @"ygbcId" : ygbcId,
                        @"price" : price}
              success:^(NSDictionary *response) {
        if (response != nil) {
            NSMutableDictionary *dict = (NSMutableDictionary *)response;
            if(dict != nil) {
                NSMutableString *retcode = [dict objectForKey:@"msg"];
                if ([retcode isEqualToString:@"ok"]) {
                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                    
                    //调起微信支付
                    PayReq* req             = [[PayReq alloc] init];
                    req.partnerId           = [dict objectForKey:@"partnerid"];
                    req.prepayId            = [dict objectForKey:@"prepayid"];
                    req.nonceStr            = [dict objectForKey:@"noncestr"];
                    req.timeStamp           = stamp.intValue;
                    req.package             = [dict objectForKey:@"package"];
                    req.sign                = [dict objectForKey:@"sign"];
                    [WXApi sendReq:req];
                    
                    //日志输出
                    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                }else{
                    [SLFAlert showAlertWithTitle:[dict objectForKey:@"retmsg"] checkTitle:@"1" block:^(NSInteger index) {
                        
                    }];
                }
            }else{
                [SLFHUD showHint:@"服务器返回错误，未获取到json对象"];
            }
        }else{
            [SLFHUD showHint:@"服务器返回错误"];
        }

    } failure:^(NSError *error) {
        
        
    }];
//    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"orderId" : orderId, @"userId" : @"21", @"category" : category, @"type" : type, @"mobile" : @"13888888888"}];
//    NSMutableString * URLAppend = [NSMutableString stringWithString:kURL_wxPay];
//    if (parameters != nil) {
//        NSMutableString * parameter = [NSMutableString string];
//        for (int i=0; i<parameters.count; i++) {
//            NSString * key = parameters.allKeys[i];
//            NSString * value = parameters.allValues[i];
//            if (i == 0) {
//                [parameter appendString:[NSString stringWithFormat:@"&%@=%@", key, value]];
//            }else {
//                [parameter appendString:[NSString stringWithFormat:@"&%@=%@", key, value]];
//            }
//        }
//        [URLAppend appendString:parameter];
//    }
//    NSString * utfURL = [URLAppend stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:utfURL]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
////    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (response != nil) {
//            NSMutableDictionary *dict = NULL;
//            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//            dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
//            if(dict != nil) {
//                NSMutableString *retcode = [dict objectForKey:@"retcode"];
//                if (retcode.intValue == 0){
//                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                    
//                    //调起微信支付
//                    PayReq* req             = [[PayReq alloc] init];
//                    req.partnerId           = [dict objectForKey:@"partnerid"];
//                    req.prepayId            = [dict objectForKey:@"prepayid"];
//                    req.nonceStr            = [dict objectForKey:@"noncestr"];
//                    req.timeStamp           = stamp.intValue;
//                    req.package             = [dict objectForKey:@"package"];
//                    req.sign                = [dict objectForKey:@"sign"];
//                    BOOL is = [WXApi sendReq:req];
//                    //日志输出
//                    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                }else{
//                    [SLFAlert showAlertWithTitle:[dict objectForKey:@"retmsg"] checkTitle:@"1" block:^(NSInteger index) {
//                        
//                    }];
//                }
//            }else{
//                [SLFHUD showHint:@"服务器返回错误，未获取到json对象"];
//            }
//        }else{
//            [SLFHUD showHint:@"服务器返回错误"];
//        }
//    }];
//    [task resume];
    
}
//余额支付
+ (void)apiForBalancePay:(YGBPayModel *)payModel block:(callDoneAndText)block {
    NSNumber * ygbcId;
    if (kStringIsEmpty(payModel.ygbcId)) {
        ygbcId = [NSNumber numberWithInteger:-1];
    }else {
        ygbcId = [NSNumber numberWithInteger:payModel.ygbcId.integerValue];
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:@{@"orderId" : payModel.orderid,
                                                                                @"userId" : [GVUserDefaults standardUserDefaults].ygbUserId,
                                                                                @"category" : [GVUserDefaults standardUserDefaults].typeYgOrJj?@"1":@"0",
                                                                                @"price" : payModel.price,
                                                                                @"type" : payModel.pulsType?@"1":@"0",
                                                                                @"ygbcId" : ygbcId.stringValue}];
    [RequestPost POST:kURL_BalancePay
           parameters:dic
              success:^(NSDictionary *response) {
                  BOOL error = ![response[@"error"] boolValue];
                  block(error, response[@"msg"]);
    } failure:^(NSError *error) {
        block(NO, [error localizedDescription]);
    }];
}



@end
