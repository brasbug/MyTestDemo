//
//  UserInfoEditTableViewController.m
//  签到
//
//  Created by Jack on 15/10/20.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "UserInfoEditTableViewController.h"
#import "UserInfoEditTableViewCell.h"
#import "SigninfoModel.h"

@interface UserInfoEditTableViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *headData;
@property (nonatomic, strong) SigninfoModel *model;

@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation UserInfoEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    self.info.name = @"test";
//    [[ManageCoreData instance]saveContext];
//    
    [self initData];
    self.tableView.tableFooterView = [[UILabel alloc]init];
    [self.tableView reloadData];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    UIButton *allListBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    allListBtn.frame = CGRectMake(0, 0, 60, 44);
    [allListBtn setTitle:@"保存" forState:UIControlStateNormal];
    //    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allListBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    [allListBtn addTarget: self action: @selector(saveData) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *alllistButtonItem =[[UIBarButtonItem alloc]initWithCustomView:allListBtn];
    //    self.navigationItem.rightBarButtonItem = deleteButtonItem;
    [self.navigationItem setRightBarButtonItems:@[alllistButtonItem]];
    
    
}
- (void)saveData
{
    [[ManageCoreData instance]insertGuestWithModel:self.model];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)initData
{
    self.model = [[SigninfoModel alloc]init];
    self.model.signTime = self.info.signTime;
    self.model.city = self.info.city;
    self.model.name = self.info.name;
    self.model.sexual = self.info.sexual;
    self.model.phone = self.info.phone;
    self.model.birthday = self.info.birthday;
    
    self.model.mail = self.info.mail;
    self.model.mortlachRareOld = self.info.mortlach_RareOld;
    self.model.mortlach18YO = self.info.mortlach_18YO;
    self.model.mortlach25Y = self.info.mortlach_25Y;
    self.model.otherMalts = self.info.other_Malts;
    self.model.otherNumber  = self.info.other_number;
    self.model.knowledgeLevel = self.info.knowledgeLevel;
    self.model.interestLevel = self.info.interestLevel;
    self.model.potentialBuyLevel = self.info.potentialBuyLevel;
    self.model.creatTime = self.info.creatTime.integerValue;
    self.model.userID = self.info.userID;
    
    _headData = [NSMutableArray arrayWithCapacity:10];
    [_headData addObject:@"日期"];
    [_headData addObject:@"城市"];
    [_headData addObject:@"姓名"];
    [_headData addObject:@"性别"];
    [_headData addObject:@"联系电话"];
    [_headData addObject:@"电子邮件"];
    [_headData addObject:@"Rare Old"];
    [_headData addObject:@"18YO"];
    [_headData addObject:@"25YO"];
    [_headData addObject:@"Other品牌"];
    [_headData addObject:@"Other数量"];
    [_headData addObject:@"知识水平"];
    [_headData addObject:@"感兴趣程度"];
    [_headData addObject:@"潜在购买力"];

}

- (void)textfieldDidChanged:(UITextField *)textField
{
    if (textField.tag == 1) {
        self.model.city = textField.text;
        
    }
    else if (textField.tag == 6) {
        self.model.mortlachRareOld = textField.text;
        
    }
    else if (textField.tag == 7) {
        self.model.mortlach18YO = textField.text;
        
    }
    else if (textField.tag == 8) {
        self.model.mortlach25Y = textField.text;
       
    }
    else if (textField.tag == 9) {
        self.model.otherMalts = textField.text;
       
    }
    else if (textField.tag == 10) {
        self.model.otherNumber = textField.text;
    }
    
    
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _headData.count;
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"UserInfoEditTableViewCell";
    UserInfoEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"UserInfoEditTableViewCell" owner:self options:nil].firstObject;
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString *tempStr = _headData[indexPath.row];
    cell.titleLabel.text = tempStr;
    if ([tempStr isEqualToString:@"日期"]) {
        cell.contentTextField.text = self.model.signTime;
        cell.contentTextField.enabled = NO;
    }
    cell.contentTextField.delegate = self;
     [cell.contentTextField addTarget:self action:@selector(textfieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    cell.contentTextField.tag = indexPath.row;

    if ([tempStr isEqualToString:@"城市"]) {
        cell.contentTextField.text = self.model.city;
        cell.contentTextField.enabled = YES;
       
    }
    
    if ([tempStr isEqualToString:@"姓名"]) {
        cell.contentTextField.text = self.model.name;
        cell.contentTextField.enabled = NO;
    }
    
    if ([tempStr isEqualToString:@"性别"]) {
        cell.contentTextField.text = self.model.sexual;
        cell.contentTextField.enabled = NO;
    }
    
    if ([tempStr isEqualToString:@"联系电话"]) {
        cell.contentTextField.text = self.model.phone;
        cell.contentTextField.enabled = NO;
    }
    
    if ([tempStr isEqualToString:@"电子邮件"]) {
        cell.contentTextField.text = self.model.mail;
        cell.contentTextField.enabled = NO;
    }
    
    if ([tempStr isEqualToString:@"Rare Old"]) {
        cell.contentTextField.text = self.model.mortlachRareOld;
        cell.contentTextField.enabled = YES;
        cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if ([tempStr isEqualToString:@"18YO"]) {
        cell.contentTextField.text = self.model.mortlach18YO;
        cell.contentTextField.enabled = YES;
        cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if ([tempStr isEqualToString:@"25YO"]) {
        cell.contentTextField.text = self.model.mortlach25Y;
        cell.contentTextField.enabled = YES;
        cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
   
    
    if ([tempStr isEqualToString:@"Other品牌"]) {
        cell.contentTextField.text = self.model.otherMalts;
        cell.contentTextField.enabled = YES;
    }
    
    if ([tempStr isEqualToString:@"Other数量"]) {
        cell.contentTextField.text = self.model.otherNumber;
        cell.contentTextField.enabled = YES;
        cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    
    if ([tempStr isEqualToString:@"知识水平"]) {
        cell.contentTextField.text = self.model.knowledgeLevel;
        cell.contentTextField.enabled = NO;
    }
    
    
    if ([tempStr isEqualToString:@"感兴趣程度"]) {
        cell.contentTextField.text = self.model.interestLevel;
        cell.contentTextField.enabled = NO;
    }
    
    
    if ([tempStr isEqualToString:@"潜在购买力"]) {
        cell.contentTextField.text = self.model.potentialBuyLevel;
        cell.contentTextField.enabled = NO;
    }
    cell.contentTextField.backgroundColor = [UIColor clearColor];
    if (cell.contentTextField.enabled || indexPath.row > 10) {
        cell.contentTextField.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.102];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    
    NSString *tempStr = _headData[indexPath.row];
    UIAlertView *alertview;
    if ([tempStr isEqualToString:@"知识水平"]) {
        alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"选择相应等级" delegate:self cancelButtonTitle:nil otherButtonTitles:@"高",@"中等",@"初级",nil];
       
    }
    
    
    if ([tempStr isEqualToString:@"感兴趣程度"]) {
        alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"选择相应等级" delegate:self cancelButtonTitle:nil otherButtonTitles:@"高",@"一般",@"无",nil];
    }
    
    
    if ([tempStr isEqualToString:@"潜在购买力"]) {
        alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"选择相应等级" delegate:self cancelButtonTitle:nil otherButtonTitles:@"强",@"中",@"弱",nil];
    }
    alertview.tag = indexPath.row;
    [alertview show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 11) {
        if (buttonIndex == 0) {
            self.model.knowledgeLevel = @"高";
        }
        else if (buttonIndex == 1) {
            self.model.knowledgeLevel = @"中等";
        }
        else if (buttonIndex == 2) {
            self.model.knowledgeLevel = @"初级";
        }
    }
    
    if (alertView.tag == 12) {
        if (buttonIndex == 0) {
            self.model.interestLevel = @"高";
        }
        else if (buttonIndex == 1) {
            self.model.interestLevel = @"一般";
        }
        else if (buttonIndex == 2) {
            self.model.interestLevel = @"无";
        }
    }
    if (alertView.tag == 13) {
        if (buttonIndex == 0) {
            self.model.potentialBuyLevel = @"强";
        }
        else if (buttonIndex == 1) {
            self.model.potentialBuyLevel = @"中";
        }
        else if (buttonIndex == 2) {
            self.model.potentialBuyLevel = @"弱";
        }
    }
    
    [self.tableView reloadData];
}



@end
