//
//  JKChartView.h
//  JKChartViewDemo
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKChartViewDelegate <NSObject>

- (NSInteger)numberOfChartGroup;

//- ()

@end




@interface JKChartView : UIView

- (void)reloadChartData;


@end
