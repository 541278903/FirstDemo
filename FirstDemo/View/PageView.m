//
//  PageView.m
//  FirstDemo
//
//  Created by Edward on 2019/9/30.
//  Copyright © 2019 com.Edward. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "PageView.h"


@interface PageView()<UIScrollViewDelegate>

@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation PageView

- (UIPageControl *)pageControl{
    if(!_pageControl)
    {
        CGSize cs = CGSizeMake(65, 12);
        CGRect cr = CGRectMake(self.bounds.origin.x+self.bounds.size.width-cs.width-5, self.bounds.origin.y+self.bounds.size.height-cs.height, cs.width, cs.height);
        UIPageControl *pagecontrol = [[UIPageControl alloc]initWithFrame:cr];
//        self.scrollview.ba
        
        pagecontrol.numberOfPages = 5;
        pagecontrol.currentPageIndicatorTintColor = UIColor.redColor;
        _pageControl = pagecontrol;
    }
    return _pageControl;
}
- (UIScrollView *)scrollview{
    if(!_scrollview)
    {
        UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        for (int i = 0; i<5; i++) {
            UIView *uv = [[UIView alloc]initWithFrame:CGRectMake(i*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height)];
            [self setnv:uv :i];
            [scrollview addSubview:uv];
        }
        scrollview.delegate = self;
        scrollview.pagingEnabled = YES;
        scrollview.showsHorizontalScrollIndicator = NO;
        scrollview.contentSize = CGSizeMake(5 * scrollview.frame.size.width, scrollview.frame.size.height);
        scrollview.clipsToBounds = YES;
        scrollview.backgroundColor = UIColor.redColor;
        _scrollview = scrollview;
    }
    return _scrollview;
}
//只允许设置y值
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, frame.origin.y, 200, 100);
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self addSubview:self.scrollview];
    [self addSubview:self.pageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    NSLog(@"%d",page);
    self.pageControl.currentPage = page;
}

- (void)setImages:(NSArray *)images{
    return ;
}
- (void)setnv:(UIView *)uv :(int)i{
    
    switch (i) {
        case 0:
            uv.backgroundColor = UIColor.blackColor;
            break;
        case 1:
            uv.backgroundColor = UIColor.yellowColor;
            break;
        case 2:
            uv.backgroundColor = UIColor.grayColor;
            break;
        case 3:
            uv.backgroundColor = UIColor.greenColor;
            break;
        case 4:
            uv.backgroundColor = UIColor.blueColor;
            break;
        default:
            break;
    }
}



@end
