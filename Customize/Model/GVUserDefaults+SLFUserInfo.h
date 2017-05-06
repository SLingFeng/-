//
//  GVUserDefaults+SLFUserInfo.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "GVUserDefaults.h"
#import <CommonCrypto/CommonDigest.h>

//师傅
#define kMaster @"master"
//业主
#define kOwner @"owner"
//老师
#define kTeacher @"teacher"
//家长
#define kParents @"parents"

@interface GVUserDefaults (SLFUserInfo)
@property (nonatomic, copy) NSString *ygbUserName;
@property (nonatomic, copy) NSString *ygbUserNickName;
@property (nonatomic, copy) NSString *ygbUserId;
@property (nonatomic, copy) NSString *ygbUserType;
@property (nonatomic, copy) NSString *ygbUserPhone;
@property (nonatomic, copy) NSString *ygbUserToken;
@property (nonatomic, copy) NSString *ygbmcard;
@property (nonatomic, copy) NSString *ygbUserSex;
@property (nonatomic, copy) NSString *ygbUserLogo;
@property (nonatomic, copy) NSString *ygbUserAddress;
@property (nonatomic, copy) NSString *ygbUserPin;
@property (nonatomic, assign) NSInteger selectTag;
@property (nonatomic, copy) NSString * cityId;
@property (nonatomic, copy) NSString *grade;
//省市区
@property (nonatomic, copy) NSString *ygbdarea;
//是否设置支付密码  0:否 1:是
@property (nonatomic, copy) NSString *ygissetpw;
//手持身份证
@property (nonatomic,copy) NSString *ygbmhand;
//正面身份证
@property (nonatomic,copy) NSString *ygbmfront;
//反面身份证
@property (nonatomic,copy) NSString *ygbmcon;

@property (nonatomic,copy) NSString *ygbstar;

@property (nonatomic,copy) NSString *ygborder;
//身份证
@property (nonatomic,copy) NSString *ygbmpin;


/**
 发布需求是 1业主 2家长
 */
@property (nonatomic, copy) NSString *currentState;
/**
 是否下载
 */
@property (nonatomic, assign) BOOL download;
/**
 用户是否登录 YES登录了/NO没登录
 */
- (BOOL)isLogin;
/**
 判断当前用户类别

 @return 师傅:1/业主:2/老师:3/家长:4/ -1未知
 */
- (NSInteger)isUserType;
//NO用工 YES家教
- (BOOL)typeYgOrJj;
//NO不可以抢单 YES可以抢单
- (BOOL)typeGrabSingle;
/**
 移除用户信息
 */
- (void)removeUserInfo;

@property (nonatomic, retain) NSMutableDictionary *chatList;
@end

@interface NSString (Base64)
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;
@end

@interface NSString (MD5)
+ (NSString *)MD5:(NSString*)message isUp:(BOOL)isUp;
@end
