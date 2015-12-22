//
//  NSString+New.m
//  RunTime给Model赋值
//
//  Created by 王磊 on 15/12/21.
//  Copyright © 2015年 王磊. All rights reserved.
//

#import "NSString+New.h"

@implementation NSString (New)

- (NSString *)capitalizedFirstChar {
    
    if (!self || !(self.length > 0))                  return self;
    
    unichar firstChar = [self characterAtIndex:0];
    
    if (!(('a' <= firstChar) && (firstChar <= 'z')))  return self;
    
    
    NSMutableString * returnStr = [[NSMutableString alloc] initWithString:self];
        
                      firstChar = firstChar - ('a' - 'A');
    
    NSString        * firstStr  = [[NSString alloc] initWithFormat:@"%c",firstChar];
    
    NSRange           range     = {0,1};
    
    [returnStr replaceCharactersInRange:range withString:firstStr];
    
    return returnStr;
}

@end
