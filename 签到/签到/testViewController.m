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
#import "SQFileItem.h"


@interface testViewController ()<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) MFMailComposeViewController *maillController;

@property (nonatomic,strong) NSMutableArray *mutArr;
@property (nonatomic, strong) SQFileItem *zipFileItem;



@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    设置应用程序的状态栏到指定的方向
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    //view旋转
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    // Do any additional setup after loading the view, typically from a nib.
}




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
    
    
    return;
    
    //生产CSV表格文件
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docementDir = [documents objectAtIndex:0];
    NSString *filePath = [docementDir stringByAppendingPathComponent:@"student.csv"];
    [self formatDates];
    [self createFile:filePath];
    [self exportCSV:filePath];
//    ZipArchive *za = [[ZipArchive alloc] init];
//    NSString *zipFilePath = [docementDir stringByAppendingPathComponent:@"sign.zip"];
//    [za CreateZipFile2: zipFilePath];
//    [za addFileToZip:filePath newname:@"student.csv"];

    
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    _maillController = [[MFMailComposeViewController alloc]init];
    _maillController.mailComposeDelegate = self;
    
    if (![[MFMailComposeViewController class]canSendMail]) {
        return;
    }
    
    [_maillController addAttachmentData:data mimeType:@"csv" fileName:filePath];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    [keyWindow.rootViewController presentViewController:_maillController animated:YES completion:^{
    }];
    
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
