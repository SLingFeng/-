//
//  CollectSratView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "CollectSratView.h"

@implementation CollectSratView



-(instancetype)init {
    if (self = [super init]) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewClick:)];
        [self addGestureRecognizer:tap];
        
        self.starImageView = [[UIImageView alloc] init];
        [self addSubview:_starImageView];
        
        self.collectJobLabel = [[MyLabel alloc] init];
        [self addSubview:_collectJobLabel];
                
        _starImageView.sd_layout.leftSpaceToView(self, 0).widthIs(15).heightEqualToWidth(0).topSpaceToView(self, 0);
        _collectJobLabel.sd_layout.leftSpaceToView(_starImageView, 0).centerYEqualToView(_starImageView).rightSpaceToView(self, 0).heightIs(15);
        kWeakSelf(weakSelf);
        self.starSetupSatus = ^(BOOL isCollect) {
            if (isCollect) {
                weakSelf.collectSatus = ZXXStatusCollect;
            }else {
                weakSelf.collectSatus = ZXXStatusNoCollect;
            }
        };
        
    }
    return self;
}

-(void)collectionViewClick:(UITapGestureRecognizer *)tap {
    if (self.starClick) {
        self.starClick();
    }
}

-(void)setCollectSatus:(ZXXCStatus)collectSatus {
    if (collectSatus == ZXXStatusCollect) {
        //            收藏了的图片
        self.collectJobLabel.text = @"已收藏";
        self.starImageView.image = [UIImage imageNamed:@"已收藏"];
    }else {
        //            没收藏图片
        self.collectJobLabel.text = @"收藏簡歷";
        self.starImageView.image = [UIImage imageNamed:@"未收藏"];
    }
    if (_collectSatus != collectSatus) {
        _collectSatus = collectSatus;
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
