//
//  BaseImageView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "BaseImageView.h"

@implementation BaseImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithRadius:(CGFloat)radius {
    if (self = [super init]) {
        self.layer.masksToBounds = 1;
        self.layer.cornerRadius = radius;
//        [self set];
    }
    return self;
}

-(void)set {
    
}





@end
