//
//  NSDate+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BHRExtensions)

- (NSString *)shortDateAndTimeString;

+ (NSDate *)today;
+ (NSDate *)yesterday;
+ (NSDate *)thisWeek;
+ (NSDate *)lastWeek;
+ (NSDate *)last7Days;
+ (NSDate *)thisMonth;
+ (NSDate *)lastMonth;

@end
