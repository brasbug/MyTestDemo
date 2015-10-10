//
//  JKPointModelBaseClass.h
//
//  Created by   on 15/9/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JKPointModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *pointindext;
@property (nonatomic, strong) NSString *yPoint; //y坐标显示value
@property (nonatomic, strong) NSString *xPoint; //x坐标显示value
@property (nonatomic, strong) NSString *yPointValue; //y坐标点击显示的内容

@property (nonatomic, assign) double yValueFloat;

@property (nonatomic, assign) double indext;
@property (nonatomic, strong) NSDictionary *ext;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
