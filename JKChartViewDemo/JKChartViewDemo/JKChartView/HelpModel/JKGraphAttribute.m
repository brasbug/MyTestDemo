//
//  JKGraphAttribute.m
//  JKChartViewDemo
//
//  Created by Jack on 15/9/17.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKGraphAttribute.h"

@implementation JKGraphAttribute



- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setDefaultAttri];
    }
    
    return self;
}

/**
 *  如果用户未对图形设置自定义属性，则默认使用该属性
 */
- (void)setDefaultAttri
{
    _yMaxValue = 0;
    _yMinValue = 100000;
    
    _pointsCount = 1;
    _xAxisLineCount = 5;
    
    _dotGapWith = 44;
    
    _graphColor = [UIColor blueColor];
    _pointRadiu = 3;
    _lineSize = 1;
}

//- (void)setYMaxValue:(double)yMaxValue
//{
////    if (yMaxValue == 0) {
////        _yMaxValue = 10;
////    }
////    else
////    {
////        _yMaxValue = yMaxValue;
////    }
//}

- (void)setGraphColor:(UIColor *)graphColor
{
    _graphColor = nil;
    _graphColor = graphColor;
}




@end
