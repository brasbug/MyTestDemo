//
//  SigninfoModel.h
//
//  Created by   on 15/10/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SigninfoModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mortlachRareOld;
@property (nonatomic, strong) NSString *knowledgeLevel;
@property (nonatomic, strong) NSString *sexual;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString *potentialBuyLevel;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, assign) NSInteger creatTime;
@property (nonatomic, strong) NSString *mortlach18YO;
@property (nonatomic, strong) NSString *interestLevel;
@property (nonatomic, strong) NSString *otherMalts;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *mortlach25Y;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *otherNumber;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
