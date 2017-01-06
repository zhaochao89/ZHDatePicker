//
//  ZHCalender.h
//  日期选择器
//
//  Created by zhaochao on 17/1/4.
//  Copyright © 2017年 zhaochao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHCalender : NSObject

+ (ZHCalender *)sharedInstance;
/**
 获取当前年份
 */
- (NSUInteger)getYearWithDate:(NSDate *)date;
/**
 获取当前月份
 */
- (NSUInteger)getMonthWithDate:(NSDate *)date;

/**
 当前日期是哪一天
 */
- (NSUInteger)getDayWithDate:(NSDate *)date;

- (NSUInteger)getHourWithDate:(NSDate *)date;

/**
 当前月有几天
 */
- (NSUInteger)daysForMonthWithDate:(NSDate *)date;

- (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date;

/**
 获取下一个日期
 */
- (NSDate *)getDateWithComponents:(NSDateComponents *)components toDate:(NSDate *)date;

@end
