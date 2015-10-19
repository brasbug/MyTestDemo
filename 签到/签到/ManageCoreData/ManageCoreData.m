//
//  ManageCoreData.m
//  签到
//
//  Created by Jack on 15/10/19.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "ManageCoreData.h"



@implementation ManageCoreData


+(ManageCoreData*)instance
{
    static ManageCoreData *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ManageCoreData alloc]init];
        NSLog(@"%@",manager.managedObjectContext);
        
    });
    return manager;
}

#pragma mark -
#pragma mark - Save Context
-(void)saveContext{
    NSError *error = NULL;
    NSManagedObjectContext *moc = self.managedObjectContext;
    if (moc && [moc hasChanges] && ![moc save:&error]) {
        NSLog(@"Error %@ ,%@",error,[error localizedDescription]);
        abort();
    }
    
}

#pragma mark - Core Data Stack
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    //中的nil表示连接项目中所有的 .xcodemodel 文件为一个datamodel，这是一个非常好的方法，把多个entity放在各自的xcodemodel文件中分开管理，然后用这个函数连接起来生成一个datamodel，这样就可以对应一个persistentStore。
    return _managedObjectModel;
    
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (nil != _managedObjectContext) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    if (self.persistentStoreCoordinator) {
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _managedObjectContext;
}
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (nil != _persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    NSString *storeType = NSSQLiteStoreType;
    NSString *storeName = @"GuestMode.sqlite";
    NSError *error = NULL;
    NSURL *storeURL = [NSURL fileURLWithPath:[[self applicationDocumentsDirectory] stringByAppendingPathComponent:storeName]];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption, nil];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"Error :%@\n",[error localizedDescription]);
        NSAssert1(YES, @"Failed to create store %@ with NSSQLiteStoreType", [storeURL path]);
    }
    
    return _persistentStoreCoordinator;
}
#pragma mark Application's Documents Directory

- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (NSManagedObjectContext *)privateContext
{
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    moc.parentContext = self.managedObjectContext;
    return moc;
}

- (NSManagedObject *)createEntity:(NSString *)entityName
{
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                         inManagedObjectContext:self.managedObjectContext];
    return obj;
}




- (UserInfo *)insertGuestWithModel:(SignUserInfoModel *)model
{
    UserInfo *info = [self fechGuestWithId:model.userID];
    info = [info updateUserInfoWithModel:model];
    [self saveContext];
    return info;
}




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
