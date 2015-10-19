//
//  HomeViewController.m
//  签到
//
//  Created by Jack on 15/10/14.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "HomeViewController.h"

#import "testViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.








}
- (IBAction)testBtnPressed:(id)sender {
    testViewController *vc = [[testViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
