//
//  MyTimeButton.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyTimeButton.h"

@interface MyTimeButton ()
{
    NSInteger _oldTime;
}
//    上一次的文本
@property (copy, nonatomic) NSString *oldText;

@property (strong, nonatomic) NSTimer * timer;

@property (retain, nonatomic) UIColor * oldColor;

@end

@implementation MyTimeButton

-(instancetype)init {
    if (self = [super init]) {
        [self setupTime];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupTime];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupTime];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setupTime];
}

-(void)setupTime {
    _oldText = @"获取验证码";
//    [self addTarget:self action:@selector(onClick) forControlEvents:(UIControlEventTouchUpInside)];
     kWeakSelf(weakSelf);
    self.onClickStartTiming = ^() {
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(timeChange:) userInfo:nil repeats:YES];
//        weakSelf.oldColor = weakSelf.backgroundColor;
        weakSelf.status = MyStatusFailure;
        weakSelf.oldText = weakSelf.titleLabel.text;
        weakSelf.timer.fireDate = [NSDate distantPast];
        weakSelf.enabled = NO;
    };
}

-(void)onClick {
   
    
//    if (self.onClickStartTiming) {
//        self.onClickStartTiming(self);
//    }
}

-(void)timeChange:(NSTimer *)sender {
    if (0 >= _timeNum) {
        _timeNum = _oldTime;
        sender.fireDate = [NSDate distantFuture];
        [sender invalidate];
        self.titleLabel.text = _oldText;
        [self setTitle:_oldText forState:(UIControlStateNormal)];
        self.status = MyStatusSuccess;
//        [self setBackgroundColor:self.oldColor];
        self.enabled = YES;
        return;
    }
    NSInteger temp = _timeNum--;
    self.titleLabel.text = [NSString stringWithFormat:@"重新发送(%ld)", (long)temp];
    [self setTitle:[NSString stringWithFormat:@"重新发送(%ld)", (long)temp] forState:(UIControlStateNormal)];
}

-(void)resetTime {
    _timeNum = _oldTime;
    self.timer.fireDate = [NSDate distantFuture];
    [self.timer invalidate];
    [self setTitle:_oldText forState:(UIControlStateNormal)];
    self.enabled = YES;
}

-(void)stopTime {
    self.timer.fireDate = [NSDate distantFuture];
    if (_timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)dealloc {
    self.timer.fireDate = [NSDate distantFuture];
    if (_timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

-(void)setTimeNum:(NSInteger)timeNum {
    if (_timeNum  != timeNum) {
        _timeNum = timeNum;
        _oldTime = timeNum;
    }
}

@end
