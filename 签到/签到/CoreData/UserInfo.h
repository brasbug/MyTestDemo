//
//  UserInfo.h
//  签到
//
//  Created by Jack on 15/10/19.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SigninfoModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (UserInfo *)updateUserInfoWithModel:(SigninfoModel *)model;


@end

NS_ASSUME_NONNULL_END

#import "UserInfo+CoreDataProperties.h"
