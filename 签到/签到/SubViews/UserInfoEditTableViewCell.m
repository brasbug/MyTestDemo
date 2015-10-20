//
//  UserInfoEditTableViewCell.m
//  签到
//
//  Created by Jack on 15/10/20.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "UserInfoEditTableViewCell.h"

@implementation UserInfoEditTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.contentTextField.layer.masksToBounds = YES;
    self.contentTextField.layer.cornerRadius = 5;
    self.contentTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentTextField.layer.borderWidth = 1;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
