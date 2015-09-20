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

@property (nonatomic, assign) CGPoint zeroPoint;


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
    
    
//    for (long i = 0; i < self.chatGroupCount; i++) {
//        _graphAttribute = [self.delegate chartView:self graphAttributeForGroup:i];
//        for (long j = 0; j < _graphAttribute.pointModelArr.count; j ++) {
//            NSIndexPath *indextPaht = [NSIndexPath indexPathForRow:j inSection:i];
//
//            JKPointButton *pointBtn = [self.delegate chartView:self pointModelAtIndextPath:indextPaht];
//            
//            
//            
//
//        }
//        
//        
//        
//    }

    
    
    
}


- (void)setReferenceLine
{
    
    JKGraphAttribute *graphAttribute = [[JKGraphAttribute alloc]init];

    
    if ([self.delegate respondsToSelector:@selector(chartView:graphAttributeForGroup:)]) {
        graphAttribute = [self.delegate chartView:self graphAttributeForGroup:0];
    }
    
    long yValueGap = (graphAttribute.yMaxValue - graphAttribute.yMinValue)/(graphAttribute.xAxisLineCount);
    
    
    CGFloat dotGapWith = graphAttribute.dotGapWith;  //x参考线间距
    CGFloat contentSizeWith = dotGapWith * graphAttribute.pointsCount + AXIS_WIDTH_MARGIN;
    CGFloat yGapWith = (self.chartScrollView.bounds.size.height - AXIS_HEIGHT_MARGIN  * 1.5)/(graphAttribute.xAxisLineCount); //Y参考线间距
    CGFloat contentSizeHeight = self.chartScrollView.bounds.size.height;
    
    CGFloat yLinesHeight = yGapWith *graphAttribute.xAxisLineCount;
    
    self.zeroPoint= CGPointMake(35, AXIS_HEIGHT_MARGIN - 15 + yLinesHeight);
    
    
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
        UILabel *yValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 , yGapWith *i + AXIS_HEIGHT_MARGIN - 25, 30, 20)];
        yValueLabel.text = [NSString stringWithFormat:@"%.0f",yValueGap * (graphAttribute.xAxisLineCount -i) + graphAttribute.yMinValue];
        yValueLabel.textAlignment  = NSTextAlignmentCenter;
        yValueLabel.textColor = [UIColor blackColor];
        yValueLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:yValueLabel];

    }
    
    // 连接线绘制层
    CGMutablePathRef graphPath = CGPathCreateMutable();
    CAShapeLayer *graphLayer = [CAShapeLayer layer];
    graphLayer.frame = self.bounds;
    graphLayer.fillColor = [UIColor clearColor].CGColor;
    graphLayer.backgroundColor = [UIColor clearColor].CGColor;
    [graphLayer setStrokeColor:graphAttribute.graphColor.CGColor];
    [graphLayer setLineWidth:graphAttribute.lineSize];
    
    
    // 背景阴影
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.frame = self.bounds;
    backgroundLayer.fillColor = [UIColor colorWithRed:0.25 green:0.67 blue:0.48 alpha:0.5].CGColor;
    backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
    [backgroundLayer setStrokeColor:[UIColor clearColor].CGColor];
    [backgroundLayer setLineWidth:1];
    CGMutablePathRef backgroundPath = CGPathCreateMutable();
    
    
    
    
    for (long i = 0; i < graphAttribute.pointModelArr.count  ; i ++) {
        
        CGFloat xPointValue = 35 + dotGapWith *i;
        CGFloat yPointValue = AXIS_HEIGHT_MARGIN - 15;
        
        CGPathMoveToPoint(linesPath, NULL, xPointValue, AXIS_HEIGHT_MARGIN - 25);
        CGPathAddLineToPoint(linesPath, NULL, xPointValue, contentSizeHeight - AXIS_HEIGHT_MARGIN + 10);
    
        
        NSIndexPath *indextPaht = [NSIndexPath indexPathForRow:i inSection:0];
        JKPointModel * pointmodel= [self.delegate chartView:self pointModelAtIndextPath:indextPaht];
        
        CGPoint dotCenterPoint = CGPointMake(xPointValue, yPointValue + yLinesHeight *(graphAttribute.yMaxValue - pointmodel.yValueFloat)/graphAttribute.yMaxValue);
        
        if (i == 0) {
            CGPathMoveToPoint(graphPath, NULL, dotCenterPoint.x, dotCenterPoint.y);
            CGPathMoveToPoint(backgroundPath, NULL, dotCenterPoint.x, self.zeroPoint.y);
            CGPathAddLineToPoint(backgroundPath, NULL, dotCenterPoint.x, dotCenterPoint.y);
        }
        else
        {
            CGPathAddLineToPoint(graphPath, NULL, dotCenterPoint.x, dotCenterPoint.y);
            CGPathAddLineToPoint(backgroundPath, NULL, dotCenterPoint.x, dotCenterPoint.y);
        }
        if (i == graphAttribute.pointModelArr.count - 1) {
            CGPathAddLineToPoint(backgroundPath, NULL, dotCenterPoint.x, self.zeroPoint.y);
        }
        
       
        
        NSLog(@"%@",pointmodel);
        JKPointButton * pointbtn= [[JKPointButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        pointbtn.backgroundColor = [UIColor clearColor];
        pointbtn.center = dotCenterPoint;
        [self.chartScrollView addSubview:pointbtn];
        

        
    }
    
    _referenceLineLayer.path = linesPath;
//    CGPathRelease(linesPath);
    
    backgroundLayer.path = backgroundPath;
//    CGPathRelease(backgroundPath);
//    [self gradientBackground:backgroundLayer color:graphAttribute.graphColor];
    graphLayer.path = graphPath;
    
    [self.chartScrollView.layer addSublayer:_referenceLineLayer];
    [self.chartScrollView.layer addSublayer:graphLayer];
    [self.chartScrollView.layer addSublayer:backgroundLayer];
    
    
    
    
    
    
    
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





/**
 *  添加渐变背景
 *
 *  @param targetLayer 渐变路径约束层
 */
- (void)gradientBackground:(CAShapeLayer*)targetLayer color:(UIColor*)color
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)color.CGColor,
                       (id)[UIColor colorWithWhite:1.0 alpha:0.4].CGColor,
                       nil];
    
    [gradient setMask:targetLayer]; // 用targetLayer来截取渐变层gradient
    [self.chartScrollView.layer addSublayer:gradient];
    //    [self.layer insertSublayer:gradient atIndex:0];
}


@end
