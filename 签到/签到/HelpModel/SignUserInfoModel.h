//
//  SignUserInfoModel.h
//
//  Created by   on 15/10/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SignUserInfoModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double mortlachRareOld;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double sexual;
@property (nonatomic, assign) double phone;
@property (nonatomic, assign) double potentialBuyLevel;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *creatTime;
@property (nonatomic, strong) NSString *mail;
@property (nonatomic, assign) double interestLevel;
@property (nonatomic, strong) NSString *otherMalts;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) double mortlach25Y;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) double otherNumber;
@property (nonatomic, assign) double knowledgeLevel;
@property (nonatomic, assign) double mortlach18YO;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
