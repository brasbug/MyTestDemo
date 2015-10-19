//
//  NSDate+GMT.h
//  iPhone Shequan Client
//
//  Created by XiangqiTu on 14-4-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GMT)

- (NSString *)getGMTFormatDate;

- (NSString *)getLocalFromGMT;

//时间正则表达式
+ (BOOL) validateDate:(NSString *) str;

+ (NSDate *)dateValueFromString:(NSString *)s;

+ (NSDate *)dateFromCustomString:(NSString *)s;

- (NSString *)stringValue;

- (BOOL)isToday;

#pragma mark - Custom Method
- (NSString *)getDay;
- (NSString *)getMonth;
- (NSString *)getMonthAndDay;
- (NSString *)getMonthAndDayHour;
- (NSString *)getMonthDayHourAndMinute;

- (NSString *)compareCurrentTime;

- (NSString*)compareNowByTimeIntervals:(NSArray*)intervalValues descriptionForTimeInterval:(NSArray*)description;

//通过生日获取当前年龄
- (NSInteger)getCurrentAge;



#pragma mark - Date Picker

+ (NSDate *)getMaxDatePickerDate;
+ (NSDate *)getMinDatePickerDate;
@end
