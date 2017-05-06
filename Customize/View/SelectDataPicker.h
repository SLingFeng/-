//
//  SelectDataPicker.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YGBAddressTreeShengModel;
@class YGBAddressTreeShiModel;
@class YGBAddressTreeQuModel;
@class YGBDatadictionaryModel;
@class YGBGzdjlistModel;
@class YGBKmlistModel;
@class YGBKmlistSubjectModel;

typedef enum : NSUInteger {
    SeleCtTypeYearMonthDay,
    SeleCtTypeYearMonth,
    SeleCtTypePercentage,
    SeleCtTypeMoney,
    SeleCtTypeName,//名字
    SeleCtTypeAdder,//地址
    SeleCtTypeClassTime,//上课时长
    SeleCtTypeEdu,//学历
    SeleCtTypeSex,//性别
    SeleCtTypeKm,//公里
    SeleCtTypeTime,//时间
    SeleCtTypeKeMu,//科目
    SeleCtTypeGrade,//年级
    SeleCtTypeGongZhong,//工种
    SeleCtTypePlusMoney,//加价金额
    SeleCtTypeGYear,//工龄
} SeleCtType;


@interface SelectDataPicker : UIView
@property (nonatomic, retain) NSMutableArray<NSString *> * NameDataArr;
@property (nonatomic, copy) NSMutableString * timeDate;
@property (nonatomic, copy) void (^backTimeDate)(NSString*, NSDate *,NSInteger);
@property (nonatomic, copy) void (^backDataDate)(YGBDatadictionaryModel *);
/**
 地址 回调
 */
@property (nonatomic, copy) void (^backAdder)(YGBAddressTreeShengModel*, YGBAddressTreeShiModel *,YGBAddressTreeQuModel *);
/**
 上课时长 学历 性别 公里数 回调
 */
@property (nonatomic, copy) void (^backDataDicModel)(YGBDatadictionaryModel *);
/**
 工种回调
 */
@property (nonatomic, copy) void (^backGongZhong)(YGBGzdjlistModel *);
/**
 年级
 */
@property (nonatomic, copy) void (^backGrade)(YGBKmlistModel *);
/**
 科目回调
 */
@property (nonatomic, copy) void (^backKeMu)(YGBKmlistSubjectModel *);
-(instancetype)initWithType:(SeleCtType)type;
@end
