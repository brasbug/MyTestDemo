//
//  JKPointButton.m
//  JKChartViewDemo
//
//  Created by Jack on 15/9/18.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKPointButton.h"

@implementation JKPointButton


- (instancetype)init
{
   self =  [super init];
    if (self) {
        [self initModel];
    }
    return self;
}


- (void)initModel
{
    self.pointModel = [[JKPointModel alloc]init];
}

@end
