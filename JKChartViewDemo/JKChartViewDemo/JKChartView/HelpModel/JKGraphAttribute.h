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



@property (nonatomic, retain) NSArray *pointModelArr;


@property (nonatomic, assign) NSInteger pointsCount; // 点的个数

@property (nonatomic, assign) NSInteger maxValue; // y轴上最大值
@property (nonatomic, assign) NSInteger minValue; // y轴最小值

@property (nonatomic, retain) UIColor* graphColor; // 图形颜色
@property (nonatomic, retain) NSString* graphName; // 图形名称，用于显示某个点的数据时使用



@property (nonatomic, assign) float pointRadiu; // 点的半径大小
@property (nonatomic, assign) float lineSize; // 线条粗细




@end
