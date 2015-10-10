//
//  JKGraphAttribute.h
//  JKChartViewDemo
//
//  Created by Jack on 15/9/17.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JKPointModel.h"


@interface JKGraphAttribute : NSObject



@property (nonatomic, strong) NSArray *pointModelArr;


@property (nonatomic, assign) NSInteger pointsCount; // 点的个数
@property (nonatomic, assign) NSInteger xAxisLineCount;

@property (nonatomic, assign) double yMaxValue; // y轴上最大值
@property (nonatomic, assign) double yMinValue; // y轴最小值

@property (nonatomic, copy) NSString *yMaxValueStr; //最大数的字符串形式。

@property (nonatomic, strong) UIColor* graphColor; // 图形颜色
@property (nonatomic, copy) NSString* graphName; // 图形名称，用于显示某个点的数据时使用


@property (nonatomic, assign) CGFloat dotGapWith;


@property (nonatomic, assign) CGFloat pointRadiu; // 点的半径大小
@property (nonatomic, assign) CGFloat lineSize; // 线条粗细




@end
