//
//  ViewController.m
//  RequestTest
//
//  Created by 张平 on 15/10/15.
//  Copyright © 2015年 zhangping. All rights reserved.
//

#import "ViewController.h"
#import "ZPRequestService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //网络请求时
    [ZPActivityView activityViewForView:self.view withLabel:@"你是那逗比"];
    
    //网络请求完成
    //[ZPActivityView removeViewAnimated:YES];
    
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
