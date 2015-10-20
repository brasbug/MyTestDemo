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

@interface GuestListTableViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *arrlist;

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
    
    UIButton *allListBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    allListBtn.frame = CGRectMake(0, 0, 60, 44);
    [allListBtn setTitle:@"预览" forState:UIControlStateNormal];
    //    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allListBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    [allListBtn addTarget: self action: @selector(checkAllRecode) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *alllistButtonItem =[[UIBarButtonItem alloc]initWithCustomView:allListBtn];
//    self.navigationItem.rightBarButtonItem = deleteButtonItem;
    [self.navigationItem setRightBarButtonItems:@[alllistButtonItem, deleteButtonItem]];
    
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
    cell.numberLine.text = [NSString stringWithFormat:@"%d",indexPath.row +1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
