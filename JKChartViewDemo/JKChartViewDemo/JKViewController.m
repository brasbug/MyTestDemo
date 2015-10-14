//
//  ViewController.m
//  JKChartViewDemo
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKViewController.h"
#import "JKChartView.h"



@interface JKViewController ()


@property (nonatomic, strong) JKChartView *chartView;

@property (nonatomic, strong) NSMutableArray *mutArrlist;
@property (nonatomic, strong)  JKGraphAttribute *graphAttribute;

@end

@implementation JKViewController

- (JKChartView *)chartView
{
    if (_chartView) {
        return _chartView;
    }
    _chartView = [[JKChartView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    _chartView.backgroundColor = [UIColor whiteColor];
//    _chartView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width *2, 200);
    return _chartView;
    
}

- (IBAction)reloadBtnPressed:(id)sender
{
    
    [self formatSomeData];
    self.chartView.graphAttribute = self.graphAttribute;
    [self.chartView reloadChartData:self.graphAttribute];
}



- (void)formatSomeData
{
    _graphAttribute = [[JKGraphAttribute alloc]init];
    _graphAttribute.yMinValue = 0;
    _graphAttribute.yMaxValue = 0;
    
    _mutArrlist = [NSMutableArray array];
    for (long i = 0; i< 20 ; i ++) {
        JKPointModel *model = [[JKPointModel alloc]init];
        model.yValueFloat = (arc4random()%80 +20 );
        _graphAttribute.yMaxValue = MAX(model.yValueFloat, _graphAttribute.yMaxValue);
//        _graphAttribute.yMinValue = MIN(model.yValueFloat, _graphAttribute.yMinValue);
        
        model.pointindext = [NSString stringWithFormat:@"%ld",i];
        model.indext = i;
        model.xPoint = [NSString stringWithFormat:@"%ld月",i +1];
        model.yPoint = [NSString stringWithFormat:@"%.0f",model.yValueFloat];
        model.yPointValue =  [NSString stringWithFormat:@"%.0f万",model.yValueFloat];;
        [_mutArrlist addObject:model];
        
    }
    _graphAttribute.pointsCount = _mutArrlist.count;
    _graphAttribute.pointModelArr = _mutArrlist.mutableCopy;
    
    
}


//- (JKGraphAttribute *)chartView:(JKChartView *)chartView graphAttributeForGroup:(NSInteger)group
//{
//
//    return _graphAttribute;
//    
//}


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
