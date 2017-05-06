//
//  BaseTextField.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BaseTextFieldEnterAll,
    BaseTextFieldEnterNumber,
    BaseTextFieldEnterCNEN,
    BaseTextFieldEnterNumberAndCN,
    BaseTextFieldEnterNumberAndEN,
} BaseTextFieldEnterType;

@interface BaseTextField : UITextField

/**
 输入的字符数量
 */
@property (assign, nonatomic) NSInteger enterNumber;

@property (assign, nonatomic) BaseTextFieldEnterType enterType;
/**
 输入改变时
 */
//@property (copy, nonatomic) void(^textFieldChange)(NSString *);

@property (copy, nonatomic) void(^textFieldBegin)();

@property (nonatomic, copy) void(^returnKeyClick)(BaseTextField *tf);

@property (nonatomic, copy) void(^textFieldChange)(BaseTextField *tf);
//@property (nonatomic, copy) void(^textFieldEditingDidEnd)(BaseTextField *tf);
@end
