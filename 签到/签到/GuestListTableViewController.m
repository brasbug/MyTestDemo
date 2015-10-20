//
//  GuestListTableViewController.m
//  签到
//
//  Created by Jack on 15/10/20.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "GuestListTableViewController.h"
#import "GuestTableViewCell.h"
#import "ManageCoreData.h"
#import "testViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "UserInfoEditTableViewController.h"



@interface GuestListTableViewController ()<UIAlertViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSArray *arrlist;



@property (nonatomic, strong) MFMailComposeViewController *maillController;

@property (nonatomic,strong) NSMutableArray *mutArr;

@end

@implementation GuestListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrlist = [[ManageCoreData instance]getAllGuestInfolist];
    //    UserInfo *info
//    for ( long i = 0; i < arrlist.count; i ++) {
//        UserInfo *info = arrlist[i];
//        NSLog(@"%@ == > %@",info.userID ,info.creatTime);
//    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    
    
    [self setNavBar];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _arrlist = [[ManageCoreData instance]getAllGuestInfolist];
    [self.tableView reloadData];
}

- (void)setNavBar
{
    
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backbtn.frame = CGRectMake(0, 0, 60, 44);
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    //    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backbtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    [backbtn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem =[[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;

    
    
    UIButton *Deletebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    Deletebtn.frame = CGRectMake(0, 0, 60, 44);
    [Deletebtn setTitle:@"清除记录" forState:UIControlStateNormal];
    //    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Deletebtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    [Deletebtn addTarget: self action: @selector(DeletebtnPressed) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *deleteButtonItem =[[UIBarButtonItem alloc]initWithCustomView:Deletebtn];
    
    
    UIButton *sendEmailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sendEmailBtn.frame = CGRectMake(0, 0, 100, 44);
    [sendEmailBtn setTitle:@"发送到邮箱" forState:UIControlStateNormal];
    //    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendEmailBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    [sendEmailBtn addTarget: self action: @selector(sendEmailBtnItemPressed) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *sendEmailBtnItem =[[UIBarButtonItem alloc]initWithCustomView:sendEmailBtn];
    
    UIButton *allListBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    allListBtn.frame = CGRectMake(0, 0, 60, 44);
    [allListBtn setTitle:@"预览" forState:UIControlStateNormal];
    //    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allListBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    [allListBtn addTarget: self action: @selector(checkAllRecode) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *alllistButtonItem =[[UIBarButtonItem alloc]initWithCustomView:allListBtn];
//    self.navigationItem.rightBarButtonItem = deleteButtonItem;
    [self.navigationItem setRightBarButtonItems:@[alllistButtonItem,sendEmailBtnItem, deleteButtonItem]];
    
}

- (void)sendEmailBtnItemPressed
{
    
//    生产CSV表格文件
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docementDir = [documents objectAtIndex:0];
    NSString *filePath = [docementDir stringByAppendingPathComponent:@"签到.csv"];

    [self createFile:filePath];
    [self exportCSV:filePath];
    NSArray *Address = @[@"369495368@qq.com"];
    NSString *emailBody =[NSString stringWithFormat: @"发送用户记录,下载附件，修改附件后缀名为.csv   可以使用金山WPS的表格打开 或者参考链接:http://jingyan.baidu.com/article/76a7e409bf9a3ffc3b6e1535.html 使用office的表格打开"];
    
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    _maillController = [[MFMailComposeViewController alloc]init];
    _maillController.mailComposeDelegate = self;
    [_maillController setToRecipients:Address];
    [_maillController setMessageBody:emailBody isHTML:NO];
    [_maillController setSubject:@"签到记录"];
    if (![[MFMailComposeViewController class]canSendMail]) {
        return;
    }
    
    [_maillController addAttachmentData:data mimeType:@"csv" fileName:filePath];
    
//    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    [self presentViewController:_maillController animated:YES completion:^{
    }];

    
    
    
}

- (void)checkAllRecode
{
    
    
    testViewController *vc = [[testViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)DeletebtnPressed
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"要清除签到记录么？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    [alertview show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[ManageCoreData instance]deleteAllGuestInfo];
        self.arrlist = @[];
        [self.tableView reloadData];
    }
    
}

- (void)goBackAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _arrlist.count;
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"GuestTableViewCell";
    GuestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"GuestTableViewCell" owner:self options:nil].firstObject;
    }
    UserInfo *info = _arrlist[indexPath.row];
    [cell setContentData:info];
    cell.numberLine.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserInfo *info = _arrlist[indexPath.row];
    UserInfoEditTableViewController *vc = [[UserInfoEditTableViewController alloc]init];
    vc.info = info;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
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
        NSString *head = @"日期,城市,姓名,性别,联系电话,电子邮件,Raro Old,18YO,25YO,Other品牌,Ohter数量,威士忌知识水平,威士忌感兴趣程度,潜在购买力\n";
        const uint8_t *headerString = (const uint8_t *)[head cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger headerLength = [head lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        NSInteger result = [output write:headerString maxLength:headerLength];
        if (result <= 0) {
            NSLog(@"写入错误");
        }
        NSArray *arrlist = [[ManageCoreData instance]getAllGuestInfolist];
        for (long i = 0; i < arrlist.count; i ++) {
            UserInfo *info = arrlist[i];
            NSString *row = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@\n",info.signTime,info.city,info.name,info.sexual,info.phone,info.mail,info.mortlach_RareOld,info.mortlach_18YO,info.mortlach_25Y,info.other_Malts,info.other_number,info.knowledgeLevel,info.interestLevel,info.potentialBuyLevel];
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




@end
