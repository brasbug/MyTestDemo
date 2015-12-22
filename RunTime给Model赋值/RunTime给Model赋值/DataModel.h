//
//  DataModel.h
//  RunTime给Model赋值
//
//  Created by 王磊 on 15/12/16.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataModel : NSObject

@property (nonatomic, copy) NSString * boyBaby0;
@property (nonatomic, copy) NSString * boyBaby1;
@property (nonatomic, copy) NSString * boyBaby2;
@property (nonatomic, copy) NSString * boyBaby3;
@property (nonatomic, copy) NSString * boyBaby0100;

+ (instancetype)initWithDictionary:(NSDictionary *)data;

@end
