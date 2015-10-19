//
//  HomeViewController.m
//  签到
//
//  Created by Jack on 15/10/14.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "HomeViewController.h"

#import "testViewController.h"
#import "ManageCoreData.h"
#import "SigninfoModel.h"


@interface HomeViewController ()

@property (nonatomic, strong) UIImageView *backImageView;




@end

@implementation HomeViewController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    

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
