//
//  SignInViewController.m
//  签到
//
//  Created by Jack on 15/10/19.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SignInViewController.h"
#import "ManageCoreData.h"

@interface SignInViewController ()
@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, weak) IBOutlet UIButton *maleBtn;
@property (nonatomic, weak) IBOutlet UIButton *femaleBtn;
@property (nonatomic, weak) IBOutlet UIButton *maleBtn1;
@property (nonatomic, weak) IBOutlet UIButton *femaleBtn1;

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *eMailTextField;



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
    
    self.nameTextField.layer.masksToBounds = YES;
    self.nameTextField.layer.cornerRadius = 10;

    self.phoneTextField.layer.masksToBounds = YES;
    self.phoneTextField.layer.cornerRadius = 10;
    self.eMailTextField.keyboardType = UIKeyboardTypeNumberPad;

    self.eMailTextField.layer.masksToBounds = YES;
    self.eMailTextField.layer.cornerRadius = 10;
    self.eMailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackView)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    
}


- (IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)tapBackView
{
    [self.view endEditing:YES];
    
}
- (IBAction)signBtnPressed:(id)sender {
    
    if ([self isEmpty]) {
        return;
    }
    
    self.model.name = self.nameTextField.text;
    self.model.phone = self.phoneTextField.text;
    self.model.mail = self.eMailTextField.text;
    if (self.maleBtn1.enabled) {
        self.model.sexual = @"男";
    }
    else
    {
        self.model.sexual = @"女";
    }
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    self.model.signTime = [NSString stringWithFormat:@"%@",localeDate];
    self.model.creatTime = [localeDate timeIntervalSince1970];
    self.model.userID = [[NSString alloc]initWithFormat:@"%ld-%@",(long)self.model.creatTime,self.model.name];
    
    
    UserInfo *info =     [[ManageCoreData instance]insertGuestWithModel:self.model];
    
//    for (long i = 0; i < 1000; i ++) {
//        NSDate *date = [NSDate date];
//        
//        NSTimeZone *zone = [NSTimeZone systemTimeZone];
//        
//        NSInteger interval = [zone secondsFromGMTForDate: date];
//        
//        NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//        self.model.name = [NSString stringWithFormat:@"test- > %ld",i];
//        self.model.signTime = [NSString stringWithFormat:@"%@",localeDate];
//        self.model.creatTime = [localeDate timeIntervalSince1970] + i* 10;
//        self.model.userID = [[NSString alloc]initWithFormat:@"%ld-%@",(long)self.model.creatTime + i *10,self.model.name];
//        [[ManageCoreData instance]insertGuestWithModel:self.model];
//        
//    }
    
    
    if (info) {
        [self.navigationController popViewControllerAnimated:NO];
        [self showAlertViewWith:@"签到成功"];
    }
    else
    {
        [self showAlertViewWith:@"签到失败"];
    }
   
    
    
    
    
    
    
}


- (BOOL)isEmpty
{
    if (self.nameTextField.text.length == 0 ) {
        [self showAlertViewWith:@"请输入您的姓名"];
        return YES;
    }
    if (self.phoneTextField.text.length == 0 ) {
        [self showAlertViewWith:@"请输入您的手机号"];
        return YES;
    }
    if (self.eMailTextField.text.length == 0 ) {
        [self showAlertViewWith:@"请输入您的邮箱"];
        return YES;
    }
    
    return NO;
}


- (void)showAlertViewWith:(NSString *)message
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertview show];
}


- (IBAction)maileBtnPressed:(id)sender {
    self.maleBtn1.enabled = YES;
    self.femaleBtn1.enabled = NO;
    
    
}

- (IBAction)femalebtnPressed:(id)sender {
    self.maleBtn1.enabled = NO;
    self.femaleBtn1.enabled = YES;
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
