//
//  SigninfoModel.m
//
//  Created by   on 15/10/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SigninfoModel.h"


NSString *const kSigninfoModelMortlachRareOld = @"mortlach_RareOld";
NSString *const kSigninfoModelKnowledgeLevel = @"knowledgeLevel";
NSString *const kSigninfoModelSexual = @"sexual";
NSString *const kSigninfoModelPhone = @"phone";
NSString *const kSigninfoModelPotentialBuyLevel = @"potentialBuyLevel";
NSString *const kSigninfoModelUserID = @"userID";
NSString *const kSigninfoModelCreatTime = @"creatTime";
NSString *const kSigninfoModelMortlach18YO = @"mortlach_18YO";
NSString *const kSigninfoModelInterestLevel = @"interestLevel";
NSString *const kSigninfoModelOtherMalts = @"other_Malts";
NSString *const kSigninfoModelDate = @"date";
NSString *const kSigninfoModelMortlach25Y = @"mortlach_25Y";
NSString *const kSigninfoModelCity = @"city";
NSString *const kSigninfoModelOtherNumber = @"other_number";
NSString *const kSigninfoModelName = @"name";
NSString *const kSigninfoModelMail = @"mail";


@interface SigninfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SigninfoModel

@synthesize mortlachRareOld = _mortlachRareOld;
@synthesize knowledgeLevel = _knowledgeLevel;
@synthesize sexual = _sexual;
@synthesize phone = _phone;
@synthesize potentialBuyLevel = _potentialBuyLevel;
@synthesize userID = _userID;
@synthesize creatTime = _creatTime;
@synthesize mortlach18YO = _mortlach18YO;
@synthesize interestLevel = _interestLevel;
@synthesize otherMalts = _otherMalts;
@synthesize date = _date;
@synthesize mortlach25Y = _mortlach25Y;
@synthesize city = _city;
@synthesize otherNumber = _otherNumber;
@synthesize name = _name;
@synthesize mail = _mail;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.mortlachRareOld = [self objectOrNilForKey:kSigninfoModelMortlachRareOld fromDictionary:dict];
            self.knowledgeLevel = [self objectOrNilForKey:kSigninfoModelKnowledgeLevel fromDictionary:dict];
            self.sexual = [self objectOrNilForKey:kSigninfoModelSexual fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kSigninfoModelPhone fromDictionary:dict];
            self.potentialBuyLevel = [self objectOrNilForKey:kSigninfoModelPotentialBuyLevel fromDictionary:dict];
            self.userID = [self objectOrNilForKey:kSigninfoModelUserID fromDictionary:dict];
            self.creatTime = [[self objectOrNilForKey:kSigninfoModelCreatTime fromDictionary:dict] integerValue];
            self.mortlach18YO = [self objectOrNilForKey:kSigninfoModelMortlach18YO fromDictionary:dict];
            self.interestLevel = [self objectOrNilForKey:kSigninfoModelInterestLevel fromDictionary:dict];
            self.otherMalts = [self objectOrNilForKey:kSigninfoModelOtherMalts fromDictionary:dict];
            self.date = [self objectOrNilForKey:kSigninfoModelDate fromDictionary:dict];
            self.mortlach25Y = [self objectOrNilForKey:kSigninfoModelMortlach25Y fromDictionary:dict];
            self.city = [self objectOrNilForKey:kSigninfoModelCity fromDictionary:dict];
            self.otherNumber = [self objectOrNilForKey:kSigninfoModelOtherNumber fromDictionary:dict];
            self.name = [self objectOrNilForKey:kSigninfoModelName fromDictionary:dict];
            self.mail = [self objectOrNilForKey:kSigninfoModelMail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mortlachRareOld forKey:kSigninfoModelMortlachRareOld];
    [mutableDict setValue:self.knowledgeLevel forKey:kSigninfoModelKnowledgeLevel];
    [mutableDict setValue:self.sexual forKey:kSigninfoModelSexual];
    [mutableDict setValue:self.phone forKey:kSigninfoModelPhone];
    [mutableDict setValue:self.potentialBuyLevel forKey:kSigninfoModelPotentialBuyLevel];
    [mutableDict setValue:self.userID forKey:kSigninfoModelUserID];
    [mutableDict setValue:[NSNumber numberWithInteger:self.creatTime] forKey:kSigninfoModelCreatTime];
    [mutableDict setValue:self.mortlach18YO forKey:kSigninfoModelMortlach18YO];
    [mutableDict setValue:self.interestLevel forKey:kSigninfoModelInterestLevel];
    [mutableDict setValue:self.otherMalts forKey:kSigninfoModelOtherMalts];
    [mutableDict setValue:self.date forKey:kSigninfoModelDate];
    [mutableDict setValue:self.mortlach25Y forKey:kSigninfoModelMortlach25Y];
    [mutableDict setValue:self.city forKey:kSigninfoModelCity];
    [mutableDict setValue:self.otherNumber forKey:kSigninfoModelOtherNumber];
    [mutableDict setValue:self.name forKey:kSigninfoModelName];
    [mutableDict setValue:self.mail forKey:kSigninfoModelMail];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.mortlachRareOld = [aDecoder decodeObjectForKey:kSigninfoModelMortlachRareOld];
    self.knowledgeLevel = [aDecoder decodeObjectForKey:kSigninfoModelKnowledgeLevel];
    self.sexual = [aDecoder decodeObjectForKey:kSigninfoModelSexual];
    self.phone = [aDecoder decodeObjectForKey:kSigninfoModelPhone];
    self.potentialBuyLevel = [aDecoder decodeObjectForKey:kSigninfoModelPotentialBuyLevel];
    self.userID = [aDecoder decodeObjectForKey:kSigninfoModelUserID];
    self.creatTime = [aDecoder decodeIntegerForKey:kSigninfoModelCreatTime];
    self.mortlach18YO = [aDecoder decodeObjectForKey:kSigninfoModelMortlach18YO];
    self.interestLevel = [aDecoder decodeObjectForKey:kSigninfoModelInterestLevel];
    self.otherMalts = [aDecoder decodeObjectForKey:kSigninfoModelOtherMalts];
    self.date = [aDecoder decodeObjectForKey:kSigninfoModelDate];
    self.mortlach25Y = [aDecoder decodeObjectForKey:kSigninfoModelMortlach25Y];
    self.city = [aDecoder decodeObjectForKey:kSigninfoModelCity];
    self.otherNumber = [aDecoder decodeObjectForKey:kSigninfoModelOtherNumber];
    self.name = [aDecoder decodeObjectForKey:kSigninfoModelName];
    self.mail = [aDecoder decodeObjectForKey:kSigninfoModelMail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mortlachRareOld forKey:kSigninfoModelMortlachRareOld];
    [aCoder encodeObject:_knowledgeLevel forKey:kSigninfoModelKnowledgeLevel];
    [aCoder encodeObject:_sexual forKey:kSigninfoModelSexual];
    [aCoder encodeObject:_phone forKey:kSigninfoModelPhone];
    [aCoder encodeObject:_potentialBuyLevel forKey:kSigninfoModelPotentialBuyLevel];
    [aCoder encodeObject:_userID forKey:kSigninfoModelUserID];
    [aCoder encodeInteger:_creatTime forKey:kSigninfoModelCreatTime];
    [aCoder encodeObject:_mortlach18YO forKey:kSigninfoModelMortlach18YO];
    [aCoder encodeObject:_interestLevel forKey:kSigninfoModelInterestLevel];
    [aCoder encodeObject:_otherMalts forKey:kSigninfoModelOtherMalts];
    [aCoder encodeObject:_date forKey:kSigninfoModelDate];
    [aCoder encodeObject:_mortlach25Y forKey:kSigninfoModelMortlach25Y];
    [aCoder encodeObject:_city forKey:kSigninfoModelCity];
    [aCoder encodeObject:_otherNumber forKey:kSigninfoModelOtherNumber];
    [aCoder encodeObject:_name forKey:kSigninfoModelName];
    [aCoder encodeObject:_mail forKey:kSigninfoModelMail];
}

- (id)copyWithZone:(NSZone *)zone
{
    SigninfoModel *copy = [[SigninfoModel alloc] init];
    
    if (copy) {

        copy.mortlachRareOld = [self.mortlachRareOld copyWithZone:zone];
        copy.knowledgeLevel = [self.knowledgeLevel copyWithZone:zone];
        copy.sexual = [self.sexual copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.potentialBuyLevel = [self.potentialBuyLevel copyWithZone:zone];
        copy.userID = [self.userID copyWithZone:zone];
        copy.creatTime = self.creatTime;
        copy.mortlach18YO = [self.mortlach18YO copyWithZone:zone];
        copy.interestLevel = [self.interestLevel copyWithZone:zone];
        copy.otherMalts = [self.otherMalts copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.mortlach25Y = [self.mortlach25Y copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.otherNumber = [self.otherNumber copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.mail = [self.mail copyWithZone:zone];
    }
    
    return copy;
}


@end
