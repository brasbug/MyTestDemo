//
//  ViewController.m
//  JKChartViewDemo
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKViewController.h"
#import "JKChartView.h"



@interface JKViewController ()<JKChartViewDelegate>

@property (nonatomic, strong) JKChartView *chartView;


@end

@implementation JKViewController

- (JKChartView *)chartView
{
    if (_chartView) {
        return _chartView;
    }
    _chartView = [[JKChartView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    _chartView.backgroundColor = [UIColor lightGrayColor];
//    _chartView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width *2, 200);
    return _chartView;
    
}

- (IBAction)reloadBtnPressed:(id)sender
{
    [self.chartView reloadChartData];
}


- (NSInteger)numberOfChartGroup:(JKChartView *)chartView
{
    return 1;
}
- (JKPointButton *)chartView:(JKChartView *)chartView pointModelAtIndextPath:(NSIndexPath *)indextPath
{
    JKPointButton *pointBtn;
    return pointBtn;
}


- (JKGraphAttribute *)chartView:(JKChartView *)chartView graphAttributeForGroup:(NSInteger)group
{
    
    JKGraphAttribute *graphAttribute = [[JKGraphAttribute alloc]init];
    graphAttribute.pointsCount = 10;
    graphAttribute.xAxisLineCount = 5;
    graphAttribute.yMaxValue = 100;
    graphAttribute.yMinValue = 0;
    graphAttribute.dotGapWith = 44;
    
    
    
    
    
    
    
    return graphAttribute;
    
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
