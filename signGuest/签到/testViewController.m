//
//  ViewController.m
//  签到
//
//  Created by Jack on 15/10/13.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "testViewController.h"
#import "Student.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "ZipArchive.h"
#import "XCMultiSortTableView.h"
#import "ManageCoreData/ManageCoreData.h"
#import "UserInfoEditTableViewController.h"




@interface testViewController ()<MFMailComposeViewControllerDelegate,XCMultiTableViewDataSource>
{
    NSMutableArray *headData;
    NSMutableArray *leftTableData;
    NSMutableArray *rightTableData;
    NSArray *arrlist;
    XCMultiTableView *tableView;
}
@property (nonatomic, strong) UIButton *backBtn;


@property (nonatomic, strong) MFMailComposeViewController *maillController;

@property (nonatomic,strong) NSMutableArray *mutArr;



@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
//    设置应用程序的状态栏到指定的方向
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    //view旋转
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];

    
    tableView = [[XCMultiTableView alloc] initWithFrame:CGRectInset(self.view.bounds, 5.0f, 5.0f)];
    tableView.leftHeaderEnable = YES;
    tableView.datasource = self;
    [self.view addSubview:tableView];
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.backBtn.frame = CGRectMake(10, 10, 44, 44);
    [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];

    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initData];
    [tableView reloadData];
    
}

- (void)initData {
    headData = [NSMutableArray arrayWithCapacity:10];
    [headData addObject:@"日期"];
    [headData addObject:@"城市"];
    [headData addObject:@"姓名"];
    [headData addObject:@"性别"];
    [headData addObject:@"联系电话"];
    [headData addObject:@"电子邮件"];
    [headData addObject:@"Rare Old"];
    [headData addObject:@"18YO"];
    [headData addObject:@"25YO"];
    [headData addObject:@"Other品牌"];
    [headData addObject:@"Other数量"];
    [headData addObject:@"威士忌知识水平"];
    [headData addObject:@"威士忌感兴趣程度"];
    [headData addObject:@"潜在购买力"];
    leftTableData = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *one = [NSMutableArray arrayWithCapacity:10];
    
    arrlist = [[ManageCoreData instance]getAllGuestInfolist];
    
    
    for (int i = 0; i < arrlist.count; i++) {
        [one addObject:[NSString stringWithFormat:@"%i",i]];
    }
    [leftTableData addObject:one];
    
    
    
    rightTableData = [NSMutableArray arrayWithCapacity:10];
    
    NSMutableArray *oneR = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < arrlist.count; i++) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:10];
        UserInfo *info = arrlist[i];
        if (info.signTime) {
            [tempArr addObject:info.signTime];
        }
        else
        {
            [tempArr addObject:@""];
        }
        
        if (info.city) {
            [tempArr addObject:info.city];
        }
        else
        {
            [tempArr addObject:@""];

        }
        
        if (info.name) {
            [tempArr addObject:info.name];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.sexual) {
            [tempArr addObject:info.sexual];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.phone) {
            [tempArr addObject:info.phone];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.mail) {
            [tempArr addObject:info.mail];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.mortlach_RareOld) {
            [tempArr addObject:info.mortlach_RareOld];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.mortlach_18YO) {
            [tempArr addObject:info.mortlach_18YO];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.mortlach_25Y) {
            [tempArr addObject:info.mortlach_25Y];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.other_Malts) {
            [tempArr addObject:info.other_Malts];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.other_number) {
            [tempArr addObject:info.other_number];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.knowledgeLevel) {
            [tempArr addObject:info.knowledgeLevel];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.interestLevel) {
            [tempArr addObject:info.interestLevel];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        if (info.potentialBuyLevel) {
            [tempArr addObject:info.potentialBuyLevel];
        }
        else
        {
            [tempArr addObject:@""];
            
        }
        
        
 
        [oneR addObject:tempArr];
    }
    [rightTableData addObject:oneR];
    
    
}


#pragma mark - XCMultiTableViewDataSource

- (void)xcmultiSortTableView:(XCMultiTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoEditTableViewController *vc = [[UserInfoEditTableViewController alloc]init];
    UserInfo *info = arrlist[indexPath.row];
    vc.info = info;
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSArray *)arrayDataForTopHeaderInTableView:(XCMultiTableView *)tableView {
    return [headData copy];
}
- (NSArray *)arrayDataForLeftHeaderInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return [leftTableData objectAtIndex:section];
}

- (NSArray *)arrayDataForContentInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return [rightTableData objectAtIndex:section];
}


- (NSUInteger)numberOfSectionsInTableView:(XCMultiTableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(XCMultiTableView *)tableView contentTableCellWidth:(NSUInteger)column {
    if (column == 3) {
        return 50;
    }if (column == 5) {
        return 140;
    }
    if (column > 5) {
        return 85;
    }
    if (column > 10) {
        return 90;
    }
    return 120;
}

- (CGFloat)tableView:(XCMultiTableView *)tableView cellHeightInRow:(NSUInteger)row InSection:(NSUInteger)section {
    if (section == 0) {
        return 60.0f;
    }else {
        return 30.0f;
    }
}

- (UIColor *)tableView:(XCMultiTableView *)tableView bgColorInSection:(NSUInteger)section InRow:(NSUInteger)row InColumn:(NSUInteger)column {
    if (row == 1 && section == 0) {
        return [UIColor whiteColor];
    }
    return [UIColor clearColor];
}

- (UIColor *)tableView:(XCMultiTableView *)tableView headerBgColorInColumn:(NSUInteger)column {
    if (column == -1) {
        return [UIColor whiteColor];
    }else if (column == 1) {
        return [UIColor whiteColor];
    }
    return [UIColor clearColor];
}




-(void)viewWillAppear:(BOOL)animated
{
    //隐藏navigationController
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    //显示navigationController
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    
}
- (void)backBtn:(id)sender {
    //状态栏旋转
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
//    return;
    
//    生产CSV表格文件
//    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docementDir = [documents objectAtIndex:0];
//    NSString *filePath = [docementDir stringByAppendingPathComponent:@"student.csv"];
//    [self formatDates];
//    [self createFile:filePath];
//    [self exportCSV:filePath];
////    ZipArchive *za = [[ZipArchive alloc] init];
////    NSString *zipFilePath = [docementDir stringByAppendingPathComponent:@"sign.zip"];
////    [za CreateZipFile2: zipFilePath];
////    [za addFileToZip:filePath newname:@"student.csv"];
//
//    
//    
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    
//    _maillController = [[MFMailComposeViewController alloc]init];
//    _maillController.mailComposeDelegate = self;
//    
//    if (![[MFMailComposeViewController class]canSendMail]) {
//        return;
//    }
//    
//    [_maillController addAttachmentData:data mimeType:@"csv" fileName:filePath];
//    
//    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
//    [keyWindow.rootViewController presentViewController:_maillController animated:YES completion:^{
//    }];
    
    
}


- (void)alertWithTitle:(NSString *)title  msg:(NSString *)msg
{
    if (title && msg)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}




- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
    
    [_maillController dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)createFile:(NSString *)fileName {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fileName error:nil];
    
    if (![fileManager createFileAtPath:fileName contents:nil attributes:nil]) {
        NSLog(@"不能创建文件");
    }
}



- (void)exportCSV:(NSString *)fileName {
    
    NSOutputStream *output = [[NSOutputStream alloc]initToFileAtPath:fileName append:YES];
    [output open];
    if (![output hasSpaceAvailable]) {
        NSLog(@"没有足够空间");
    }
    else
    {
        NSString *head = @"学号,姓名,性别,手机号,学号,姓名,性别,手机号,手机号,学号,姓名,性别,手机号\n";
        const uint8_t *headerString = (const uint8_t *)[head cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger headerLength = [head lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        NSInteger result = [output write:headerString maxLength:headerLength];
        if (result <= 0) {
            NSLog(@"写入错误");
        }
        for (long i = 0; i < _mutArr.count; i ++) {
            Student *stu = _mutArr[i];
            NSString *row = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@\n",stu.name,stu.num,stu.name,stu.num,stu.name,stu.num,stu.name,stu.num,stu.num,stu.name,stu.num,stu.name,stu.num];
            const uint8_t *rowString = (const uint8_t *)[row cStringUsingEncoding:NSUTF8StringEncoding];
            NSInteger rowLength = [row lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            result = [output write:rowString maxLength:rowLength];
            if (result <= 0) {
                NSLog(@"无法写入内容");
            }
        }
        [output close];
    }
}



- (void)formatDates
{
    _mutArr = [NSMutableArray array];
    for ( long i = 0; i < 2000; i ++) {
        Student *stu = [[Student alloc]init];
        stu.name = [NSString stringWithFormat:@"Name啦啦啦==%ld",i];
        stu.num = [NSString stringWithFormat:@"%ld",i*10];
        [_mutArr addObject:stu];
    }
    
}


//因为想要手动旋转，所以先关闭自动旋转
- (BOOL)shouldAutorotate{
    return NO;
}


@end
