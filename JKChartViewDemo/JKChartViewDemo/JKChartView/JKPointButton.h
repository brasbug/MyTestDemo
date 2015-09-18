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



@property (nonatomic, retain) NSIndexPath *indextPath; //所处数据位置
@property (nonatomic, retain) NSString *contentName; //pop Name;

@property (nonatomic, assign) CGFloat x; //中心坐标
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, retain) NSString *xValue; //x y 数值
@property (nonatomic, retain) NSString *yValue;

@property (nonatomic, retain) NSString *xLabelText; //x描述文字
@property (nonatomic, retain) NSString *yLabelText; //y描述文字



@property (nonatomic, assign) NSInteger radius; //半径
@property (nonatomic, retain) UIColor *backColor;

@property (nonatomic, retain) JKPointModel *pointModel;

@end
