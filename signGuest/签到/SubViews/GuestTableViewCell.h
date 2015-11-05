//
//  GuestTableViewCell.h
//  签到
//
//  Created by Jack on 15/10/20.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageCoreData.h"


@interface GuestTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *numberLine;

@property (nonatomic, strong) UserInfo *info;

- (void)setContentData:(UserInfo *)info;


@end
