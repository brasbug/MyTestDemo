//
//  JKPointModelBaseClass.h
//
//  Created by   on 15/9/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JKPointModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *yPoint;
@property (nonatomic, strong) NSString *xPoint;
@property (nonatomic, assign) double indext;
@property (nonatomic, strong) NSDictionary *ext;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
