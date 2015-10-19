//
//  ManageCoreData.h
//  签到
//
//  Created by Jack on 15/10/19.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SigninfoModel.h"
#import "UserInfo+CoreDataProperties.h"


@interface ManageCoreData : NSObject

@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;


-(NSManagedObjectModel *)managedObjectModel;
-(NSManagedObjectContext *)managedObjectContext;
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectContext *)privateContext;
- (NSManagedObject *)createEntity:(NSString *)entityName;

+(ManageCoreData*)instance;
-(BOOL)saveContext;


- (UserInfo *)insertGuestWithModel:(SigninfoModel *)model;

- (NSArray *)getAllGuestInfolist;


@end
