//
//  SQFileItem.m
//
//  Created by Li Huazhen on 15/6/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SQFileItem.h"


NSString *const kSQFileItemFileFolderPath = @"fileFolderPath";
NSString *const kSQFileItemFileType = @"fileType";
NSString *const kSQFileItemFileName = @"fileName";
NSString *const kSQFileItemFilePaht = @"filePaht";


@interface SQFileItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SQFileItem

@synthesize fileFolderPath = _fileFolderPath;
@synthesize fileType = _fileType;
@synthesize fileName = _fileName;
@synthesize filePaht = _filePaht;


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
            self.fileFolderPath = [self objectOrNilForKey:kSQFileItemFileFolderPath fromDictionary:dict];
            self.fileType = [self objectOrNilForKey:kSQFileItemFileType fromDictionary:dict];
            self.fileName = [self objectOrNilForKey:kSQFileItemFileName fromDictionary:dict];
            self.filePaht = [self objectOrNilForKey:kSQFileItemFilePaht fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.fileFolderPath forKey:kSQFileItemFileFolderPath];
    [mutableDict setValue:self.fileType forKey:kSQFileItemFileType];
    [mutableDict setValue:self.fileName forKey:kSQFileItemFileName];
    [mutableDict setValue:self.filePaht forKey:kSQFileItemFilePaht];

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

    self.fileFolderPath = [aDecoder decodeObjectForKey:kSQFileItemFileFolderPath];
    self.fileType = [aDecoder decodeObjectForKey:kSQFileItemFileType];
    self.fileName = [aDecoder decodeObjectForKey:kSQFileItemFileName];
    self.filePaht = [aDecoder decodeObjectForKey:kSQFileItemFilePaht];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_fileFolderPath forKey:kSQFileItemFileFolderPath];
    [aCoder encodeObject:_fileType forKey:kSQFileItemFileType];
    [aCoder encodeObject:_fileName forKey:kSQFileItemFileName];
    [aCoder encodeObject:_filePaht forKey:kSQFileItemFilePaht];
}

- (id)copyWithZone:(NSZone *)zone
{
    SQFileItem *copy = [[SQFileItem alloc] init];
    
    if (copy) {

        copy.fileFolderPath = [self.fileFolderPath copyWithZone:zone];
        copy.fileType = [self.fileType copyWithZone:zone];
        copy.fileName = [self.fileName copyWithZone:zone];
        copy.filePaht = [self.filePaht copyWithZone:zone];
    }
    
    return copy;
}


@end
