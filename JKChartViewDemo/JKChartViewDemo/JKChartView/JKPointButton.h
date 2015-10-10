//
//  JKPointButton.h
//  JKChartViewDemo
//
//  Created by Jack on 15/9/18.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPointModel.h"



@interface JKPointButton : UIButton



@property (nonatomic, strong) NSIndexPath *indextPath; //所处数据位置
@property (nonatomic, copy) NSString *contentName; //pop Name;

@property (nonatomic, assign) CGFloat x; //中心坐标
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, copy) NSString *xValue; //x y 数值
@property (nonatomic, copy) NSString *yValue;

@property (nonatomic, copy) NSString *xLabelText; //x描述文字
@property (nonatomic, copy) NSString *yLabelText; //y描述文字



@property (nonatomic, assign) NSInteger radius; //半径
@property (nonatomic, strong) UIColor *backColor;

@property (nonatomic, strong) JKPointModel *pointModel;

@end
