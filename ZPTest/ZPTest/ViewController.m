//
//  ViewController.m
//  ZPTest
//
//  Created by 张平 on 15/10/29.
//  Copyright © 2015年 zhangping. All rights reserved.
//

#import "ViewController.h"
#import "ZPAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [ZPAlertView showAlertTitle:@"你的标题" andMsg:@"您确定要退订此消息" cancelButtonTitle:nil otherButtonTitles:nil andBlock:^(NSInteger index,id contxt){
//        if (index == 1) {///确定的tag 值
//            ///做你想做的事
//        }
//    }];
    
    [ZPAlertView showAlertTitle:@"编辑短信内容" andMsg:@"编辑短信内容" cancelButtonTitle:@"取消" otherButtonTitles:@"确定" andBlock:^(NSInteger index,id contxt){
        if (index == 1) {///确定的tag 值
            ///做你想做的事
        }
    }];
    
    ZPTextField *textField = [[ZPTextField alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    textField.NBregEx = REGEX_POWER_TELPHOONE_NUMBER;
    
    [self.view addSubview:textField];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
