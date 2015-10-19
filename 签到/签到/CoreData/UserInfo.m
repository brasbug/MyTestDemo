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



- (id)fechGuestWithId:(NSString *)userID
{
    NSString *entityName = NSStringFromClass([self class]);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    request.predicate = [NSPredicate predicateWithFormat:@"userID = %@",userID];
    NSArray *arr = [self.managedObjectContext executeFetchRequest:request error:nil];
    if (arr.count) {
        return arr.firstObject;
    }
    UserInfo *userInfo = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                    inManagedObjectContext:self.managedObjectContext];
    userInfo.userID = userID;
    return userInfo;
    
    return nil;
}




@end
