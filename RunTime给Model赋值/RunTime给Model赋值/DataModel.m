//
//  DataModel.m
//  RunTime给Model赋值
//
//  Created by 王磊 on 15/12/16.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "DataModel.h"
#import "NSString+New.h"

@implementation DataModel

#pragma mark - Create Method of Setter

+ (instancetype)initWithDictionary:(NSDictionary *)data {
    
    return [[self alloc] initWithDictionary:data];
}

- (instancetype)initWithDictionary:(NSDictionary *)data {
    
    self = [super init];
    if (self) {
        
        if (!self) {
            return self;
        }
        
        [self assginToPropertyWithDictionary:data];
    }
    return self;
}

- (SEL)creatSetterWithPropertyName:(NSString *)propertyName {
    
    //首字母大写
    propertyName = propertyName.capitalizedFirstChar;
    
    //拼接上set关键字   注意:setter方法有":"
    propertyName = [NSString stringWithFormat:@"set%@:",propertyName];
    
    //返回set方法
    return NSSelectorFromString(propertyName);
    
}

- (void)assginToPropertyWithDictionary:(NSDictionary *)data {
    
    if (!data) {
        return;
    }
    
    //获取字典的Key
    NSArray * dicKey = [data allKeys];
    
    //循环遍历字典Key, 并且动态生成实体类的setter方法, 把字典的value通过setter方法赋值给实体类的属性
    for (int i = 0; i < dicKey.count; i++) {
        
        //通过getSetterSelWithAttibuteName方法来获取实体类的set方法
        SEL setSel = [self creatSetterWithPropertyName:dicKey[i]];
        
        NSLog(@"%@",NSStringFromSelector(setSel));
        
        if ([self respondsToSelector:setSel]) {
            
            //获取字典中Key对应的Value
            NSString * value = [NSString stringWithFormat:@"%@",data[dicKey[i]]];
            
            //把值通过setter方法赋值给实体类的属性
            [self performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
        }
    }
    
}

@end
