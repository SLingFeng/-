//
//  MyView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyView.h"

@implementation MyView
//放输入框 的view
-(instancetype)init {
    if (self = [super init]) {
        [self setMyView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setMyView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setMyView];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setMyView];
}


-(void)setMyView {
    self.layer.cornerRadius = 6;
    self.layer.borderWidth = 0.6;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
