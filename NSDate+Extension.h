//
//  NSDate+Extension.h
//  BS
//
//  Created by lanou on 16/8/9.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
- (NSDateComponents *)deltaFrom:(NSDate *)form;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;

@end
