//
//  NSDate+GMT.m
//  iPhone Shequan Client
//
//  Created by XiangqiTu on 14-4-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "NSDate+GMT.h"
#import "NSDate+Category.h"

#define kAgeMax     60
#define kAgeMin     18

@implementation NSDate (GMT)

- (NSString *)getGMTFormatDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSString *dateString = [dateFormatter stringFromDate:self];
    return dateString;
}

- (NSString *)getLocalFromGMT
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSString *str = [dateFormatter stringFromDate:self];
    return str;
}


- (BOOL)isToday
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateSMS = [dateFormatter stringFromDate:self];
    NSDate *now = [NSDate date];
    NSString *dateNow = [dateFormatter stringFromDate:now];
    if ([dateSMS isEqualToString:dateNow]) {
        //[dateFormatter setDateFormat:@"HH:mm"];
        return YES;
    }
    else {
      //  [dateFormatter setDateFormat:@"MM/dd"];
        return NO;
    }
    
}

+ (BOOL) validateDate:(NSString *) str
{
    NSString *patternStr =
    @"((^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(10|12|0?[13578])([-\\/\\._])(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(11|0?[469])([-\\/\\._])(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(0?2)([-\\/\\._])(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)([-\\/\\._])(0?2)([-\\/\\._])(29)$)|(^([3579][26]00)([-\\/\\._])(0?2)([-\\/\\._])(29)$)|(^([1][89][0][48])([-\\/\\._])(0?2)([-\\/\\._])(29)$)|(^([2-9][0-9][0][48])([-\\/\\._])(0?2)([-\\/\\._])(29)$)|(^([1][89][2468][048])([-\\/\\._])(0?2)([-\\/\\._])(29)$)|(^([2-9][0-9][2468][048])([-\\/\\._])(0?2)([-\\/\\._])(29)$)|(^([1][89][13579][26])([-\\/\\._])(0?2)([-\\/\\._])(29)$)|(^([2-9][0-9][13579][26])([-\\/\\._])(0?2)([-\\/\\._])(29)$))";
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
//        NSLog(@"%@ 日期正确", str);
        return YES;
    }
    
//    NSLog(@"%@ 日期错误", str);
    return NO;
}

//NSString 2 NSDate
+ (NSDate *)dateValueFromString:(NSString *)s
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* localzone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:localzone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *retdate = [dateFormatter dateFromString:s];
    return retdate;
}

+ (NSDate *)dateFromCustomString:(NSString *)s
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* localzone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:localzone];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *retdate = [dateFormatter dateFromString:s];
    return retdate;
}

//NSDate 2 NSString
- (NSString *)stringValue
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* localzone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:localzone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS Z"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    return strDate;
}

#pragma mark - Custom Method
- (NSString *)getDay
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    
    [f setDateFormat:@"dd"];
    return [f stringFromDate:self];
}
- (NSString *)getMonth
{
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"MM"];
    return [f stringFromDate:self];
}

- (NSString *)getMonthAndDay
{
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"MM-dd"];
    return [f stringFromDate:self];
}
- (NSString *)getMonthAndDayHour
{
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"MM-dd HH"];
    return [f stringFromDate:self];
}

- (NSString *)getMonthDayHourAndMinute
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    if ([self isLastYear]) {
        [f setDateFormat:@"YYYY-MM-dd HH:mm"];
    }
    else
    {
        [f setDateFormat:@"MM-dd HH:mm"];
    }
    return [f stringFromDate:self];
    
}



/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 */
-(NSString *)compareCurrentTime
{
    NSTimeInterval  timeInterval = [self timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    
    if (timeInterval < 60) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"aa hh:mm"];
        result=[dateFormatter stringFromDate:self];
    }
    else if((temp = timeInterval/60) <60){
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"aa hh:mm"];
        result=[dateFormatter stringFromDate:self];
    }
    
    else if((temp = temp/60) <24){
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"aa hh:mm"];
        result=[dateFormatter stringFromDate:self];
        
    }
    else if((temp = temp/24) <30){
        if (temp==1) {
            result=NSLocalizedString(@"昨天", @"昨天");
        }
        else if(temp<=7)
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEEE"];
            result=[dateFormatter stringFromDate:self];
        }
        else
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-DD"];
            result=[dateFormatter stringFromDate:self];
        }
    }
    else if((temp = temp/30) <12){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-DD"];
        result=[dateFormatter stringFromDate:self];
    }
    else{
        temp = temp/12;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-DD"];
        result=[dateFormatter stringFromDate:self];
    }
    return  result;
}

- (BOOL)compareCurrentTimeisNearly
{
    
    NSTimeInterval  timeInterval = [self timeIntervalSinceNow];
    timeInterval = -timeInterval;
    if (timeInterval < 86400*2) {
        return YES;
    }
    else
    {
        return NO;
    }
    
}


-(NSString*)compareNowByTimeIntervals:(NSArray*)intervalValues descriptionForTimeInterval:(NSArray*)description
{
    NSTimeInterval  timeInterval = fabs([self timeIntervalSinceNow]);
    for (int i=0; i < intervalValues.count; i++ )
    {
        NSNumber* timeIntervalNumber = intervalValues[i];
        if (timeInterval < timeIntervalNumber.doubleValue)
            return description[i];
    }
    return @"";
}

//通过生日获取当前年龄
- (NSInteger)getCurrentAge
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componets = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self toDate:[NSDate date] options:NSCalendarWrapComponents];
    return componets.year;
}

#pragma mark - Date Picker

+ (NSDate *)getMaxDatePickerDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componets = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    componets.year = componets.year - kAgeMin;
    NSDate *date = [calendar dateFromComponents:componets];
    return date;
}

+ (NSDate *)getMinDatePickerDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componets = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    componets.year = componets.year - kAgeMax;
    NSDate *date = [calendar dateFromComponents:componets];
    return date;
}


@end
