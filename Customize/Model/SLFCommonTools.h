//
//  SLFCommonTools.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kMainColor @"ff0000"

@interface SLFCommonTools : NSObject

+(SLFCommonTools *)shareTools;
/**
 *  @author LingFeng, 2016-06-08 11:06:07
 *
 *  设置tabbar
 */
+(void)setupTabbarViewControllers:(UIWindow *)window;
/**
 查找当前vc
 
 @return vc
 */
+(UIViewController*)currentViewController;


+ (BOOL)isFontDownloaded:(NSString *)fontName;
/**
 *  @author LingFeng, 2016-06-08 11:06:15
 *
 *  判断用户是否存在
 *
 *  @return yes存在 no不存在
 */
+(BOOL)isUserData;
/**
 *  @author LingFeng, 2016-06-08 11:06:04
 *
 *  根据宽度获取label文字 高度
 *
 *  @param text     文字
 *  @param fontSize 字体大小
 *  @param width   根据高宽度
 *
 *  @return 高度
 */
+(CGFloat)textHight:(NSString *)text font:(CGFloat)fontSize width:(CGFloat)width;
+(CGSize)textSize:(NSString *)text font:(UIFont *)font;
///对比版本号
+(BOOL)isCurrentVersionChange;
#pragma mark - 生成不重复随机数
+(NSArray *)getUniqueRandomNumberGeneration:(NSInteger)count;
#pragma mark - 颜色
/**
 *  @author LingFeng, 2016-06-08 11:06:46
 *
 *  标题颜色
 *
 *  @return 颜色
 */
+(UIColor *)getTitleColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:02
 *
 *  次级标题颜色
 *
 *  @return 颜色
 */
+(UIColor *)getSecondaryTitleColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:12
 *
 *  正文顏色
 *
 *  @return 顏色
 */
+(UIColor *)getTextLightColor;
/**
 *  @author LingFeng, 2016-06-13 14:06:19
 *
 *  文本高亮颜色
 *
 *  @return 文本高亮颜色
 */
+(UIColor *)getTextHColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:22
 *
 *  导航颜色
 *
 *  @return 导航颜色
 */
+(UIColor *)getNavBarColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:36
 *
 *  导航字体颜色
 *
 *  @return 导航字体颜色
 */
+(UIColor *)getNavTintTextColor;
/**
 * @author LingFeng, 2016-06-24 09:06:29
 *
 * 正常字体颜色
 *
 * @return 正常字体颜色 51 33
 */
+(UIColor *)getFont33Color;
/**
 * @author LingFeng, 2016-06-24 09:06:54
 *
 * 字体颜色
 *
 * @return 字体颜色 102 66
 */
+(UIColor *)getFont66Color;
/**
 * @author LingFeng, 2016-06-24 09:06:07
 *
 * 字体颜色
 *
 * @return 字体颜色 153 99
 */
+(UIColor *)getFont99Color;
/**
 主题颜色

 @return 主题颜色
 */
+(UIColor *)getMainColor;

/**
 *  @author LingFeng, 2016-06-08 17:06:32
 *
 *  背景颜色
 *
 *  @return 背景颜色
 */
+(UIColor *)getBackgroundColor;

+(UIColor *)getBackgroundDarkColor;

+(UIColor *)getBackgroundLightColor;

//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *)colorHex:(NSString *)color;
+ (UIColor *)colorHex:(NSString *)color alpha:(CGFloat)alpha;
#pragma mark - tableViewCell下面的线位置
+(void)tableCellSeparator:(UITableView *)table left:(CGFloat)left right:(CGFloat)right;
#pragma mark - 画线
/**
 * @author LingFeng, 2016-07-04 14:07:08
 *
 * 画一条横向线
 * @param hight 线对于y的高度
 * @param space 线对于左右的空间
 */
+(void)drawLineToHight:(float)hight spaceForRightAndLetf:(float)space;
/**
 * @author LingFeng, 2016-07-29 10:07:46
 *
 * 画一条横向虚线
 * @param hight 线对于y的高度
 * @param space 线对于左右的空间
 */
+(void)drawDashLineToHight:(float)hight spaceForRightAndLetf:(float)space;

/**
 * @author LingFeng, 2016-10-12 14:07:46
 *
 * 画一条I向
 * @param X 对于X位置
 * @param topSpace 线初始位置
 * @param bottomSpace 线终点位置
 */
+(void)drawLineToX:(float)X topSpace:(float)topSpace bottomSpace:(float)bottomSpace;

+(void)drawLineToY:(CGFloat)y spaceForRightAndLetf:(CGFloat)space color:(UIColor *)color lineW:(CGFloat)lineW;

+(UIView *)lineViewToHight:(float)hight spaceForRightAndLetf:(float)space;

+ (void)line:(UIView *)view y:(CGFloat)y color:(NSString *)color;

+(void)line:(UIView *)view y:(CGFloat)y space:(CGFloat)space color:(NSString *)color;

+(void)line:(UIView *)view y:(CGFloat)y space:(CGFloat)space color:(NSString *)color lineW:(CGFloat)lineW;
/**
 画一条 一 线

 @param view 需要的话的view
 @param y 距离
 @param leftSpace 左边的开始点
 @param rightSpace 右边的结束点
 @param color 线颜色
 @param lineW 线宽
 */
+(void)line:(UIView *)view y:(CGFloat)y leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace color:(NSString *)color lineW:(CGFloat)lineW;

+(void)lineDash:(UIView *)view hight:(CGFloat)hight x:(CGFloat)x y:(CGFloat)y color:(NSString *)color lineW:(CGFloat)lineW;
//虚线
+(void)dottedLine:(UIView *)view y:(CGFloat)y leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace color:(NSString *)color lineW:(CGFloat)lineW;
#pragma mark - 清除缓存
+(NSString *)clearMsg;
+(void)clearAll:(UIViewController *)vc;
#pragma mark - 判断 转换
/**
 判断是text否空

 @param text 需要判断的text
 @return yes空
 */
+(BOOL)kongGe:(NSString *)text;
//性别
+(NSString *)Gender:(NSString *)sex;
//时间显示
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;
///时间戳转换
+(NSString *)timestamp:(NSString *)timeStr;
#pragma mark - 用户信息
+(void)setUserInfo:(int)idd name:(NSString *)name;
/**
 *  @author LingFeng, 2016-06-08 11:06:46
 *
 *  根据本地存放pls文件获取用户名
 *
 *  @return 用户名
 */
+(NSString *)getUserName;
/**
 *  @author LingFeng, 2016-06-12 16:06:22
 *
 *  根据本地存放pls文件获取用户id
 *
 *  @return 用户id
 */
+(NSString *)getUserID;
/**
 设置本地USER字典

 @param key <#key description#>
 @param value <#value description#>
 */
+(void)setUserKey:(NSString *)key value:(NSString *)value;
/**
 移除本地USER 字典里面的

 @param key <#key description#>
 */
+(void)removeUserKey:(NSString *)key;
+(NSString *)getUserKey:(NSString *)key;
#pragma mark - 其他
/**
 * @author LingFeng, 2016-06-23 16:06:36
 *
 * 去掉返回按钮文字
 *
 * @param bai 去掉返回按钮文字 白色返回Yes
 */
+(void)setupNavBackBtn:(BOOL)bai;
/**
 * @author LingFeng, 2016-07-25 10:07:40
 *
 * 设置状态导航条颜色
 * @param weak vc
 * @param bai <#bai description#>
 */
+(void)setupSatuts:(UIViewController *)weak bai:(BOOL)bai;
/**
 * @author LingFeng, 2016-06-24 09:06:34
 *
 * 设置分享按钮
 *
 * @param weakSelf 当前视图控制器->设置分享按钮
 * @param state 判断是否左边还是右边 YES为左边
 * @param img 传入图片
 * @param title 传入文本
 */
- (void)setupNavRightAndLeftBtn:(UIViewController *)weakSelf leftOrRight:(BOOL)state imageName:(NSString*)img titleName:(NSString*)title setWidth:(NSInteger)width;
/**
 * @author LingFeng, 2016-06-24 09:06:34
 *
 * 设置分享按钮
 *
 * @param weakSelf 当前视图控制器->设置分享按钮
 * @param bai 去掉返回按钮文字 白色返回Yes
 */
-(void)setupNavRightShareBtn:(UIViewController *)weakSelf bai:(BOOL)bai;
/**
 * @author LingFeng, 2016-06-24 09:06:02
 *
 * 分享点击方法
 */
@property (copy, nonatomic) void(^NavRightShareBtnClick)();
/**
 * @author LingFeng, 2016-06-30 09:06:07
 *
 * alert的确定点击方法
 */
@property (copy, nonatomic) void (^alertClick)();
/**
 * @author LingFeng, 2016-07-14 17:07:23
 *
 * 警告框
 * @param weakSelf 当前视图控制器->设置警告框
 * @param title 标题
 * @param text 文字内容
 * @param cancel 是否显示取消按钮 Yes显示 no不显示
 */
+(void)showAlertViewTo:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text cancel:(BOOL)cancel;
#pragma mark - 自适应宽高
+(CGFloat)adaptiveWidth:(CGFloat)width;
+(CGFloat)adaptiveHeight:(CGFloat)height;
#pragma mark - 比例
/**
 4：3高度
 
 @param width 宽
 @return 计算后的4：3高度
 */
+(CGFloat)heightScale4_3:(CGFloat)width;
/**
 4：3宽度

 @param height 高度
 @return 计算后的4：3宽度
 */
+(CGFloat)widthScale4_3:(CGFloat)height;
#pragma mark - 转换 字体
/**
 把px大小 转换成系统字体大小

 @param size px尺寸
 @return 系统尺寸
 */
+(UIFont *)pxFont:(CGFloat)size;
/**
 把px大小 转换成系统字体大小（粗体）

 @param size px尺寸
 @return 系统尺寸
 */
+(UIFont *)pxBoldFont:(CGFloat)size;

/**
 int转字符串

 @param intt int nsintger
 @return 字符串
 */
+(NSString *)strToInt:(NSInteger)intt;

/**
 浮点转字符串

 @param floatt float
 @return 字符串
 */
+(NSString *)strToFloat:(CGFloat)floatt;

/**
 隐藏手机号码

 @param phone 号码
 @return phone
 */
+(NSMutableString *)hiddenPhone:(NSString *)phone;
#pragma mark - 字体大小
/**
 *  @author LingFeng, 2016-06-08 11:06:54
 *
 *  设置输入框字体大小
 *
 *  @return 字体大小
 */
+(UIFont *)getTextFieldFontSize;
/**
 *  @author LingFeng, 2016-06-13 09:06:57
 *
 *  文本字体大小
 *
 *  @return 文本字体大小
 */
+(UIFont *)getTextFontSize;
/**
 *  @author LingFeng, 2016-06-13 09:06:39
 *
 *  大 文本字体大小
 *
 *  @return 大 文本字体大小
 */
+(UIFont *)getTextBigFontSize;
#pragma mark - 判断
/**
 *  @author LingFeng, 2016-06-12 10:06:05
 *
 *  获取时间间隔
 *
 *  @param date 创建的时间 格式：yyyy-MM-dd HH:mm
 *
 *  @return 时间间隔
 */
+(NSString *)getTimeIntervalIsCreateTime:(NSString *)date;

#pragma mark - 时间
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
///计算2天 天数
+(NSString *)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate;
/**
 当前时间

 @return 2017-02-10
 */
+(NSString *)getYearMonthDay;
/**
 当前时间

 @return 2017-02
 */
+(NSString *)getYearMonth;
#pragma mark - 检查上一次更新时间
/**
 * @author LingFeng, 2016-09-09 09:09:47
 *
 * 检查上一次更新时间
 * @return 如果本地没有'值'返回->2 有->返回天数
 */
+(NSInteger)checkLastTimeUpApp;


/**
 *  @author LingFeng, 2016-06-08 11:06:21
 *
 *  判断邮箱
 *
 *  @param email 用户输入的邮箱
 *
 *  @return yes是邮箱 no不是邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email;
/**
 *  @author LingFeng, 2016-06-08 11:06:08
 *
 *  判断电话号码
 *
 *  @param mobileNum 用户输入的电话号码
 *
 *  @return yes是电话号码 no不是电话号码
 */
+(BOOL)isMobileNumber:(NSString *)mobileNum;
/**
 *  @author LingFeng, 2016-06-08 11:06:22
 *
 *  判断密码是否符合
 *
 *  @param passWord 密码6-16 数字英文
 *
 *  @return yes符合 no不符合
 */
+ (BOOL)isValidatePassword:(NSString *)passWord;
/**
 * @author LingFeng, 2016-08-11 11:08:53
 *
 * 提示用户名
 * @param text 用户名
 * @return 提示用户名
 */
+(NSString *)isUserTiShi:(NSString *)text;

+(NSString *)isUserCode:(NSString *)text;
/**
 * @author LingFeng, 2016-08-11 11:08:22
 *
 * 提示密码
 * @param text 密码
 * @return 提示密码
 */
+(NSString *)isUserPasswordTiShi:(NSString *)text;
/**
 * @author LingFeng, 2016-08-11 11:08:26
 *
 * 提示 2次密码比对
 * @param lastText 第2个密码
 * @param firstText 第一个密码
 * @return 提示 2次密码比对
 */
+(NSString *)isUserPasswordAgainTiShiLast:(NSString *)lastText first:(NSString *)firstText;
//身份证
+ (BOOL) IsIdentityCard:(NSString *)IDCardNumber;
//银行卡
+ (BOOL) IsBankCard:(NSString *)cardNumber;
//中文
+ (BOOL)matchStringFormat:(NSString *)str;
//数字
+ (BOOL)matchStringNumber:(NSString *)str;
//数字 中文
+ (BOOL)matchStringNumberAndCN:(NSString *)str;
//数字 字母
+ (BOOL)matchStringNumberAndEN:(NSString *)str;
@end


