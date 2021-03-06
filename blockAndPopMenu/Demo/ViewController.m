//
//  ViewController.m
//  Demo
//
//  Created by Jack on 14/12/10.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "JKPopMenu.h"
#import "Student.h"
#import <MessageUI/MFMailComposeViewController.h>

typedef void(^myTempBlock)(NSInteger  intext, NSString *str, NSDictionary *dic);

@interface ViewController ()<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) MFMailComposeViewController *maillController;


@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (nonatomic, strong) JKPopMenu *popMenu;
@property (nonatomic, copy) myTempBlock myblock;

@property (nonatomic, strong) void (^printBlock)(NSString *x);

@property (nonatomic,strong) NSMutableArray *mutArr;

@end

@implementation ViewController

#pragma mark - Propertys

- (JKPopMenu *)popMenu {
    if (!_popMenu) {
        NSMutableArray *popMenuItems = [[NSMutableArray alloc] initWithCapacity:6];
        for (int i = 0; i < 5; i ++) {
            NSString *imageName;
            NSString *title;
            switch (i) {
                case 0: {
                    imageName = @"contacts_add_newmessage";
                    title = @"发起群聊";
                    break;
                }
                case 1: {
                    imageName = @"contacts_add_friend";
                    title = @"添加朋友";
                    break;
                }
                case 2: {
                    imageName = @"contacts_add_scan";
                    title = @"扫一扫";
                    break;
                }
                case 3: {
                    imageName = @"contacts_add_photo";
                    title = @"拍照分享";
                    break;
                }
                case 4: {
                    imageName = @"contacts_add_voip";
                    title = @"视频聊天";
                    break;
                }
                default:
                    break;
            }
            JKPopMenuItem *item = [[JKPopMenuItem alloc]initWithImage:[UIImage imageNamed:imageName] title:title];
            [popMenuItems addObject:item];
            
        }
        
        
        _popMenu = [[JKPopMenu alloc] initWithMenus:popMenuItems];
        
        __block ViewController *weakself = self;
        _popMenu.popMenuDidSlectedCompled = ^(NSInteger index, JKPopMenuItem *popMenuItems) {
            weakself.myblock(index,@"aaa",@{@"b":@"a"});
            
        };
    }
    return _popMenu;
}

- (IBAction)btnPressed:(id)sender {
    
//      [self.popMenu showMenuOnView:self.view atPoint:CGPointMake(self.menuBtn.center.x, self.menuBtn.frame.origin.y + self.menuBtn.frame.size.height)];
//     self.myblock(22,@"aaa",@{@"b":@"a"});
    
    
    //生产CSV表格文件
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docementDir = [documents objectAtIndex:0];
    NSString *filePath = [docementDir stringByAppendingPathComponent:@"student.csv"];
    [self formatDates];
    [self createFile:filePath];
    [self exportCSV:filePath];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    _maillController = [[MFMailComposeViewController alloc]init];
    _maillController.mailComposeDelegate = self;
    
    if (![[MFMailComposeViewController class]canSendMail]) {
        return;
    }
    
    [_maillController addAttachmentData:data mimeType:@"txt/csv" fileName:filePath];

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
        NSString *head = @"学号,姓名,性别,手机号\n";
        const uint8_t *headerString = (const uint8_t *)[head cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger headerLength = [head lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        NSInteger result = [output write:headerString maxLength:headerLength];
        if (result <= 0) {
            NSLog(@"写入错误");
        }
        for (long i = 0; i < _mutArr.count; i ++) {
            Student *stu = _mutArr[i];
            NSString *row = [NSString stringWithFormat:@"%@,%@,%@,%@\n",stu.name,stu.num,stu.name,stu.num];
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
    for ( long i = 0; i < 40; i ++) {
        Student *stu = [[Student alloc]init];
        stu.name = [NSString stringWithFormat:@"Name啦啦啦==%ld",i];
        stu.num = [NSString stringWithFormat:@"%ld",i*10];
        [_mutArr addObject:stu];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3"); // 任务3
//    
    
    
//    void (^printBlock)(NSString *x);
    _printBlock = ^(NSString *str)
    {
        NSLog(@"====%@",str);
    };
    _printBlock(@"aaa");
//
//    self.myblock = ^(NSInteger  intext, NSString *str, NSDictionary *dic)
//    {
//        
//    };
//    __block int local = 500;
//    void(^block)(void) = ^(void)
//    {
//        local++;
//        NSLog(@"local:%d", local);
//    };
//    NSLog(@"local:%d", local);
//
//    block();
//    NSLog(@"local:%d", local);
    
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
