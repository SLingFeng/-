//
//  GVUserDefaults+SLFUserInfo.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "GVUserDefaults+SLFUserInfo.h"


@implementation GVUserDefaults (SLFUserInfo)
@dynamic ygbUserName;
@dynamic ygbUserNickName;
@dynamic ygbUserId;
@dynamic ygbUserPhone;
@dynamic ygbUserType;
@dynamic ygbUserToken;
@dynamic ygbmcard;
@dynamic ygbUserSex;
@dynamic ygbUserLogo;
@dynamic ygbUserAddress;
@dynamic ygbUserPin;
@dynamic selectTag;
@dynamic cityId;
@dynamic grade;
@dynamic ygbdarea;
@dynamic ygissetpw;
@dynamic ygbmhand;
@dynamic ygbmfront;
@dynamic ygbmcon;
@dynamic ygbstar;
@dynamic ygborder;
@dynamic ygbmpin;
@dynamic currentState;
@dynamic download;
@dynamic chatList;


-(NSInteger)isUserType {
    if ([self.ygbUserType isEqualToString:kMaster]) {
        return 1;
    }else if ([self.ygbUserType isEqualToString:kOwner]) {
        return 2;
    }else if ([self.ygbUserType isEqualToString:kTeacher]) {
        return 3;
    }else if ([self.ygbUserType isEqualToString:kParents]) {
        return 4;
    }else {
        return -1;
    }
}

- (BOOL)typeYgOrJj {
    if ([self.ygbUserType isEqualToString:kMaster]) {
        return NO;
    }else if ([self.ygbUserType isEqualToString:kOwner]) {
        return NO;
    }else if ([self.ygbUserType isEqualToString:kTeacher]) {
        return YES;
    }else if ([self.ygbUserType isEqualToString:kParents]) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)typeGrabSingle {
    if ([self.ygbUserType isEqualToString:kMaster]) {
        return YES;
    }else if ([self.ygbUserType isEqualToString:kOwner]) {
        return NO;
    }else if ([self.ygbUserType isEqualToString:kTeacher]) {
        return YES;
    }else if ([self.ygbUserType isEqualToString:kParents]) {
        return NO;
    }else {
        return NO;
    }
}

- (BOOL)isLogin {
    if (self.ygbUserToken == nil || [self.ygbUserToken isEqualToString:@""] || self.ygbUserId == nil || [self.ygbUserId isEqualToString:@""]) {
        return NO;
    }else {
        return YES;
    }
}

-(void)removeUserInfo {
    self.ygbUserName = nil;
    self.ygbUserNickName = nil;
    self.ygbUserId = nil;
    self.ygbUserType = @"";
    self.ygbUserPhone = nil;
    self.ygbmcard = nil;
    self.ygbUserLogo = nil;
    self.ygbUserSex = nil;
    self.ygbUserAddress = nil;
    self.ygbUserPin = nil;
    self.selectTag = 1;
    self.ygbUserToken = nil;
    self.cityId = nil;
    self.ygbdarea = nil;
    self.ygissetpw = nil;
    self.ygbmhand = nil;
    self.ygbmfront = nil;
    self.ygbmcon = nil;
    self.ygbstar = nil;
    self.ygborder = nil;
}



@end

@implementation NSString (Base64)

- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end

@implementation NSString (MD5)

+ (NSString *)MD5:(NSString*)message isUp:(BOOL)isUp{
    const char *cStr = [message UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, (unsigned)strlen(cStr), result);
    NSString * temp =[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      
                      result[4], result[5], result[6], result[7],
                      
                      result[8], result[9], result[10], result[11],
                      
                      result[12], result[13], result[14], result[15]];
    if (isUp) {
        return [temp uppercaseString];
    }else{
        return [temp lowercaseString];
    }
}


@end

