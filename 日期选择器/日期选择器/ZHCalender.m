//
//  ZHCalender.m
//  日期选择器
//
//  Created by zhaochao on 17/1/4.
//  Copyright © 2017年 zhaochao. All rights reserved.
//

#import "ZHCalender.h"

@interface ZHCalender ()

@property (nonatomic, strong) NSCalendar *calendar;

@end

@implementation ZHCalender

+ (ZHCalender *)sharedInstance {
    static ZHCalender *_m = nil;
    if (_m == nil) {
        _m = [[ZHCalender alloc] init];
    }
    return _m;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return self;
}

- (NSUInteger)getYearWithDate:(NSDate *)date {
    return [self.calendar component:NSCalendarUnitYear fromDate:date];
}

- (NSUInteger)getMonthWithDate:(NSDate *)date {
    return [self.calendar component:NSCalendarUnitMonth fromDate:date];
}

- (NSUInteger)getDayWithDate:(NSDate *)date {
    return [self.calendar component:NSCalendarUnitDay fromDate:date];
}

- (NSUInteger)getHourWithDate:(NSDate *)date {
    return [self.calendar component:NSCalendarUnitHour fromDate:date];
}

- (NSUInteger)daysForMonthWithDate:(NSDate *)date {
    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

- (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date {
    return [self.calendar components:NSCalendarUnitMonth fromDate:date];
}

- (NSDate *)getDateWithComponents:(NSDateComponents *)components toDate:(NSDate *)date {
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

@end
