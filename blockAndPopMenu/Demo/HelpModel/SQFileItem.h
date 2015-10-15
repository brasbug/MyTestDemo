//
//  SQFileItem.h
//
//  Created by Li Huazhen on 15/6/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SQFileItem : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *fileFolderPath;
@property (nonatomic, strong) NSString *fileType;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *filePaht;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
