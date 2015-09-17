//
//  JKADPageView.m
//  JKADPageViewDemo
//
//  Created by Jack on 15/8/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKADPageView.h"

@interface JKADPageView ()<UIScrollViewDelegate>

@property (nonatomic, assign) long  indexShow;
@property (nonatomic, strong) JKADImageItem *tempItem;



@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imagePrev;
@property (nonatomic, strong) UIImageView *imageCurrentv;
@property (nonatomic, strong) UIImageView *imageNextV;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) JKADPageCallBack myBlock;

@property (nonatomic, strong) NSArray *arrlist;

@property (nonatomic, strong) NSTimer *myTimer;

@end


@implementation JKADPageView
@synthesize myBlock;


- (UIScrollView *)scrollView
{
    if (_scrollView) {
        return _scrollView;
    }
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView setTranslatesAutoresizingMaskIntoConstraints:YES];

    return _scrollView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self initSubViews];
}



- (void)initSubViews
{
    [self addSubview:self.scrollView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds)];
    [self.scrollView addGestureRecognizer:tap];
    
    
    _imagePrev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
    _imageCurrentv = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width , self.frame.size.height)];
    _imageNextV = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width , self.frame.size.height)];
    _imagePrev.layer.masksToBounds = YES;
    _imagePrev.layer.borderWidth = 2;
//    _imagePrev.layer.borderColor = [UIColor clearColor].CGColor;
    
    _imageCurrentv.layer.masksToBounds = YES;
    _imageCurrentv.layer.borderWidth = 2;
//    _imageCurrentv.layer.borderColor = [UIColor clearColor].CGColor;

    _imageNextV.layer.masksToBounds = YES;
    _imageNextV.layer.borderWidth = 2;
//    _imageNextV.layer.borderColor = [UIColor clearColor].CGColor;

    
    _imageCurrentv.contentMode = UIViewContentModeScaleAspectFit;
    _imagePrev.contentMode = UIViewContentModeScaleAspectFit;
    _imageNextV.contentMode = UIViewContentModeScaleAspectFit;

    [self.scrollView addSubview:_imagePrev];
    [self.scrollView addSubview:_imageCurrentv];
    [self.scrollView addSubview:_imageNextV];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 10, self.frame.size.width, 10)];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    
    
}

- (void)startAdsWithImageArray:(NSArray *)imageArr
{
    if (imageArr.count <=1) {
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    _pageControl.numberOfPages = imageArr.count;
    self.arrlist = imageArr;
//    self.myBlock = block;
    [self reloadImages];
}




- (void)tapAds
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickItemAtIndext:imageModel:)]) {
        [self.delegate clickItemAtIndext:_indexShow imageModel:_tempItem];
    }
//    if (self.myBlock != NULL) {
////        NSLog()
//        self.myBlock(_indexShow);
//    }
//    if (_myTimer)
//        [_myTimer invalidate];
//    if (_iDisplayTime > 0)
//        [self startTimerPlay];
}

- (void)reloadImages
{
    if (_indexShow >= (long)_arrlist.count) {
        _indexShow = 0;
    }
    
    if (_indexShow < 0) {
        _indexShow = (long)_arrlist.count - 1;
    }
    
    
    long prev = _indexShow - 1;
    if (prev < 0) {
        prev = (long)_arrlist.count - 1;
    }
    
    long next = _indexShow +1;
    if (next > (long)_arrlist.count -1) {
        next = 0;
    }
    _pageControl.currentPage = _indexShow;
    _tempItem = [_arrlist objectAtIndex:_indexShow];
    JKADImageItem *prevImageItem = [_arrlist objectAtIndex:prev];
    JKADImageItem *currentImageItem = [_arrlist objectAtIndex:_indexShow];
    JKADImageItem *nextImageItem = [_arrlist objectAtIndex:next];
    if (_isWebImage) {
        if(_delegate && [_delegate respondsToSelector:@selector(setadsWebImage:imageUrl:)])
        {
            [_delegate setadsWebImage:_imagePrev imageUrl:prevImageItem.imageURLStr];
            [_delegate setadsWebImage:_imageCurrentv imageUrl:currentImageItem.imageURLStr];
            [_delegate setadsWebImage:_imageNextV imageUrl:nextImageItem.imageURLStr];
        }
        else
        {
//            _imagePrev.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:prevImageItem.imageURLStr]]];
//            _imageCurrentv.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentImageItem.imageURLStr]]];
//            _imageNextV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nextImageItem.imageURLStr]]];
        }
    }
    else
    {
        _imagePrev.image = prevImageItem.image;
        _imageCurrentv.image = currentImageItem.image;
        _imageNextV.image = nextImageItem.image;
    }
    
    [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    
}



/**
 *  切换图片完毕事件
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    if (_myTimer)
//        [_myTimer invalidate];
    
    if ((long) scrollView.contentOffset.x >= (long) self.frame.size.width*2)
    {
        _indexShow++;
    }
    
    
    else if (scrollView.contentOffset.x < self.frame.size.width)
    {
         _indexShow--;
    }
    
    [self reloadImages];
}



//- (void)startTimerPlay {
//    _myTimer = [NSTimer scheduledTimerWithTimeInterval:_iDisplayTime target:self selector:@selector(doImageGoDisplay) userInfo:nil repeats:NO];
//}
//
///**
// *  轮播图片
// */
//- (void)doImageGoDisplay {
//    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height) animated:YES];
//    _indexShow++;
//    [self performSelector:@selector(reloadImages) withObject:nil afterDelay:0.3];
//}







@end
