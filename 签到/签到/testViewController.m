//
//  ViewController.m
//  签到
//
//  Created by Jack on 15/10/13.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "testViewController.h"

@interface testViewController ()

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    设置应用程序的状态栏到指定的方向
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    //view旋转
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    // Do any additional setup after loading the view, typically from a nib.
}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
//            
//            interfaceOrientation == UIInterfaceOrientationLandscapeRight );
//}


-(void)viewWillAppear:(BOOL)animated
{
    //隐藏navigationController
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];}

- (void)viewWillDisappear:(BOOL)animated
{
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    //显示navigationController
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (IBAction)backBtn:(id)sender {
    //状态栏旋转
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//因为想要手动旋转，所以先关闭自动旋转
- (BOOL)shouldAutorotate{
    return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
