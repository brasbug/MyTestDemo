//
//  JKChartView.m
//  JKChartViewDemo
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKChartView.h"
#import "JKPointButton.h"
#import "UIButton+Extensions.h"


#define ZERO_POINT_MARGIN 40
#define AXIS_HEIGHT_MARGIN 40
#define AXIS_WIDTH_MARGIN 40








@interface JKChartView ()<UIScrollViewDelegate>
{
    
}

@property (nonatomic, strong) UIScrollView *chartScrollView;


@property (nonatomic, assign) NSInteger chatGroupCount;

@property (nonatomic, assign) NSInteger tempRowInSection;


@property (nonatomic, strong) CAShapeLayer *referenceLineLayer;

@property (nonatomic, strong) JKPointModel *popTempModel;

@property (nonatomic, assign) CGPoint zeroPoint;
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, assign) CGMutablePathRef backgroundPath;

@property (nonatomic, assign) CGRect shapeLayerFrame;


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
    _chartScrollView.delegate = self;
    _chartScrollView.contentSize = CGSizeMake(self.bounds.size.width , self.bounds.size.height);
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sigleTapGestureRecognizerHandle:)];
    [_chartScrollView addGestureRecognizer:tapGestureRecognizer];
    
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
    
    //画参考下
    [self setReferenceLine];
   
    
    
}



- (void)showLineChartView
{
    
}


- (void)setReferenceLine
{
 
    //数据源

    if (!_graphAttribute) {
        if ([self.delegate respondsToSelector:@selector(chartView:graphAttributeForGroup:)]) {
            _graphAttribute = [self.delegate chartView:self graphAttributeForGroup:0];
        }
        else
        {
            return;
//            _graphAttribute = [[JKGraphAttribute alloc]init];

        }
    }
    

    long yValueGap = (_graphAttribute.yMaxValue - _graphAttribute.yMinValue)/(_graphAttribute.xAxisLineCount);
    
    //点x间距
    CGFloat dotGapWith = _graphAttribute.dotGapWith;  //x参考线间距
    //可滑动区域宽度
    CGFloat contentSizeWith = dotGapWith * _graphAttribute.pointsCount + AXIS_WIDTH_MARGIN;
    //line参考线间距
    CGFloat yGapWith = (self.chartScrollView.bounds.size.height - AXIS_HEIGHT_MARGIN  * 1.5)/(_graphAttribute.xAxisLineCount); //Y参考线间距
    //滑动区域的高度
    CGFloat contentSizeHeight = self.chartScrollView.bounds.size.height;
    
    //折线垂直显示高度范围
    CGFloat yLinesHeight = yGapWith *_graphAttribute.xAxisLineCount;
    
    //起始坐标
    self.zeroPoint= CGPointMake(35, AXIS_HEIGHT_MARGIN - 15 + yLinesHeight);
    
    //折线显示区域
    CGRect shapeLayerFrame = CGRectMake(0, 0, contentSizeWith, contentSizeHeight);
    
    //设置滑动区域
    self.chartScrollView.contentSize = CGSizeMake(contentSizeWith, self.chartScrollView.bounds.size.height);

    
    
    
    //参考线
    _referenceLineLayer = [CAShapeLayer layer];
    _referenceLineLayer.frame =shapeLayerFrame;
    _referenceLineLayer.fillColor = [UIColor clearColor].CGColor;
    _referenceLineLayer.backgroundColor = [UIColor clearColor].CGColor;
    _referenceLineLayer.strokeColor = [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4].CGColor;
    _referenceLineLayer.lineWidth = 1;
    
    CGMutablePathRef linesPath = CGPathCreateMutable();
   
    
    
    
    
    

    for (long i = 0; i <= _graphAttribute.xAxisLineCount; i ++) {
        CGPathMoveToPoint(linesPath, NULL, 30, yGapWith *i + AXIS_HEIGHT_MARGIN - 15);
        CGPathAddLineToPoint(linesPath, NULL, contentSizeWith - AXIS_HEIGHT_MARGIN + 5, yGapWith *i + AXIS_HEIGHT_MARGIN - 15);
        UILabel *yValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 , yGapWith *i + AXIS_HEIGHT_MARGIN - 25, 30, 20)];
        yValueLabel.text = [NSString stringWithFormat:@"%.0f",yValueGap * (_graphAttribute.xAxisLineCount -i) + _graphAttribute.yMinValue];
        yValueLabel.textAlignment  = NSTextAlignmentCenter;
        yValueLabel.textColor = [UIColor blackColor];
        yValueLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:yValueLabel];

    }
    
    // 连接线绘制层
    CGMutablePathRef graphPath = CGPathCreateMutable();
    CAShapeLayer *graphLayer = [CAShapeLayer layer];
    graphLayer.frame = shapeLayerFrame;
    graphLayer.fillColor = [UIColor clearColor].CGColor;
    graphLayer.backgroundColor = [UIColor clearColor].CGColor;
    [graphLayer setStrokeColor:_graphAttribute.graphColor.CGColor];
    [graphLayer setLineWidth:_graphAttribute.lineSize];
    
    
    // 背景阴影
    _backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.frame = shapeLayerFrame;
    _backgroundLayer.fillColor = [UIColor colorWithRed:0.25 green:0.67 blue:0.48 alpha:0.5].CGColor;
    _backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
    [_backgroundLayer setStrokeColor:[UIColor clearColor].CGColor];
    [_backgroundLayer setLineWidth:1];
    _backgroundPath = CGPathCreateMutable();
    
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = self.bounds;
    circleLayer.fillColor = [UIColor whiteColor].CGColor;
    circleLayer.backgroundColor = [UIColor clearColor].CGColor;
    // 给不同图形设置线条和点的颜色，后续优化
    [circleLayer setStrokeColor:_graphAttribute.graphColor.CGColor];
    [circleLayer setLineWidth:1];
    
    
    
    //创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.delegate = self;
    animation.duration = 5.0;
    [graphLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [_backgroundLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    for (long i = 0; i < _graphAttribute.pointsCount  ; i ++) {
        
        CGFloat xPointValue = 35 + dotGapWith *i;
        CGFloat yPointValue = AXIS_HEIGHT_MARGIN - 15;
        
        CGPathMoveToPoint(linesPath, NULL, xPointValue, AXIS_HEIGHT_MARGIN - 25);
        CGPathAddLineToPoint(linesPath, NULL, xPointValue, contentSizeHeight - AXIS_HEIGHT_MARGIN + 10);
    
        if (i >= _graphAttribute.pointModelArr.count) {
            continue;
        }
        
        JKPointModel * pointmodel= [_graphAttribute.pointModelArr objectAtIndex:i];
        
        CGPoint dotCenterPoint = CGPointMake(xPointValue, yPointValue + yLinesHeight *(_graphAttribute.yMaxValue - pointmodel.yValueFloat)/_graphAttribute.yMaxValue);
        CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(dotCenterPoint.x-3, dotCenterPoint.y-3, 6, 6)); // 绘制点

        
        if (i == 0) {
            CGPathMoveToPoint(graphPath, NULL, dotCenterPoint.x, dotCenterPoint.y);
            CGPathMoveToPoint(_backgroundPath, NULL, dotCenterPoint.x, self.zeroPoint.y);
            CGPathAddLineToPoint(_backgroundPath, NULL, dotCenterPoint.x, dotCenterPoint.y);
        }
        else
        {
            CGPathAddLineToPoint(graphPath, NULL, dotCenterPoint.x, dotCenterPoint.y);
            CGPathAddLineToPoint(_backgroundPath, NULL, dotCenterPoint.x, dotCenterPoint.y);
        }
        if (i == _graphAttribute.pointModelArr.count - 1) {
            CGPathAddLineToPoint(_backgroundPath, NULL, dotCenterPoint.x, self.zeroPoint.y);
        }
        
       
        
        NSLog(@"%@",pointmodel);
        JKPointButton * pointbtn= [[JKPointButton alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        pointbtn.backgroundColor = [UIColor clearColor];
        [pointbtn setHitTestEdgeInsets:UIEdgeInsetsMake(-20, -20, -20, -20)];
        pointbtn.pointModel = pointmodel;
        [pointbtn addTarget:self action:@selector(pointBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        pointbtn.center = dotCenterPoint;
        [self.chartScrollView addSubview:pointbtn];
        
        UILabel *xValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 , self.chartScrollView.bounds.size.height - 30 , 40, 20)];
        xValueLabel.text = pointmodel.xPoint;
        xValueLabel.textAlignment  = NSTextAlignmentCenter;
        xValueLabel.textColor = [UIColor blackColor];
        xValueLabel.font = [UIFont systemFontOfSize:12];
        xValueLabel.center = CGPointMake(dotCenterPoint.x, xValueLabel.center.y);
        [self.chartScrollView addSubview:xValueLabel];
     
        
        
        
        

        
    }
    
    _referenceLineLayer.path = linesPath;
    CGPathRelease(linesPath);
    
   
    
    circleLayer.path = circlePath;
    CGPathRelease(circlePath);
    
    graphLayer.path = graphPath;
    CGPathRelease(graphPath);
    
    _backgroundLayer.path = _backgroundPath;
    CGPathRelease(_backgroundPath);
    [self gradientBackground:_backgroundLayer color:_graphAttribute.graphColor];

    
    [self.chartScrollView.layer addSublayer:_referenceLineLayer];
    [self.chartScrollView.layer addSublayer:graphLayer];
    [self.chartScrollView.layer addSublayer:circleLayer];
//    [self.chartScrollView.layer addSublayer:_backgroundLayer];

}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
   
    
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)becomeFirstResponder
{
    return [super becomeFirstResponder];
}


- (void)popMenuMess:(id)sender
{
    
    
//    NSLog(@"%@",sender);
//    NSLog(@"%@",self.popTempModel);
    
    
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(popMenuMess:));
}

/**
 *  统一一个方法隐藏MenuController，多处需要调用
 */
- (void)setupNormalMenuController
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }
}

- (void)pointBtnPressed:(JKPointButton *)sender
{
//    NSLog(@"%f,%f",sender.center.x,sender.center.y);
    self.popTempModel = sender.pointModel;

    [self becomeFirstResponder];
    
    UIMenuItem *popMenu = [[UIMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"%@",sender.pointModel.yPoint] action:@selector(popMenuMess:)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:popMenu, nil]];
    
    
    CGRect targetRect = [self convertRect:sender.frame
                                 fromView:self];

    [menu setTargetRect:CGRectInset(targetRect, 0.0f, 4.0f) inView:self.chartScrollView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMenuWillShowNotification:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:nil];
    [menu setMenuVisible:YES animated:YES];
    
}

#pragma mark - Notifications
- (void)handleMenuWillHideNotification:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
}

- (void)handleMenuWillShowNotification:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillShowMenuNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMenuWillHideNotification:)
                                                 name:UIMenuControllerWillHideMenuNotification
                                               object:nil];
}

- (void)sigleTapGestureRecognizerHandle:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self setupNormalMenuController];

    }
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setupNormalMenuController];
    
}


/**
 *  添加渐变背景
 *
 *  @param targetLayer 渐变路径约束层
 */
- (void)gradientBackground:(CAShapeLayer*)targetLayer color:(UIColor*)color
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.chartScrollView.contentSize.width, self.chartScrollView.contentSize.height);;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)color.CGColor,
                       (id)[UIColor colorWithWhite:1.0 alpha:0.4].CGColor,
                       nil];
    
    [gradient setMask:targetLayer]; // 用targetLayer来截取渐变层gradient
    [self.chartScrollView.layer addSublayer:gradient];
    //    [self.layer insertSublayer:gradient atIndex:0];
}


@end
