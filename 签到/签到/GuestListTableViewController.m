//
//  GuestListTableViewController.m
//  签到
//
//  Created by Jack on 15/10/20.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "GuestListTableViewController.h"
#import "GuestTableViewCell.h"


@interface GuestListTableViewController ()

@end

@implementation GuestListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    Deletebtn.frame = CGRectMake(0, 0, 100, 44);
    [Deletebtn setTitle:@"清除签到记录" forState:UIControlStateNormal];
    //    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Deletebtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    [Deletebtn addTarget: self action: @selector(DeletebtnPressed) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *deleteButtonItem =[[UIBarButtonItem alloc]initWithCustomView:Deletebtn];
    self.navigationItem.rightBarButtonItem = deleteButtonItem;
    
    
}



- (void)DeletebtnPressed
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"要清除签到记录么？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    [alertview show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
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
    return 5;
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"GuestTableViewCell";
    GuestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"GuestTableViewCell" owner:self options:nil].firstObject;
    }
    return cell;
}


@end
