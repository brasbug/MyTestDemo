//
//  ViewController.m
//  RunTime给Model赋值
//
//  Created by 王磊 on 15/12/16.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableDictionary * _dictDS;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    DataModel * dataModel = [DataModel initWithDictionary:_dictDS];
    
    NSLog(@"%@",dataModel.boyBaby0);
}

- (void)initData
{
    _dictDS = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < 5; i++) {
        
        NSString * keyStr = [NSString stringWithFormat:@"boyBaby%d",i];
        NSString * valueStr = [NSString stringWithFormat:@"我是第%d个男孩",i];

        [_dictDS setObject:valueStr forKey:keyStr];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
