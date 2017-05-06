//
//  SelectGroupView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "SelectGroupView.h"


@implementation SelectGroupView
{
    SeleCtType _type;
}
-(instancetype)init {
    if (self = [super init]) {
        self.layer.cornerRadius = 12.5f;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = RGBCOLOR(44, 157, 247).CGColor;
        self.layer.borderWidth = 0.5;
        self.backgroundColor = [SLFCommonTools colorHex:@"e9f5fe"];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title type:(SeleCtType)type {
    if (self = [self init]) {
        _type = type;
        kSelfAddView(self.titleLabel, MyLabel);
        _titleLabel.text = title;
        _titleLabel.textColor = RGBCOLOR(44, 157, 247);
        
        UIImageView * down = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"隐藏"]];
        [self addSubview:down];
        
        kWeakSelf(weakSelf);
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.left.offset(15);
        }];
        [down mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.size.mas_equalTo(CGSizeMake(10, 6));
            make.centerY.equalTo(weakSelf);
        }];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)]];
    }
    return self;
}

-(void)viewTap {
    SelectDataPicker * sdp = [[SelectDataPicker alloc] initWithType:_type];
    sdp.NameDataArr = _dataArray!=nil?_dataArray:nil;
    kWeakSelf(weakSelf);
    sdp.backTimeDate = ^(NSString *text, NSDate *date, NSInteger index) {
        NSLog(@"%@", text);
        weakSelf.titleLabel.text = text;
        weakSelf.timeText = text;
        weakSelf.date = date;
        if (self.backTime) {
            self.backTime(text, date, index);
        }
    };
    
}

@end
