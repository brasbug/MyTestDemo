//
//  HomeViewController.m
//  签到
//
//  Created by Jack on 15/10/14.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "HomeViewController.h"
#import "NSDate+Category.h"
#import "NSDate+GMT.h"
#import "UIViewExt.h"

#import "testViewController.h"
#import "ManageCoreData.h"
#import "SigninfoModel.h"

#import "SignInViewController.h"
#import "GuestListTableViewController.h"


#define KWindow [[UIApplication sharedApplication]keyWindow]
#define KWindowRect [UIScreen mainScreen].bounds
#define KdeviceWidth [UIScreen mainScreen].bounds.size.width
#define KdeviceHeight [UIScreen mainScreen].bounds.size.height


@interface HomeViewController ()

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UILabel *birthdayTitleLabel;
@property (nonatomic, strong) UIButton *birthdayBtn;

@property (nonatomic, strong) UIToolbar *toolBarView;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, assign) BOOL isBirthdaySelected;

@property (nonatomic, weak) IBOutlet UIButton *signBtn;


@property (nonatomic, strong) UILabel *nameTitleLabe;
@property (nonatomic, strong) UILabel *phoneTitleLabe;
@property (nonatomic, strong) UILabel *emailTitleLabe;


//@property (nonatomic, strong) UITextField *nametextField;
//@property (nonatomic, strong) UITextField *phoneTextField;
//@property (nonatomic, strong) UITextField *eMailTextField;
//
//@property (nonatomic, strong) UIButton *maleBtn;
//@property (nonatomic, strong) UIButton *femaleBtn;
//

@property (nonatomic, strong) SigninfoModel *model;

@end

@implementation HomeViewController





- (UILabel *)birthdayTitleLabel
{
    if (_birthdayTitleLabel) {
        return _birthdayTitleLabel;
    }
    _birthdayTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 500, 30)];
    _birthdayTitleLabel.textColor = [self contentitleColor];
    _birthdayTitleLabel.text = @"请输入年的出生年月";
    _birthdayTitleLabel.textAlignment = NSTextAlignmentCenter;
    _birthdayTitleLabel.font = [UIFont boldSystemFontOfSize:28];
//    _birthdayTitleLabel.hidden = YES;
    _birthdayTitleLabel.center = CGPointMake(self.birthdayBtn.center.x, self.birthdayBtn.center.y - 70);
    return _birthdayTitleLabel;
}

- (UIButton *)birthdayBtn
{
    if (_birthdayBtn) {
        return _birthdayBtn;
    }
    _birthdayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _birthdayBtn.backgroundColor = [UIColor whiteColor];
    _birthdayBtn.frame = CGRectMake(0, 0, 500, 60);
    _birthdayBtn.layer.masksToBounds = YES;
    _birthdayBtn.layer.cornerRadius = 10;
//    _birthdayBtn.hidden = YES;
    [_birthdayBtn setTitle:@"" forState:UIControlStateNormal];
    _birthdayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [_birthdayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _birthdayBtn.center = self.backImageView.center;
    [_birthdayBtn addTarget:self action:@selector(dateBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    return _birthdayBtn;
}

- (UIDatePicker *)datePicker
{
    if (_datePicker) {
        return _datePicker;
    }
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, KdeviceHeight - 400, KdeviceWidth, 400)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker setMaximumDate:[NSDate getMaxDatePickerDate]];
    [_datePicker setMinimumDate:[NSDate getMinDatePickerDate]];
    [_datePicker setBackgroundColor:[UIColor whiteColor]];
    _datePicker.hidden = YES;
    NSString *tempDateStr = @"1990-01-01";
    NSDate *tempDate = [NSDate dateValueFromString:tempDateStr];
    [_datePicker setDate:tempDate animated:YES];
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    return _datePicker;
}

- (UIImageView *)backImageView
{
    if (_backImageView) {
        return _backImageView;
    }
    _backImageView = [[UIImageView alloc]init];
    _backImageView.frame = self.view.bounds;
    _backImageView.image = [UIImage imageNamed:@"backImage"];
    return _backImageView;
    
    
}

- (UIColor *)contentitleColor
{
    return [UIColor colorWithRed:144/255.0 green:103/255.0 blue:71/255.0 alpha:1];
}


- (UIToolbar *)toolBarView
{
    if (_toolBarView) {
        return _toolBarView;
    }
    _toolBarView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, _datePicker.top - 44, KdeviceWidth, 44)];
//    [_toolBarView setBackgroundImage:[UIImage imageNamed:@"clearColorbg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    _toolBarView.hidden = YES;
    [_toolBarView setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@"完成"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(pickerViewdoneButtonAction)];
    nextItem.tintColor = [self contentitleColor];
    [self.toolBarView setItems:[NSArray arrayWithObjects:spaceItem,nextItem, nil]];
    return _toolBarView;
    
}


#pragma mark - usr method
- (void)datePickerValueChanged:(id)sender
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *selectedDate = self.datePicker.date;
    NSString *birthday    = [dateFormatter stringFromDate:selectedDate];
    [self.birthdayBtn setTitle:birthday forState:UIControlStateNormal];
    self.model.birthday = birthday;
    _isBirthdaySelected = YES;
    self.signBtn.enabled = YES;

}

- (void)dateBtnPressed:(UIButton *)sender
{
    self.datePicker.hidden = NO;
    self.toolBarView.hidden = NO;
    
}
- (void)pickerViewdoneButtonAction
{
    self.datePicker.hidden = YES;
    self.toolBarView.hidden = YES;
}



- (IBAction)signBtnPressed:(id)sender {
    
    
    
    SignInViewController *vc = [[SignInViewController alloc]init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:NO];
    
    [self.birthdayBtn setTitle:@"" forState:UIControlStateNormal];
    self.signBtn.enabled = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.model = [[SigninfoModel alloc]init];
    [self.view addSubview:self.backImageView];
    _isBirthdaySelected = NO;
    self.signBtn.enabled = NO;
    [self.view addSubview:self.birthdayTitleLabel];
    [self.view addSubview:self.birthdayBtn];

    
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.toolBarView];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackView)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    
    
//    for ( long i = 0; i < 10; i ++) {
//        NSDate * timeNow = [NSDate date];
//        sleep(1);
//        NSInteger timeSpInt = [timeNow timeIntervalSince1970];
//        SigninfoModel *model = [[SigninfoModel alloc]init];
//        model.userID = [NSString stringWithFormat:@"%ld",i+1];
//        model.name = @"asdfasdf";
//        model.creatTime = timeSpInt;
//        NSString *filePath = [self dataFilePathWithFileName:@"testFile"];
//        
//        NSLog(@"%@",filePath);
//        [[ManageCoreData instance] insertGuestWithModel:model];
//    }

    NSString *filePath = [self dataFilePathWithFileName:@"testFile"];
    
    NSLog(@"%@",filePath);

    
    
}

- (void)tapBackView
{
    [self pickerViewdoneButtonAction];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self testBtnPressed:nil];
}

-(NSString*)dataFilePathWithFileName:(NSString*)strFileName
{
    NSArray* arrPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //得到沙盒中Docu的完整路径
    NSString* strReturn = [arrPaths objectAtIndex:0];
    //   DLog(@"strReturn = %@",strReturn);
    return [strReturn stringByAppendingPathComponent:strFileName];
}

- (IBAction)testBtnPressed:(id)sender {
    NSArray *arrlist = [[ManageCoreData instance]getAllGuestInfolist];
//    UserInfo *info
    for ( long i = 0; i < arrlist.count; i ++) {
        UserInfo *info = arrlist[i];
        NSLog(@"%@ == > %@",info.userID ,info.creatTime);
    }
    
    testViewController *vc = [[testViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}



- (IBAction)showListBtnPressed:(id)sender {
    
    GuestListTableViewController *vc =  [[GuestListTableViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:^{
        
    }];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation

{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (BOOL)shouldAutorotate

{
    
    return NO;
    
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations

{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
    
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
