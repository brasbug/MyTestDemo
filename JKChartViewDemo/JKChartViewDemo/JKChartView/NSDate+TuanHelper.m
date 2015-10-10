//
//  NSDate+JKDateHelper.m
//  Jovi
//
//  Created by Jack on 15/9/29.
//  Copyright © 2015年 dianping.com. All rights reserved.
//

#import "NSDate+TuanHelper.h"

@implementation NSDate (JKDateHelper)

+ (NSString *)tuan_dateStringWithFormat:(NSString *)timeStr Type:(TuanTimeFormatType)timeFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    NSDate *date;

    switch (timeFormat) {
        case TuanMonthDayFormat:
        {
            [formatter setDateFormat:@"yyyy-MM-dd"];
            date=[formatter dateFromString:timeStr];
            [formatter setDateFormat:@"MM-dd"];
        }
            break;
        case TuanMonthOnlyFormat:
        {
            [formatter setDateFormat:@"yyyy-MM"];
            date=[formatter dateFromString:timeStr];
            [formatter setDateFormat:@"MM月"];
        }
            break;
        case TuanYearOnlyFormat:
        {
            [formatter setDateFormat:@"yyyy-MM"];
            date=[formatter dateFromString:timeStr];
            [formatter setDateFormat:@"yyyy"];
        }
            break;
            
        default:
            break;
    }
    NSString *dateString = [formatter stringFromDate:date];

    return dateString;
}

+ (NSString *)yearStringWithFormat:(NSString *)timestr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM"];
    NSDate *date=[formatter dateFromString:timestr];
    [formatter setDateFormat:@"yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)monthStringWithFormat:(NSString *)timestr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM"];
    NSDate *date=[formatter dateFromString:timestr];
    [formatter setDateFormat:@"MM月"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
