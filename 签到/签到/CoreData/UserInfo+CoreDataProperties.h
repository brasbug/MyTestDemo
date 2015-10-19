//
//  UserInfo+CoreDataProperties.h
//  签到
//
//  Created by Jack on 15/10/19.
//  Copyright © 2015年 Jack. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *sexual;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *birthday;
@property (nullable, nonatomic, retain) NSString *mail;
@property (nullable, nonatomic, retain) NSNumber *mortlach_RareOld;
@property (nullable, nonatomic, retain) NSNumber *mortlach_18YO;
@property (nullable, nonatomic, retain) NSNumber *mortlach_25Y;
@property (nullable, nonatomic, retain) NSString *other_Malts;
@property (nullable, nonatomic, retain) NSNumber *other_number;
@property (nullable, nonatomic, retain) NSNumber *knowledgeLevel;
@property (nullable, nonatomic, retain) NSNumber *interestLevel;
@property (nullable, nonatomic, retain) NSNumber *potentialBuyLevel;
@property (nullable, nonatomic, retain) NSNumber *creatTime;
@property (nullable, nonatomic, retain) NSString *userID;

@end

NS_ASSUME_NONNULL_END
