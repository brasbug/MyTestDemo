//
//  SignUserInfoModel.m
//
//  Created by   on 15/10/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SignUserInfoModel.h"


NSString *const kSignUserInfoModelMortlachRareOld = @"mortlach_RareOld";
NSString *const kSignUserInfoModelName = @"name";
NSString *const kSignUserInfoModelSexual = @"sexual";
NSString *const kSignUserInfoModelPhone = @"phone";
NSString *const kSignUserInfoModelPotentialBuyLevel = @"potentialBuyLevel";
NSString *const kSignUserInfoModelUserID = @"userID";
NSString *const kSignUserInfoModelCreatTime = @"creatTime";
NSString *const kSignUserInfoModelMail = @"mail";
NSString *const kSignUserInfoModelInterestLevel = @"interestLevel";
NSString *const kSignUserInfoModelOtherMalts = @"other_Malts";
NSString *const kSignUserInfoModelDate = @"date";
NSString *const kSignUserInfoModelMortlach25Y = @"mortlach_25Y";
NSString *const kSignUserInfoModelCity = @"city";
NSString *const kSignUserInfoModelOtherNumber = @"other_number";
NSString *const kSignUserInfoModelKnowledgeLevel = @"knowledgeLevel";
NSString *const kSignUserInfoModelMortlach18YO = @"mortlach_18YO";


@interface SignUserInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SignUserInfoModel

@synthesize mortlachRareOld = _mortlachRareOld;
@synthesize name = _name;
@synthesize sexual = _sexual;
@synthesize phone = _phone;
@synthesize potentialBuyLevel = _potentialBuyLevel;
@synthesize userID = _userID;
@synthesize creatTime = _creatTime;
@synthesize mail = _mail;
@synthesize interestLevel = _interestLevel;
@synthesize otherMalts = _otherMalts;
@synthesize date = _date;
@synthesize mortlach25Y = _mortlach25Y;
@synthesize city = _city;
@synthesize otherNumber = _otherNumber;
@synthesize knowledgeLevel = _knowledgeLevel;
@synthesize mortlach18YO = _mortlach18YO;


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
            self.mortlachRareOld = [[self objectOrNilForKey:kSignUserInfoModelMortlachRareOld fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kSignUserInfoModelName fromDictionary:dict];
            self.sexual = [[self objectOrNilForKey:kSignUserInfoModelSexual fromDictionary:dict] doubleValue];
            self.phone = [[self objectOrNilForKey:kSignUserInfoModelPhone fromDictionary:dict] doubleValue];
            self.potentialBuyLevel = [[self objectOrNilForKey:kSignUserInfoModelPotentialBuyLevel fromDictionary:dict] doubleValue];
            self.userID = [self objectOrNilForKey:kSignUserInfoModelUserID fromDictionary:dict];
            self.creatTime = [self objectOrNilForKey:kSignUserInfoModelCreatTime fromDictionary:dict];
            self.mail = [self objectOrNilForKey:kSignUserInfoModelMail fromDictionary:dict];
            self.interestLevel = [[self objectOrNilForKey:kSignUserInfoModelInterestLevel fromDictionary:dict] doubleValue];
            self.otherMalts = [self objectOrNilForKey:kSignUserInfoModelOtherMalts fromDictionary:dict];
            self.date = [self objectOrNilForKey:kSignUserInfoModelDate fromDictionary:dict];
            self.mortlach25Y = [[self objectOrNilForKey:kSignUserInfoModelMortlach25Y fromDictionary:dict] doubleValue];
            self.city = [self objectOrNilForKey:kSignUserInfoModelCity fromDictionary:dict];
            self.otherNumber = [[self objectOrNilForKey:kSignUserInfoModelOtherNumber fromDictionary:dict] doubleValue];
            self.knowledgeLevel = [[self objectOrNilForKey:kSignUserInfoModelKnowledgeLevel fromDictionary:dict] doubleValue];
            self.mortlach18YO = [[self objectOrNilForKey:kSignUserInfoModelMortlach18YO fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mortlachRareOld] forKey:kSignUserInfoModelMortlachRareOld];
    [mutableDict setValue:self.name forKey:kSignUserInfoModelName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sexual] forKey:kSignUserInfoModelSexual];
    [mutableDict setValue:[NSNumber numberWithDouble:self.phone] forKey:kSignUserInfoModelPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.potentialBuyLevel] forKey:kSignUserInfoModelPotentialBuyLevel];
    [mutableDict setValue:self.userID forKey:kSignUserInfoModelUserID];
    [mutableDict setValue:self.creatTime forKey:kSignUserInfoModelCreatTime];
    [mutableDict setValue:self.mail forKey:kSignUserInfoModelMail];
    [mutableDict setValue:[NSNumber numberWithDouble:self.interestLevel] forKey:kSignUserInfoModelInterestLevel];
    [mutableDict setValue:self.otherMalts forKey:kSignUserInfoModelOtherMalts];
    [mutableDict setValue:self.date forKey:kSignUserInfoModelDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mortlach25Y] forKey:kSignUserInfoModelMortlach25Y];
    [mutableDict setValue:self.city forKey:kSignUserInfoModelCity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.otherNumber] forKey:kSignUserInfoModelOtherNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.knowledgeLevel] forKey:kSignUserInfoModelKnowledgeLevel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mortlach18YO] forKey:kSignUserInfoModelMortlach18YO];

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

    self.mortlachRareOld = [aDecoder decodeDoubleForKey:kSignUserInfoModelMortlachRareOld];
    self.name = [aDecoder decodeObjectForKey:kSignUserInfoModelName];
    self.sexual = [aDecoder decodeDoubleForKey:kSignUserInfoModelSexual];
    self.phone = [aDecoder decodeDoubleForKey:kSignUserInfoModelPhone];
    self.potentialBuyLevel = [aDecoder decodeDoubleForKey:kSignUserInfoModelPotentialBuyLevel];
    self.userID = [aDecoder decodeObjectForKey:kSignUserInfoModelUserID];
    self.creatTime = [aDecoder decodeObjectForKey:kSignUserInfoModelCreatTime];
    self.mail = [aDecoder decodeObjectForKey:kSignUserInfoModelMail];
    self.interestLevel = [aDecoder decodeDoubleForKey:kSignUserInfoModelInterestLevel];
    self.otherMalts = [aDecoder decodeObjectForKey:kSignUserInfoModelOtherMalts];
    self.date = [aDecoder decodeObjectForKey:kSignUserInfoModelDate];
    self.mortlach25Y = [aDecoder decodeDoubleForKey:kSignUserInfoModelMortlach25Y];
    self.city = [aDecoder decodeObjectForKey:kSignUserInfoModelCity];
    self.otherNumber = [aDecoder decodeDoubleForKey:kSignUserInfoModelOtherNumber];
    self.knowledgeLevel = [aDecoder decodeDoubleForKey:kSignUserInfoModelKnowledgeLevel];
    self.mortlach18YO = [aDecoder decodeDoubleForKey:kSignUserInfoModelMortlach18YO];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_mortlachRareOld forKey:kSignUserInfoModelMortlachRareOld];
    [aCoder encodeObject:_name forKey:kSignUserInfoModelName];
    [aCoder encodeDouble:_sexual forKey:kSignUserInfoModelSexual];
    [aCoder encodeDouble:_phone forKey:kSignUserInfoModelPhone];
    [aCoder encodeDouble:_potentialBuyLevel forKey:kSignUserInfoModelPotentialBuyLevel];
    [aCoder encodeObject:_userID forKey:kSignUserInfoModelUserID];
    [aCoder encodeObject:_creatTime forKey:kSignUserInfoModelCreatTime];
    [aCoder encodeObject:_mail forKey:kSignUserInfoModelMail];
    [aCoder encodeDouble:_interestLevel forKey:kSignUserInfoModelInterestLevel];
    [aCoder encodeObject:_otherMalts forKey:kSignUserInfoModelOtherMalts];
    [aCoder encodeObject:_date forKey:kSignUserInfoModelDate];
    [aCoder encodeDouble:_mortlach25Y forKey:kSignUserInfoModelMortlach25Y];
    [aCoder encodeObject:_city forKey:kSignUserInfoModelCity];
    [aCoder encodeDouble:_otherNumber forKey:kSignUserInfoModelOtherNumber];
    [aCoder encodeDouble:_knowledgeLevel forKey:kSignUserInfoModelKnowledgeLevel];
    [aCoder encodeDouble:_mortlach18YO forKey:kSignUserInfoModelMortlach18YO];
}

- (id)copyWithZone:(NSZone *)zone
{
    SignUserInfoModel *copy = [[SignUserInfoModel alloc] init];
    
    if (copy) {

        copy.mortlachRareOld = self.mortlachRareOld;
        copy.name = [self.name copyWithZone:zone];
        copy.sexual = self.sexual;
        copy.phone = self.phone;
        copy.potentialBuyLevel = self.potentialBuyLevel;
        copy.userID = [self.userID copyWithZone:zone];
        copy.creatTime = [self.creatTime copyWithZone:zone];
        copy.mail = [self.mail copyWithZone:zone];
        copy.interestLevel = self.interestLevel;
        copy.otherMalts = [self.otherMalts copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.mortlach25Y = self.mortlach25Y;
        copy.city = [self.city copyWithZone:zone];
        copy.otherNumber = self.otherNumber;
        copy.knowledgeLevel = self.knowledgeLevel;
        copy.mortlach18YO = self.mortlach18YO;
    }
    
    return copy;
}


@end
