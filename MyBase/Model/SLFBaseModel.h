//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <JSONModel/JSONModel.h>

//因为方法名 shared"ClassName"是连在一起的，为了让宏能够正确替换掉签名中的“ClassName”需要在前面加上 ##
//当宏的定义超过一行时，在末尾加上“\”表示下一行也在宏定义范围内。注意最后一行不需要加"\”。

//使用方法：(单利配合模型使用很方便)
//在.h里面(//公开的访问单利对象的方法singleton_interface(MyModel))
//在.m里面(singleton_implementation(MyModel))
#define singleton_Interface(class)  +(class *)shareclass;

#define singleton_implemetntion(class)\
static class * instance = nil;\
+(class *)shareclass\
{\
if (!instance) {\
instance = [[class alloc]init];\
}\
return instance;\
}\
+(class *)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onece;\
dispatch_once(&onece, ^{\
instance = [super allocWithZone:zone];\
});\
return instance;\
}

@interface SLFBaseModel : JSONModel
/**
 状态码 0：正常请求 1：token 错误，2：会话过期 3非法请求
 */
@property (nonatomic, assign) NSInteger code;
/**
 原因,类型:字符串
 */
@property (nonatomic, copy) NSString * msg;
/**
 验证结果,字符串 1:操作成功，0:操作失败
 */
@property (nonatomic, assign) BOOL success;
//@property (nonatomic, assign) BOOL result;

/**

 
 @return <#return value description#>
 */
+ (NSString *)getPaht;
@end
