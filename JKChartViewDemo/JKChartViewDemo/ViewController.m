//
//  ViewController.m
//  JKChartViewDemo
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "JKChartView.h"



@interface ViewController ()

@property (nonatomic, strong) JKChartView *chartView;


@end

@implementation ViewController

- (JKChartView *)chartView
{
    if (_chartView) {
        return _chartView;
    }
    _chartView = [[JKChartView alloc]init];
    _chartView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200);
    _chartView.backgroundColor = [UIColor lightGrayColor];
//    _chartView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width *2, 200);
    return _chartView;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self.view addSubview:self.chartView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
