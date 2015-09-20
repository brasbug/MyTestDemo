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
    _chartView.backgroundColor = [UIColor lightGrayColor];
    _chartView.delegate  = self;
//    _chartView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width *2, 200);
    return _chartView;
    
}

- (IBAction)reloadBtnPressed:(id)sender
{
    
    [self formatSomeData];
    
    [self.chartView reloadChartData];
}



- (void)formatSomeData
{
    _graphAttribute = [[JKGraphAttribute alloc]init];
    _graphAttribute.yMinValue = 0;
    _graphAttribute.yMaxValue = 100;
    
    _mutArrlist = [NSMutableArray array];
    for (long i = 0; i< 20 ; i ++) {
        JKPointModel *model = [[JKPointModel alloc]init];
        model.yValueFloat = arc4random()%100;
//        _graphAttribute.yMaxValue = MAX(model.yValueFloat, _graphAttribute.yMaxValue);
//        _graphAttribute.yMinValue = MIN(model.yValueFloat, _graphAttribute.yMinValue);
        
        model.id_m = [NSString stringWithFormat:@"%ld",i];
        model.indext = i;
        model.xPoint = [NSString stringWithFormat:@"%ld月",i +1];
        [_mutArrlist addObject:model];
        
    }
    _graphAttribute.pointsCount = _mutArrlist.count;
    _graphAttribute.pointModelArr = _mutArrlist;
    
    
}



//- (NSInteger)numberOfChartGroup:(JKChartView *)chartView
//{
//    return 1;
//}
- (JKPointModel *)chartView:(JKChartView *)chartView pointModelAtIndextPath:(NSIndexPath *)indextPath
{
//    JKPointButton *pointBtn = [[JKPointButton alloc]init];
//    pointBtn.frame = CGRectMake(0, 0, 30, 30);
//    pointBtn.backColor = [UIColor redColor];
//    pointBtn.pointModel = [_mutArrlist objectAtIndex:indextPath.row];;
    JKPointModel *pointModel =  [_mutArrlist objectAtIndex:indextPath.row];;
    
    return pointModel ;
}


- (JKGraphAttribute *)chartView:(JKChartView *)chartView graphAttributeForGroup:(NSInteger)group
{
    
//    JKGraphAttribute *graphAttribute = [[JKGraphAttribute alloc]init];
//    graphAttribute.pointsCount = 10;
//    graphAttribute.xAxisLineCount = 5;
//    graphAttribute.yMaxValue = 100;
//    graphAttribute.yMinValue = 0;
//    graphAttribute.dotGapWith = 44;
//
    
    return _graphAttribute;
    
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
