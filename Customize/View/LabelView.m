//
//  LabelView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "LabelView.h"

@implementation LabelView


- (instancetype)init {
    if (self = [super init]) {
        
        MyLabel *firstLabel = [[MyLabel alloc] init];
        [self addSubview:firstLabel];
        firstLabel.textAlignment = NSTextAlignmentRight;
        firstLabel.font = [SLFCommonTools pxFont:28];
        firstLabel.textColor = k111111;
        self.firstLabel = firstLabel;
        
        MyLabel *secondLabel = [[MyLabel alloc] init];
        secondLabel.font = [SLFCommonTools pxFont:28];
        secondLabel.textColor = k111111;
        [self addSubview:secondLabel];
        self.secondLabel = secondLabel;
        

    }
    return self;
}

-(void)setFirstText:(NSString *)firstText secondText:(NSString *)secondText {
    NSDictionary * style = @{@"font" : [SLFCommonTools pxFont:28],
                             @"color" : k666666,
                             @"color2" : k999999};
    self.firstLabel.text = firstText;
    self.secondLabel.text = secondText;
    
    kWeakSelf(weakSelf);
    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.width.mas_equalTo(ISiPhone6Plus?80:75);
    }];
    
    [_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_firstLabel.mas_right).offset(0);
        make.topMargin.equalTo(_firstLabel);
        make.right.offset(0);
    }];
    
    [self setupAutoHeightWithBottomViewsArray:@[_firstLabel, _secondLabel] bottomMargin:0];
    
}

-(void)setFirstText:(NSString *)firstText firstColor:(UIColor *)fc secondText:(NSString *)secondText secondColor:(UIColor *)sc {
    self.firstLabel.text = firstText;
    self.firstLabel.textColor = fc;
    self.secondLabel.text = secondText;
    self.secondLabel.textColor = sc;
    
    _firstLabel.sd_resetNewLayout.topSpaceToView(self, 0).leftSpaceToView(self, 0).widthIs([SLFCommonTools textSize:firstText font:_firstLabel.font].width).heightIs(17);
//    _secondLabel.sd_resetNewLayout.topSpaceToView(self, 0).leftSpaceToView(self, 0).widthIs([SLFCommonTools textSize:secondText font:_secondLabel.font].width)
//    .heightIs([SLFCommonTools textHight:secondText font:_secondLabel.font.pointSize width:[SLFCommonTools textSize:firstText font:_firstLabel.font].width]);

    kWeakSelf(weakSelf);
//    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(0);
//        make.left.offset(0);
//    }];
    
    [_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_firstLabel.mas_right).offset(0);
        make.topMargin.equalTo(_firstLabel);
        make.right.offset(0);
    }];
    
    [self setupAutoHeightWithBottomViewsArray:@[_firstLabel, _secondLabel] bottomMargin:0];
}


@end
