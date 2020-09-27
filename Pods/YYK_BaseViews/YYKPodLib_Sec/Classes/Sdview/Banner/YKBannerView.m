//
//  YKBannerView.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/9/15.


#import "YKBannerView.h"
#import "YKBannerViewCell.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface YKBannerView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,assign) NSInteger numberOfPage;

@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) UICollectionView *collectionView;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation YKBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.numberOfPage = 0;
        
    }
    return self;
}
-(void)setup{
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self startTimer];
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    if(images.count<=1)
    {
        [self.pageControl setHidden:YES];
    }else
    {
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = images.count;
    }
    [self.collectionView reloadData];
}


#pragma mark -collection

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSIndexPath *realIndexPath = indexPath;
    if (indexPath.row == self.images.count) { // 在最后一个后面 添加第一个cell
        realIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    YKBannerViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YKBannerViewCell class]) forIndexPath:realIndexPath];
    [cell loadViewModel:self.images[realIndexPath.row] indexPath:realIndexPath];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count + 1;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startTimer];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 向右滑到最后一页
    if (offsetX > scrollView.contentSize.width - scrollView.bounds.size.width) {
        // 偷偷滚动到最初位置
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    if (offsetX < 0) {
        // 偷偷滚动到 倒数第二页
        [scrollView setContentOffset:CGPointMake(scrollView.contentSize.width - scrollView.bounds.size.width, 0) animated:NO];
    }
    if(currentPage == self.images.count)
    {
        currentPage = 0;
    }
    self.pageControl.currentPage = currentPage;
}

-(void)nextPage
{
    if(self.numberOfPage < self.images.count-1)
    {
        self.numberOfPage += 1;
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.numberOfPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }else if (self.numberOfPage == self.images.count -1)
    {
        self.numberOfPage = 0;
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(clipBanner:andMessage:)])
    {
        [self.delegate clipBanner:self andMessage:@""];
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
 
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark -get/set
- (UICollectionView *)collectionView
{
    if(!_collectionView)
    {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat widthx = SCREEN_WIDTH;
        CGFloat heighth = widthx *0.4;
        layout.itemSize = CGSizeMake(widthx, heighth);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.layer.borderColor = UIColor.clearColor.CGColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:YKBannerViewCell.class forCellWithReuseIdentifier:NSStringFromClass([YKBannerViewCell class])];
    }
    return _collectionView;
}

- (NSTimer *)timer
{
    if(!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        CGPoint centerpoint = CGPointMake(self.center.x, self.frame.size.height - 10);
        pageControl.center = centerpoint;
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.pageIndicatorTintColor = [UIColor purpleColor];
        _pageControl = pageControl;
    }
    
    return _pageControl;
}
#pragma mark -设置timer
-(void)startTimer
{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
}
-(void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)timerHandler:(NSTimer *)timer
{
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + self.collectionView.bounds.size.width, 0) animated:YES];
}
@end
