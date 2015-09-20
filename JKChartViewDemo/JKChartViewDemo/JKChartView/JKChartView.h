//
//  JKChartView.h
//  JKChartViewDemo
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPointButton.h"
#import "JKPointModel.h"

#import "JKGraphAttribute.h"


@class JKChartView;

@protocol JKChartViewDelegate <NSObject>


//@required

- (JKPointModel *)chartView:(JKChartView *)chartView pointModelAtIndextPath:(NSIndexPath *)indextPath;

- (JKGraphAttribute *)chartView:(JKChartView *)chartView graphAttributeForGroup:(NSInteger)group;


@optional
- (NSInteger)numberOfChartGroup:(JKChartView *)chartView;


@end




@interface JKChartView : UIView

@property (nonatomic, assign) CGFloat dotGapFloat;

@property (nonatomic, assign) long yMaxValue;
@property (nonatomic, assign) long yMinValue;


@property (nonatomic, strong) JKGraphAttribute *graphAttribute;


@property (nonatomic, assign) id<JKChartViewDelegate> delegate;


- (void)reloadChartData;


@end
