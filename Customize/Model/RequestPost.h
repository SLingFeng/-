//
//  RequestPost.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YGBUserModel;
@class YGBMyOrderModel;
@class YGBMyOrderDetailModel;
@class YGBMyPublishListModel;
@class YGBMyPublishDetailModel;
@class YGBAddreceiptModel;
@class YGBReceiptListModel;
@class YGBPayHostoryModel;
@class YGBMoneyHistoryModel;
@class YGBRankHistoryModel;
@class YGBCouponListModel;
@class YGBCertificateModel;
@class YGBCertificateDetailModel;
@class YGBFirstViewModel;
@class YGBDemandListModel;
@class YGBDemandDetailModel;
@class YGBAddygOrderModel;
@class YGBAddJjOrderModel;
@class YGBSencondViewModel;
@class YGBMyWalletModel;
@class YGBNoticeModel;
@class YGBFeedBackListModel;
@class YGBFeedBackDetailModel;
@class YGBAddevaluateListModel;
@class YGBAddevaluateModel;
@class YGBNoticeInfoModel;
@class YGBPerfertModel;
@class YGBFiterDemandModel;
@class YGBPayModel;

typedef void(^callBack)();

typedef void(^callDone)(BOOL done);

typedef void(^callDoneAndText)(BOOL done, NSString *text);

typedef void(^callDoneAndTextAndObj)(BOOL done, NSString *text, id obj);

@interface RequestPost : NSObject
/**
 * @author LingFeng, 2016-09-02 11:09:47
 *
 * 所有的请求，key是URLstring、value是task
 */
@property (strong, nonatomic) NSMutableDictionary * allTaskRequset;
/**
 * @author LingFeng, 2016-09-02 11:09:07
 *
 * 判断网络
 */
@property (copy, nonatomic) void(^networkStatus)(BOOL isGo);
/**
 * @author LingFeng, 2016-09-02 11:09:58
 *
 * 单例
 * @return 单例
 */
+(RequestPost *)shareTools;
/**
 网络请求类

 @return AFHTTPSessionManager
 */
+(AFHTTPSessionManager *)mySessionMageager;

/**
 GET请求

 @param URLString 接口
 @param parameters 字段
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary * response))success failure:(void (^)(NSError * error))failure;
/**
 POST请求

 @param URLString 接口
 @param parameters 字段
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POST:(NSString *)URLString parameters:(id) parameters success:(void (^)(NSDictionary * response))success failure:(void (^)(NSError * error))failure;
/**
 上传带图片

 @param URLString 接口
 @param parameters 字段
 @param block 图片回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POST:(NSString *)URLString parameters:(id) parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(NSDictionary * response))success failure:(void (^)(NSError * error))failure;

/**
 * @author LingFeng, 2016-08-26 09:08:37
 *
 * 网络变化时的回调方法
 * @param networkStatus 网络变化时 YES 有网络 NO 没网络
 */
+(void)checkNetwork:(void(^)(BOOL isGo))networkStatus;
#pragma mark - 更新app
/**
 * @author LingFeng, 2016-08-19 10:08:29
 *
 * 更新app
 * @param callBackData trackName （名称）trackViewUrl = （下载地址）version （可显示的版本号）
 */
//+(void)requestToUpdateApp:(void(^)(NSString *versionStr, NSString *releaseNotes, NSString *trackViewUrl))callBackData;

//+(void)uploadImage:(UIImage *)image block:(void(^)())callBackData;
//+(void)uploadImageS:(NSArray <UIImage *>*)imageArray block:(void(^)())callBackData;
//返回错误信息(void(^)(ResumeDetailsModel * rd, BOOL isOff))
//@property (copy, nonatomic) void(^callBackData)(ResumeDetailsModel * rd, BOOL isOff);



/**
 获取系统参数数据字典
 */
+ (void)apiForGetAppConfigSuccess:(void(^)(BOOL go))bolck;
/**
 1.1获取登录验证码
 
 @param phone 手机
 @param block 是否成功，信息
 */
+ (void)apiForSendLoginMessage:(NSString *)phone block:(callDoneAndText)block;
/**
 1.2用户登录

 @param phone 手机
 @param yzm 验证码
 @param block 是否成功，信息
 */
+ (void)apiForLoginCheck:(NSString *)phone yzm:(NSString *)yzm block:(callDoneAndText)block;
//1.3获取验证码
+ (void)apiForGetCodeMessage:(NSString *)phone block:(callDoneAndText)block;
//1.4校验验证码
+ (void)apiForGetCodeCheck:(NSString *)yzm block:(callDoneAndText)block;
#pragma mark - 一级页面
//2.1 一级页面数据
+ (void)apiForFirstViewWithblock:(void(^)(YGBFirstViewModel * model))block;
//2.2 首页数据
+ (void)apiForHomeView:(NSString *)type block:(void(^)(YGBSencondViewModel * model))block;
#pragma mark - 3.用工
/**
 3.1获取需求列表息（分页）

 @param type 用工类型 1 师傅 2家教
 @param searchText 搜索字段
 @param pageNumber 页数
 @param pageSize 大小
 @param block YGBDemandListModel
 */
+ (void)apiForGetDemandList:(NSString *)type searchText:(NSString *)searchText pageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBDemandListModel * demand))block;
/**
 3.1.1获取需求列表息（20条）

 @param type 用工类型 1 师傅 2家教
 @param city 城市代码
 @param block YGBDemandListModel
 */
+ (void)apiForGetDemandListLimit:(NSString *)type city:(NSString *)city block:(void(^)(YGBDemandListModel * demand))block;
/**
 3.2获取需求订单详情

 @param ygbdid 需求id
 @param type 用工类型 1 师傅 2家教
 @param block YGBDemandDetailModel
 */
+ (void)apiForGetDemandDetail:(NSString *)ygbdid type:(NSString *)type block:(void(^)(YGBDemandDetailModel * detail))block;
/**
 3.3 用工家教抢单

 @param ygbdid 需求id
 @param type 用工类型 1 师傅 2家教
 @param block 是否成功，信息
 */
+ (void)apiForJoborder:(NSString *)ygbdid type:(NSString *)type block:(callDoneAndTextAndObj)block;
/**
 3.4 填写用户信息（完善资料）跟5.15重用
 
 */
+ (void)apiForUpdateInfo:(YGBPerfertModel *)perfer logo:(UIImage *)logo appendfixz:(UIImage *)appendfixz appendfixf:(UIImage *)appendfixf appendfixh:(UIImage *)appendfixh muArray:(NSMutableArray *)array block:(callDoneAndText)block;
/**
 3.5取消订单

 @param orderid 订单id
 @param type 用工类型 1 师傅 2家教
 @param block 是否成功，信息
 */
+ (void)apiForCancelorder:(NSString *)orderid type:(NSString *)type block:(callDoneAndText)block;
//3.5.1取消需求单
+ (void)apiForCanceldemand:(NSString *)orderid type:(NSString *)type block:(callDoneAndText)block;
/**
 3.6开始施工/家教

 @param orderid 订单id
 @param type 用工类型 1 师傅 2家教
 @param block 是否成功，信息
 */
+ (void)apiForStartorder:(NSString *)orderid type:(NSString *)type block:(callDoneAndText)block;
/**
 3.6.1施工/家教完成

 @param orderid 订单id
 @param type 用工类型 1师傅 2家教
 @param block 是否成功，信息
 */
+ (void)apiForFinishorder:(NSString *)orderid type:(NSString *)type block:(callDoneAndText)block;
/**
 3.7 新增用工需求订单

 @param order YGBAddygOrderModel 赋值属性
 @param block 是否成功，信息
 */
+ (void)apiForAddygOrder:(YGBAddygOrderModel *)order block:(callDoneAndTextAndObj)block;
/**
 3.8订单确认付款
 
 @param orderid 订单id
 @param type 用工类型 1师傅 2家教
 @param block 是否成功，信息
 */
+ (void)apiForPayhOrder:(NSString *)orderid type:(NSString *)type block:(callDoneAndText)block;

/**
 3.9 新增家教需求订单

 @param order YGBAddJjOrderModel 赋值属性
 @param block 是否成功，信息
 */
+ (void)apiForAddjjorder:(YGBAddJjOrderModel *)order block:(callDoneAndTextAndObj)block;

+ (void)apiForGetDemandList2:(YGBFiterDemandModel *)model block:(void(^)(YGBDemandListModel * list))block;
#pragma mark - 我的
/**
 5.1.获取个人信息

 @param block YGBUserModel
 */
+ (void)apiForGetInfo:(void(^)(YGBUserModel * user))block;

+ (void)apiForGetInfo:(NSString *)otherID block:(void(^)(YGBUserModel * user))block;
/**
 5.2.我的订单

 @param type 用工类型 1 师傅 2家教
 @param ygbotype 订单状态：0 进行中 1 已完成 2 已取消 空字符串：全部
 @param pageNumber 页数
 @param pageSize 大小
 @param block YGBMyOrderModel
 */
+ (void)apiForGetmyorder:(NSString *)type ygbotype:(NSString *)ygbotype pageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBMyOrderModel * order))block;
/**
 5.3 订单详情

 @param type 用工类型 1 师傅 2家教
 @param block YGBMyOrderDetailModel
 */
+ (void)apiForGetmyorderDetail:(NSString *)type WithYgboid:(NSString *)ygboid block:(void(^)(YGBMyOrderDetailModel * detail))block;
/**
 5.4 我的发布

 @param type 用工类型 1 师傅 2家教
 @param ygbotype 订单状态：0进行中 1已完成 2已取消 空字符串 全部
 @param ygbdauditing 审核状态 0未审核 1审核通过 2审核未通过
 @param pageNumber 页数
 @param pageSize 大小
 @param block YGBMyPublishListModel
 */
+ (void)apiForGetpublishList:(NSString *)type ygbotype:(NSString *)ygbotype ygbdauditing:(NSString *)ygbdauditing ygbdstate:(NSString *)ygbdstate pageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBMyPublishListModel * list))block;
/**
 5.5 发布详情

 @param ygbdid 需求id
 @param type 用工类型 1师傅 2家教
 @param block YGBMyPublishDetailModel
 */
+ (void)apiForGetmypublishDetail:(NSString *)ygbdid type:(NSString *)type block:(void(^)(YGBMyPublishDetailModel * detail))block;
/**
 5.6开票

 @param addrecipt 具体请看YGBAddreceiptModel
 @param block 是否成功，信息
 */
+ (void)apiForAddreceipt:(YGBAddreceiptModel *)addrecipt andOrderId:(NSString *)orderid block:(callDoneAndText)block;
/**
 5.7发票信息列表

 @param pageNumber 页数
 @param pageSize 大小
 @param block YGBReceiptListModel
 */
+ (void)apiForGetreceiptlistPageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBReceiptListModel *receiptList))block;
/**
 我的钱包

 @param block 是否成功，金额
 */
+ (void)apiForGetmymoneyBlock:(void(^)(YGBMyWalletModel *wall))block;
/**
 5.9我的钱包-交易记录

 @param block YGBPayHostoryModel
 */
+ (void)apiForGetpayhostoryNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize Block:(void(^)(YGBPayHostoryModel * pay))block;
/**
 5.10绑定银行卡

 @param bankno 银行卡号
 @param block 是否成功，信息
 */
+ (void)apiForBindBandCard:(NSString *)bankno ygbmbank:(NSString *)ygbmbank ygbmbankarea:(NSString *)ygbmbankarea ygbmbankname:(NSString *)ygbmbankname ygbmbanktel:(NSString *)ygbmbanktel  block:(void(^)(YGBMyWalletModel *wall))block;
/**
 5.11 提现

 @param bankno 银行卡号
 @param amount 金额
 @param block 是否成功，信息
 */
+ (void)apiForGetBankMoney:(NSString *)bankno amount:(NSString *)amount block:(void(^)(YGBMyWalletModel *wall))block;
//5.10 提现完成
+ (void)apiForgetBankMoneyFinish:(NSString *)bankno amount:(NSString *)amount ygbchargeamount:(NSString *)ygbchargeamount block:(callDoneAndText)block;
/**
 5.12 提现记录

 @param block YGBMoneyHistoryModel
 */
+ (void)apiForGetMoneyHistoryBlock:(void(^)(YGBMoneyHistoryModel *history))block;
/**
 5.13 评价记录

 @param block YGBRankHistoryModel
 */
+ (void)apiForgetRankHistoryBlock:(void(^)(YGBRankHistoryModel *rank))block;
/**
 5.14我的优惠券

 @param state 状态 1:可用 2:已过期 3：已使用
 @param block YGBCouponListModel
 */
+ (void)apiForGetcouponlist:(NSString *)state number:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBCouponListModel * coupon))block;
/**
 5.15修改个人信息

 @param ygbmname 姓名
 @param ygbmsex 性别：1:男 0:女
 @param ygbmaddress 地址
 @param ygbmtel 手机号
 @param ygbmpin 身份证号
 @param utype 1修改资料 2证书
 @param block 是否成功，信息
 */
+ (void)apiForUpdateInfo:(UIImage *)logo ygbmsex:(NSString *)ygbmsex ygbmaddress:(NSString *)ygbmaddress ygbmtel:(NSString *)ygbmtel ygbdarea:(NSString *)ygbdarea block:(callDoneAndText)block;
/**
 5.16 修改头像

 @param image 头像Iamge
 @param block 是否成功，信息
 */
+ (void)apiForUpdateImage:(UIImage *)image block:(callDoneAndText)block;
/**
 5.17上传身份证

 @param zengImage 正面
 @param fanImage 反面
 @param shouImage 手持
 @param block 是否成功，信息
 */
+ (void)apiForUpdateidcardWithZeng:(UIImage *)zengImage fanImage:(UIImage *)fanImage shouImage:(UIImage *)shouImage block:(callDoneAndText)block;
/**
 5.18 上传证书

 @param appendfix 证书图片
 @param type 证书类型 1：业主 2：师傅 3：家长 4家教
 @param block 是否成功，信息
 */
+ (void)apiForUpdatecertificate:(UIImage *)appendfix type:(NSString *)type block:(callDoneAndText)block;
/**
 5.19修改支付密码

 @param phone 用户手机号
 @param pw 支付密码
 @param type=0 更新支付密码 ，type=1验证密码
 @param block 是否成功，信息
 */
+ (void)apiForUpdatepaypwWithPhone:(NSString *)phone pw:(NSString *)pw type:(NSString *)type block:(callDoneAndText)block;
/**
 5.20我的认证

 @param block YGBCertificateModel
 */
+ (void)apiForGetcertificateListBlock:(void(^)(YGBCertificateModel * cer))block;
/**
 5.21 认证详情

 @param ygbmcid 证书id
 @param block YGBCertificateDetailModel
 */
+ (void)apiForGetcertificateDetail:(NSString *)ygbmcid block:(void(^)(YGBCertificateDetailModel * cdm))block;
#pragma mark - 消息
/**
 6.1 系统消息

 @param block YGBNoticeModel
 */
+ (void)apiForGetSystemNoticeBlock:(void(^)(YGBNoticeModel * notic))block;
/**
 6.2系统消息详情

 @param noticeID 消息主键
 @param block YGBNoticeInfoModel
 */
+ (void)apiForGetDetailNotice:(NSString *)noticeID block:(void(^)(YGBNoticeInfoModel * notInfo))block;
#pragma mark - 7.反馈
/**
 7.1 添加用户反馈信息

 @param contentText 内容
 @param block 是否成功，信息
 */
+ (void)apiForAddfeedback:(NSString *)contentText block:(callDoneAndText)block;
/**
 7.2 查看反馈列表

 @param block 是否成功，信息
 */
+ (void)apiForGetfeedbacklistBlock:(void(^)(YGBFeedBackListModel * list))block;
/**
 7.3 查看系统反馈详情

 @param ygbmsid 反馈主键
 @param block YGBFeedBackDetailModel
 */
+ (void)apiForGetfeedbackdetail:(NSString *)ygbmsid block:(void(^)(YGBFeedBackDetailModel * detail))block;
#pragma mark - 8.评价
/**
 8.1添加评价

 @param evaList 需要填写的 YGBAddevaluateListModel
 @param block 是否成功，信息
 */
+ (void)apiForAddevaluate:(YGBAddevaluateListModel *)evaList block:(callDoneAndText)block;
/**
 8.2查看评价列表

 @param ygbdid 需求ID
 @param block YGBAddevaluateModel
 */
+ (void)apiForGetevaluatelistType:(NSString *)type objecttype:(NSString *)objecttype pageNumber:(NSString *)pageNumber pageSize:(NSString *)pageSize block:(void(^)(YGBAddevaluateModel * eval))block;

/**
 9.1 应用简介

 @param block 是否成功，信息
 */
+ (void)apiForGetAppIntroduceblock:(callDoneAndText)block;
//支付宝
+ (void)apiForAliPay:(YGBPayModel *)sign block:(callDoneAndText)block;
/**
 微信支付
 
 @param orderId 订单id
 @param category 类型 0：师傅 1：家教
 @param type  付款类型：0 加价 1需求
 */
+ (void)apiForWXPay:(NSString *)orderId category:(NSString *)category type:(NSString *)type ygbcId:(NSString *)ygbcId price:(NSString *)price;
/**
 余额支付

 @param orderId 订单id
 @param price 加价价格/需求订单价格
 @param type 0 加价付款 1发布需求付款
 @param block 是否成功，信息
 */
+ (void)apiForBalancePay:(YGBPayModel *)payModel block:(callDoneAndText)block;
@end
