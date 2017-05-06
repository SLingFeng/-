//
//  StatusLabelView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//
#import "StatusLabelView.h"

@implementation StatusLabelView
{
    UIView * _statusView;
}
-(instancetype)initWithTitle:(NSString *)title status:(BOOL)status {
    if (self = [super init]) {
        kSelfAddView(self.title, MyLabel);
        _contentText = title;
        kSelfAddView(_statusView, UIView);
        
        self.status = status;
        [_statusView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(14);
            make.width.mas_equalTo(2.5);
            make.left.and.top.and.bottom.offset(0);
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_statusView.mas_right).offset(5);
            make.right.offset(0);
            make.top.and.bottom.offset(0);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

-(void)setContentText:(NSString *)text {
    NSDictionary * style = @{@"font" : [SLFCommonTools pxFont:28],
                             @"color" : [SLFCommonTools getFont33Color],
                             @"color2" : [SLFCommonTools getFont99Color]};
    
    _title.attributedText = [[NSString stringWithFormat:@"<font><color>%@：</color></font><color2>%@</color2>", _contentText, text] attributedStringWithStyleBook:style];
    
}

-(void)setStatus:(BOOL)status {
    _status = status;
    if (status) {
//        [_statusView setBackgroundColor:[SLFCommonTools getRedColor]];
    }else {
        [_statusView setBackgroundColor:[SLFCommonTools getNavBarColor]];
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation ImageLableView

-(instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName {
    if (self = [super init]) {
        
        UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [self addSubview:image];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.offset(0);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        kSelfAddView(self.title, MyLabel);
        _title.text = title;
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).offset(5);
            make.right.offset(0);
            make.top.and.bottom.offset(0);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

-(void)setContentText:(NSString *)contentText {
    _contentText = contentText;
    _title.text = contentText;
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([SLFCommonTools textSize:contentText font:[SLFCommonTools pxFont:28]].height);
    }];
    [self setupAutoHeightWithBottomView:_title bottomMargin:0];
}

-(void)setContent {
    NSDictionary * style = @{@"font" : [SLFCommonTools pxFont:28],
                             @"color" : [SLFCommonTools getFont33Color],
                             @"color2" : [SLFCommonTools getFont99Color]};
    
    _title.attributedText = [[NSString stringWithFormat:@"<font><color>%@ :  </color></font><color2>%@</color2>", _title.text, @"10/10"] attributedStringWithStyleBook:style];
    
}

@end



