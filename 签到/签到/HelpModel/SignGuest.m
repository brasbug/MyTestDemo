//
//  SignGuest.m
//
//  Created by   on 15/10/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SignGuest.h"


NSString *const kSignGuestMortlachRareOld = @"mortlach_RareOld";
NSString *const kSignGuestKnowledgeLevel = @"knowledgeLevel";
NSString *const kSignGuestSexual = @"sexual";
NSString *const kSignGuestPhone = @"phone";
NSString *const kSignGuestPotentialBuyLevel = @"potentialBuyLevel";
NSString *const kSignGuestMortlach18YO = @"mortlach_18YO";
NSString *const kSignGuestInterestLevel = @"interestLevel";
NSString *const kSignGuestOtherMalts = @"other_Malts";
NSString *const kSignGuestDate = @"date";
NSString *const kSignGuestMortlach25Y = @"mortlach_25Y";
NSString *const kSignGuestCity = @"city";
NSString *const kSignGuestOtherNumber = @"other_number";
NSString *const kSignGuestName = @"name";
NSString *const kSignGuestMail = @"mail";


@interface SignGuest ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SignGuest

@synthesize mortlachRareOld = _mortlachRareOld;
@synthesize knowledgeLevel = _knowledgeLevel;
@synthesize sexual = _sexual;
@synthesize phone = _phone;
@synthesize potentialBuyLevel = _potentialBuyLevel;
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
            self.mortlachRareOld = [[self objectOrNilForKey:kSignGuestMortlachRareOld fromDictionary:dict] longValue];
            self.knowledgeLevel = [[self objectOrNilForKey:kSignGuestKnowledgeLevel fromDictionary:dict] longValue];
            self.sexual = [[self objectOrNilForKey:kSignGuestSexual fromDictionary:dict] longValue];
            self.phone = [[self objectOrNilForKey:kSignGuestPhone fromDictionary:dict] longValue];
            self.potentialBuyLevel = [[self objectOrNilForKey:kSignGuestPotentialBuyLevel fromDictionary:dict] longValue];
            self.mortlach18YO = [[self objectOrNilForKey:kSignGuestMortlach18YO fromDictionary:dict] longValue];
            self.interestLevel = [[self objectOrNilForKey:kSignGuestInterestLevel fromDictionary:dict] longValue];
            self.otherMalts = [self objectOrNilForKey:kSignGuestOtherMalts fromDictionary:dict];
            self.date = [self objectOrNilForKey:kSignGuestDate fromDictionary:dict];
            self.mortlach25Y = [[self objectOrNilForKey:kSignGuestMortlach25Y fromDictionary:dict] longValue];
            self.city = [self objectOrNilForKey:kSignGuestCity fromDictionary:dict];
            self.otherNumber = [[self objectOrNilForKey:kSignGuestOtherNumber fromDictionary:dict] longValue];
            self.name = [self objectOrNilForKey:kSignGuestName fromDictionary:dict];
            self.mail = [self objectOrNilForKey:kSignGuestMail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mortlachRareOld] forKey:kSignGuestMortlachRareOld];
    [mutableDict setValue:[NSNumber numberWithDouble:self.knowledgeLevel] forKey:kSignGuestKnowledgeLevel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sexual] forKey:kSignGuestSexual];
    [mutableDict setValue:[NSNumber numberWithDouble:self.phone] forKey:kSignGuestPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.potentialBuyLevel] forKey:kSignGuestPotentialBuyLevel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mortlach18YO] forKey:kSignGuestMortlach18YO];
    [mutableDict setValue:[NSNumber numberWithDouble:self.interestLevel] forKey:kSignGuestInterestLevel];
    [mutableDict setValue:self.otherMalts forKey:kSignGuestOtherMalts];
    [mutableDict setValue:self.date forKey:kSignGuestDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mortlach25Y] forKey:kSignGuestMortlach25Y];
    [mutableDict setValue:self.city forKey:kSignGuestCity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.otherNumber] forKey:kSignGuestOtherNumber];
    [mutableDict setValue:self.name forKey:kSignGuestName];
    [mutableDict setValue:self.mail forKey:kSignGuestMail];

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

    self.mortlachRareOld = [aDecoder decodeDoubleForKey:kSignGuestMortlachRareOld];
    self.knowledgeLevel = [aDecoder decodeDoubleForKey:kSignGuestKnowledgeLevel];
    self.sexual = [aDecoder decodeDoubleForKey:kSignGuestSexual];
    self.phone = [aDecoder decodeDoubleForKey:kSignGuestPhone];
    self.potentialBuyLevel = [aDecoder decodeDoubleForKey:kSignGuestPotentialBuyLevel];
    self.mortlach18YO = [aDecoder decodeDoubleForKey:kSignGuestMortlach18YO];
    self.interestLevel = [aDecoder decodeDoubleForKey:kSignGuestInterestLevel];
    self.otherMalts = [aDecoder decodeObjectForKey:kSignGuestOtherMalts];
    self.date = [aDecoder decodeObjectForKey:kSignGuestDate];
    self.mortlach25Y = [aDecoder decodeDoubleForKey:kSignGuestMortlach25Y];
    self.city = [aDecoder decodeObjectForKey:kSignGuestCity];
    self.otherNumber = [aDecoder decodeDoubleForKey:kSignGuestOtherNumber];
    self.name = [aDecoder decodeObjectForKey:kSignGuestName];
    self.mail = [aDecoder decodeObjectForKey:kSignGuestMail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_mortlachRareOld forKey:kSignGuestMortlachRareOld];
    [aCoder encodeDouble:_knowledgeLevel forKey:kSignGuestKnowledgeLevel];
    [aCoder encodeDouble:_sexual forKey:kSignGuestSexual];
    [aCoder encodeDouble:_phone forKey:kSignGuestPhone];
    [aCoder encodeDouble:_potentialBuyLevel forKey:kSignGuestPotentialBuyLevel];
    [aCoder encodeDouble:_mortlach18YO forKey:kSignGuestMortlach18YO];
    [aCoder encodeDouble:_interestLevel forKey:kSignGuestInterestLevel];
    [aCoder encodeObject:_otherMalts forKey:kSignGuestOtherMalts];
    [aCoder encodeObject:_date forKey:kSignGuestDate];
    [aCoder encodeDouble:_mortlach25Y forKey:kSignGuestMortlach25Y];
    [aCoder encodeObject:_city forKey:kSignGuestCity];
    [aCoder encodeDouble:_otherNumber forKey:kSignGuestOtherNumber];
    [aCoder encodeObject:_name forKey:kSignGuestName];
    [aCoder encodeObject:_mail forKey:kSignGuestMail];
}

- (id)copyWithZone:(NSZone *)zone
{
    SignGuest *copy = [[SignGuest alloc] init];
    
    if (copy) {

        copy.mortlachRareOld = self.mortlachRareOld;
        copy.knowledgeLevel = self.knowledgeLevel;
        copy.sexual = self.sexual;
        copy.phone = self.phone;
        copy.potentialBuyLevel = self.potentialBuyLevel;
        copy.mortlach18YO = self.mortlach18YO;
        copy.interestLevel = self.interestLevel;
        copy.otherMalts = [self.otherMalts copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.mortlach25Y = self.mortlach25Y;
        copy.city = [self.city copyWithZone:zone];
        copy.otherNumber = self.otherNumber;
        copy.name = [self.name copyWithZone:zone];
        copy.mail = [self.mail copyWithZone:zone];
    }
    
    return copy;
}


@end
