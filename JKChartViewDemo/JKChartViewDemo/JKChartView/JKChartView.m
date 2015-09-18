//
//  JKChartView.m
//  JKChartViewDemo
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKChartView.h"
#import "JKPointButton.h"










@interface JKChartView ()
@property (nonatomic, strong) UIScrollView *chartScrollView;
@property (nonatomic, assign) NSInteger chatGroupCount;

@property (nonatomic, assign) NSInteger tempRowInSection;


@property (nonatomic, strong) CAShapeLayer *referenceLineLayer;

@property (nonatomic, strong) JKGraphAttribute *graphAttribute;


@end

@implementation JKChartView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultViews];
    }
    return self;
}


- (UIScrollView *)chartScrollView
{
    if (_chartScrollView) {
        return _chartScrollView;
    }
    _chartScrollView  = [[UIScrollView alloc]initWithFrame:self.bounds];
    _chartScrollView.backgroundColor = [UIColor clearColor];
    //    _chartScrollView.showsHorizontalScrollIndicator = NO;
    //    _chartScrollView.showsVerticalScrollIndicator = NO;
    _chartScrollView.contentSize = CGSizeMake(self.bounds.size.width *2, self.bounds.size.height);
    return _chartScrollView;
    
    
}



- (void)initDefaultViews
{
    [self addSubview:self.chartScrollView];
  
}


- (void)reloadChartData
{
    //移除原画布
    [self clearViewsAndLayers];
    
    //再次初始化画布
    [self initDefaultViews];
    
    //获取图像组数
    [self setGroupCount];
    
    
    
    for (long i = 0; i < self.chatGroupCount; i++) {
        _tempRowInSection = [self.delegate chartView:self numbersOfRowsInSection:i];
        for (long j = 0; j < _tempRowInSection; j ++) {

            
        }
        
        
        
    }
    
    
    
    
}


- (void)setReferenceLine
{
    
    JKGraphAttribute *graphAttribute = [[JKGraphAttribute alloc]init];
    graphAttribute.pointsCount = 10;
    graphAttribute.xAxisLineCount = 5;
    graphAttribute.yMaxValue = 100;
    graphAttribute.yMinValue = 0;
    graphAttribute.dotGapWith = 44;
    
    
    
    
    
    
    
    
    
    
}



- (void)clearViewsAndLayers
{
    
    NSArray* subViewsAry = self.subviews;
    for (NSInteger i=0,len=[subViewsAry count]; i<len; i++) {
        UIView* subView = (UIView*)[subViewsAry objectAtIndex:i];
        [subView removeFromSuperview];
    }
    
    [self.layer setSublayers:nil];
    _chartScrollView = nil;

    
}

//设置图像组数
- (void)setGroupCount
{
    _chatGroupCount = 1;
    if ([self.delegate respondsToSelector:@selector(numberOfChartGroup:)]) {
        _chatGroupCount = [_delegate numberOfChartGroup:self];
    }
    _chatGroupCount = _chatGroupCount >0 ?_chatGroupCount:1;
    
}



@end
