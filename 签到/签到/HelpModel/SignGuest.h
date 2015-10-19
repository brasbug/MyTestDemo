//
//  SignGuest.h
//
//  Created by   on 15/10/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SignGuest : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) long mortlachRareOld;
@property (nonatomic, assign) long knowledgeLevel;
@property (nonatomic, assign) long sexual;
@property (nonatomic, assign) long phone;
@property (nonatomic, assign) long potentialBuyLevel;
@property (nonatomic, assign) long mortlach18YO;
@property (nonatomic, assign) long interestLevel;
@property (nonatomic, strong) NSString *otherMalts;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) long mortlach25Y;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) long otherNumber;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
