//
//  NSDate+Extension.m
//  BS
//
//  Created by lanou on 16/8/9.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
- (NSDateComponents *)deltaFrom:(NSDate *)form
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    
    return [calendar components:unit fromDate:form toDate:self options:0];


}

- (BOOL)isThisYear
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    
    
    return nowYear == selfYear;
    



}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSString *selfStr = [fmt stringFromDate:self];
    
    
    return [nowStr isEqualToString:selfStr];



}



- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowdate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    NSDate *selfdate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfdate toDate:nowdate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;



}




















@end
