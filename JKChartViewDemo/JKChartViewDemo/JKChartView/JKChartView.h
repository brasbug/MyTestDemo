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
#import "NSDate+TuanHelper.h"

#import "JKGraphAttribute.h"



@interface JKChartView : UIView

@property (nonatomic, assign) CGFloat dotGapFloat;

@property (nonatomic, assign) long yMaxValue;
@property (nonatomic, assign) long yMinValue;


@property (nonatomic, strong) JKGraphAttribute *graphAttribute;

- (void)reloadChartData:(JKGraphAttribute *)graphAtribute;



@end
