//
//  JKChartView.m
//  JKChartViewDemo
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKChartView.h"
#import "JKPointButton.h"

#define ZERO_POINT_MARGIN 40
#define AXIS_HEIGHT_MARGIN 40
#define AXIS_WIDTH_MARGIN 40








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
    
    [self setReferenceLine];
    
    
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
    
    if ([self.delegate respondsToSelector:@selector(chartView:graphAttributeForGroup:)]) {
        graphAttribute = [self.delegate chartView:self graphAttributeForGroup:0];
    }
    
    CGFloat dotGapWith = graphAttribute.dotGapWith;
    CGFloat contentSizeWith = dotGapWith * graphAttribute.pointsCount + AXIS_WIDTH_MARGIN *2;
    CGFloat yGapWith = (self.chartScrollView.bounds.size.height - AXIS_HEIGHT_MARGIN  * 1.5)/(graphAttribute.xAxisLineCount);
    CGFloat contentSizeHeight = self.chartScrollView.bounds.size.height;
    
    _referenceLineLayer = [CAShapeLayer layer];
    _referenceLineLayer.frame = self.bounds;
    _referenceLineLayer.fillColor = [UIColor clearColor].CGColor;
    _referenceLineLayer.backgroundColor = [UIColor clearColor].CGColor;
    _referenceLineLayer.strokeColor = [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4].CGColor;
    _referenceLineLayer.lineWidth = 1;
    
    CGMutablePathRef linesPath = CGPathCreateMutable();
   
    
    self.chartScrollView.contentSize = CGSizeMake(contentSizeWith, self.chartScrollView.bounds.size.height);

    for (long i = 0; i <= graphAttribute.xAxisLineCount; i ++) {
        CGPathMoveToPoint(linesPath, NULL, 30, yGapWith *i + AXIS_HEIGHT_MARGIN - 15);
        CGPathAddLineToPoint(linesPath, NULL, contentSizeWith - AXIS_HEIGHT_MARGIN + 5, yGapWith *i + AXIS_HEIGHT_MARGIN - 15);

    }
    
    for (long i = 0; i <= graphAttribute.pointsCount ; i ++) {
        CGPathMoveToPoint(linesPath, NULL, 35 + dotGapWith *i, AXIS_HEIGHT_MARGIN - 25);
        CGPathAddLineToPoint(linesPath, NULL, 35 + dotGapWith *i, contentSizeHeight - AXIS_HEIGHT_MARGIN + 10);
    }
    
    _referenceLineLayer.path = linesPath;
    [self.chartScrollView.layer addSublayer:_referenceLineLayer];
    
    
    
    
    
    
    
    
    
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
