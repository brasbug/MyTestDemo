//
//  GuestTableViewCell.m
//  签到
//
//  Created by Jack on 15/10/20.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "GuestTableViewCell.h"

@interface GuestTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *sexLabel;
@property (nonatomic, weak) IBOutlet UILabel *birthdayLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *signTimeLabel;



@end

@implementation GuestTableViewCell


- (void)setContentData:(UserInfo *)info
{
    self.nameLabel.text = info.name;
    self.sexLabel.text = info.sexual;
    self.birthdayLabel.text = info.birthday;
    self.phoneLabel.text = info.phone;
    self.signTimeLabel.text = info.signTime;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
