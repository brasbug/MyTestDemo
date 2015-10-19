//
//  SignInViewController.m
//  签到
//
//  Created by Jack on 15/10/19.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
@property (nonatomic, strong) UIImageView *backImageView;

@end

@implementation SignInViewController



- (UIImageView *)backImageView
{
    if (_backImageView) {
        return _backImageView;
    }
    _backImageView = [[UIImageView alloc]init];
    _backImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _backImageView.image = [UIImage imageNamed:@"backImage"];
    return _backImageView;
    
    
}

- (UIColor *)contentitleColor
{
    return [UIColor colorWithRed:145/255.0 green:103/255.0 blue:72/255.0 alpha:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.view addSubview:self.backImageView];
    
    
    
    
    
}
- (IBAction)signBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
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
