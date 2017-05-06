//
//  MyViewToScroll.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyViewToScroll.h"

@interface MyViewToScroll ()<UIScrollViewDelegate>
{
    UIPageControl * _page;
    UIScrollView * _scroll;
}
@end

@implementation MyViewToScroll

-(instancetype)init {
    if (self = [super init]) {
        [self setMyViewToScroll];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setMyViewToScroll];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setMyViewToScroll];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setMyViewToScroll];
}

-(void)setMyViewToScroll {
    
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scroll.contentSize = CGSizeMake(4*kSelfW, 0);
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.showsHorizontalScrollIndicator = NO;
    
    
    for (int i=0; i<4; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i*kSelfW, 0, kSelfW, kSelfH)];
        view.backgroundColor = kColorRandomly;
        view.tag = i+10;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [view addGestureRecognizer:tap];
        [_scroll addSubview:view];
        
    }
    [self addSubview:_scroll];
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kSelfH - 20, kSelfW, 20)];
    _page.numberOfPages = 4;
    [_page addTarget:self action:@selector(pageChange) forControlEvents:(UIControlEventValueChanged)];
    [self addSubview:_page];
    
}

-(void)tapClick:(UITapGestureRecognizer *)tap {
    NSLog(@"%s", __func__);
    if (self.click) {
        self.click(tap.view.tag);
    }
    
}

-(void)pageChange {
    NSInteger index = _page.currentPage;
    [_scroll setContentOffset:CGPointMake(kSelfW *index, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = _scroll.contentOffset.x /kSelfW;
    [_page setCurrentPage:index];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
