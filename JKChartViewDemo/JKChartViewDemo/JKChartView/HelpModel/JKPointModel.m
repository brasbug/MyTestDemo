//
//  JKPointModel.m
//
//  Created by   on 15/9/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JKPointModel.h"


NSString *const kJKPointModelPointindext = @"pointindext";
NSString *const kJKPointModelYPoint = @"yPoint";
NSString *const kJKPointModelXPoint = @"xPoint";
NSString *const kJKPointModelIndext = @"indext";
NSString *const kJKPointModelExt = @"ext";
NSString *const kJKPointModelYvalueFloat = @"yValueFloat";
NSString *const kJKPointModelYPointValue = @"yPointValue";

@interface JKPointModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JKPointModel

@synthesize pointindext = _pointindext;
@synthesize yPoint = _yPoint;
@synthesize xPoint = _xPoint;
@synthesize indext = _indext;
@synthesize ext = _ext;
@synthesize yValueFloat = _yValueFloat;


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
            self.pointindext = [self objectOrNilForKey:kJKPointModelPointindext fromDictionary:dict];
            self.yPoint = [self objectOrNilForKey:kJKPointModelYPoint fromDictionary:dict];
            self.xPoint = [self objectOrNilForKey:kJKPointModelXPoint fromDictionary:dict];
            self.indext = [[self objectOrNilForKey:kJKPointModelIndext fromDictionary:dict] doubleValue];
            self.ext = [self objectOrNilForKey:kJKPointModelExt fromDictionary:dict];
        self.yValueFloat = [[self objectOrNilForKey:kJKPointModelYvalueFloat fromDictionary:dict]doubleValue];
        self.yPointValue = [self objectOrNilForKey:kJKPointModelYPointValue fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.pointindext forKey:kJKPointModelPointindext];
    [mutableDict setValue:self.yPoint forKey:kJKPointModelYPoint];
    [mutableDict setValue:self.xPoint forKey:kJKPointModelXPoint];
    [mutableDict setValue:[NSNumber numberWithDouble:self.indext] forKey:kJKPointModelIndext];
    [mutableDict setValue:self.ext forKey:kJKPointModelExt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.yValueFloat] forKey:kJKPointModelYvalueFloat];
    
    [mutableDict setValue:self.yPointValue forKey:kJKPointModelYPointValue];
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

    self.pointindext = [aDecoder decodeObjectForKey:kJKPointModelPointindext];
    self.yPoint = [aDecoder decodeObjectForKey:kJKPointModelYPoint];
    self.xPoint = [aDecoder decodeObjectForKey:kJKPointModelXPoint];
    self.indext = [aDecoder decodeDoubleForKey:kJKPointModelIndext];
    self.ext = [aDecoder decodeObjectForKey:kJKPointModelExt];
    self.yValueFloat = [aDecoder decodeDoubleForKey:kJKPointModelYvalueFloat];
    self.yPointValue = [aDecoder decodeObjectForKey:kJKPointModelYPointValue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pointindext forKey:kJKPointModelPointindext];
    [aCoder encodeObject:_yPoint forKey:kJKPointModelYPoint];
    [aCoder encodeObject:_xPoint forKey:kJKPointModelXPoint];
    [aCoder encodeDouble:_indext forKey:kJKPointModelIndext];
    [aCoder encodeObject:_ext forKey:kJKPointModelExt];
    [aCoder encodeDouble:_yValueFloat forKey:kJKPointModelYvalueFloat];
    [aCoder encodeObject:_yPointValue forKey:kJKPointModelYPointValue];
}

- (id)copyWithZone:(NSZone *)zone
{
    JKPointModel *copy = [[JKPointModel alloc] init];
    
    if (copy) {

        copy.pointindext = [self.pointindext copyWithZone:zone];
        copy.yPoint = [self.yPoint copyWithZone:zone];
        copy.xPoint = [self.xPoint copyWithZone:zone];
        copy.indext = self.indext;
        copy.ext = [self.ext copyWithZone:zone];
        copy.yValueFloat = self.yValueFloat;
        copy.yPointValue  = [self.yPointValue copyWithZone:zone];
    }
    
    return copy;
}


@end
