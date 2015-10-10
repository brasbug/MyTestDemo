//
//  NSDate+JKDateHelper.h
//  Jovi
//
//  Created by Jack on 15/9/29.
//  Copyright © 2015年 dianping.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, TuanTimeFormatType)
{
    TuanMonthDayFormat = 0,
    TuanMonthOnlyFormat,
    TuanYearOnlyFormat,
};


@interface NSDate (JKDateHelper)


//特定地方使用的方法
+ (NSString *)tuan_dateStringWithFormat:(NSString *)timeStr Type:(TuanTimeFormatType)timeFormat;

@end
