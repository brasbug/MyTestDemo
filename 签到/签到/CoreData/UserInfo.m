//
//  UserInfo.m
//  签到
//
//  Created by Jack on 15/10/19.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

// Insert code here to add functionality to your managed object subclass



- (UserInfo *)updateUserInfoWithModel:(SigninfoModel *)model
{
    [self setValuesForKeysWithDictionary:[model dictionaryRepresentation]];
    return self;
}



@end
