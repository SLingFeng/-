//
//  BaseTextField.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "BaseTextField.h"

@interface BaseTextField ()<UITextFieldDelegate>

@end

@implementation BaseTextField

-(void)awakeFromNib {
    [super awakeFromNib];
    [self set];
}

-(instancetype)init {
    if (self = [super init]) {
        [self set];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self set];
    }
    return self;
}

-(void)set {
    self.enterType = BaseTextFieldEnterAll;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.delegate = self;
    [self addTarget:self action:@selector(returnKeyClick:) forControlEvents:(UIControlEventEditingDidEndOnExit)];
    [self addTarget:self action:@selector(begin) forControlEvents:(UIControlEventEditingDidBegin)];
    [self addTarget:self action:@selector(TextFieldChange:) forControlEvents:(UIControlEventEditingChanged)];
//    [self addTarget:self action:@selector(TextFieldChange:) forControlEvents:(UIControlEventAllEditingEvents)];

//    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:(UIControlEventEditingDidEnd)];
//    self addTarget:self action:@selector(shouldRrturnKeyClick:) forControlEvents:(UIControlEvent)
}

//- (void)editingDidEnd {
//    if (self.textFieldEditingDidEnd) {
//        self.textFieldEditingDidEnd(self);
//    }
//}

- (void)begin {
    if (self.textFieldBegin) {
        self.textFieldBegin();
    }
}

-(void)returnKeyClick:(BaseTextField *)tf {
    if (self.returnKeyClick) {
        self.returnKeyClick(tf);
    }
}

-(void)setEnterNumber:(NSInteger)enterNumber {
    if (_enterNumber != enterNumber) {
        _enterNumber = enterNumber;
    }
}

-(void)TextFieldChange:(BaseTextField *)textField {
    if (textField == self) {
        
        if (self.enterNumber != 0) {
            NSString *aString = textField.text;
            UITextRange *selectedRange = [textField markedTextRange];
            // 獲取被選取的文字區域（在打注音時，還沒選字以前注音會被選起來）
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            // 沒有被選取的字才限制文字的輸入字數
            if (!position) {
                if (aString.length > _enterNumber) {
                    textField.text = [aString substringToIndex:_enterNumber];
                }
            }
            
        }
        if (self.textFieldChange) {
            self.textFieldChange(self);
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    switch (self.enterType) {
        case BaseTextFieldEnterAll:{
            return YES;
        }
            break;
        case BaseTextFieldEnterNumber:{
//            BOOL res = YES;
//            NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//            int i = 0;
//            while (i < string.length) {
//                NSString * string = [string substringWithRange:NSMakeRange(i, 1)];
//                NSRange range = [string rangeOfCharacterFromSet:tmpSet];
//                if (range.length == 0) {
//                    res = NO;
//                    break;
//                }
//                i++;
//            }
            return [SLFCommonTools matchStringNumber:string];
        }
            break;
        case BaseTextFieldEnterCNEN:{
            return [SLFCommonTools matchStringFormat:string];
        }
            break;
        case BaseTextFieldEnterNumberAndCN:{
            return [SLFCommonTools matchStringNumberAndCN:string];
        }
            break;
        case BaseTextFieldEnterNumberAndEN:{
            return [SLFCommonTools matchStringNumberAndEN:string];
        }
            break;
            
        default:
            return YES;
            break;
    }
    
}

- (void)setEnterType:(BaseTextFieldEnterType)enterType {
    _enterType = enterType;
    if (enterType == BaseTextFieldEnterNumberAndEN) {
        self.keyboardType = UIKeyboardTypeASCIICapable;
    }
}

-(void)dealloc {
    self.delegate = nil;
}

@end
