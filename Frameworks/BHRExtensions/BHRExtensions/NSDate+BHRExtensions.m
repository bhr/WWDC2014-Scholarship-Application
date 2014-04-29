//
//  NSDate+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSDate+BHRExtensions.h"

@implementation NSDate (BHRExtensions)

- (NSString *)shortDateAndTimeString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	dateFormatter.dateStyle = NSDateFormatterShortStyle;
	dateFormatter.timeStyle = NSDateFormatterShortStyle;
	
	return [dateFormatter stringFromDate:self];
}


+ (NSDate *)today
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
										  fromDate:[NSDate date]];
	
	[components setHour:-[components hour]];
	[components setMinute:-[components minute]];
	[components setSecond:-[components second]];
	NSDate *today = [cal dateByAddingComponents:components
										 toDate:[NSDate date]
										options:0];

	return today;
}

+ (NSDate *)yesterday
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
										  fromDate:[NSDate date]];
	
	[components setHour:-24];
	[components setMinute:0];
	[components setSecond:0];
	NSDate *yesterday = [cal dateByAddingComponents:components
											 toDate:[self today]
											options:0];
	return yesterday;
}


+ (NSDate *)thisWeek
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
										  fromDate:[NSDate date]];
	
	[components setDay:([components day] - ([components weekday] - 1))];
	NSDate *thisWeek  = [cal dateFromComponents:components];

	return thisWeek;
}


+ (NSDate *)lastWeek
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
										  fromDate:[self thisWeek]];
	
	[components setDay:([components day] - 7)];
	NSDate *lastWeek  = [cal dateFromComponents:components];

	return lastWeek;
}

+ (NSDate *)last7Days
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
										  fromDate:[NSDate date]];
	
	[components setDay:([components day] - 7)];
	NSDate *lastWeek  = [cal dateFromComponents:components];
	
	return lastWeek;
}

+ (NSDate *)thisMonth
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
										  fromDate:[NSDate date]];
	
	[components setDay:([components day] - ([components day] -1))];
	NSDate *thisMonth  = [cal dateFromComponents:components];
	
	return thisMonth;
}

+ (NSDate *)lastMonth
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
										  fromDate:[self thisMonth]];
	
	[components setMonth:([components month] - 1)];
	NSDate *lastMonth  = [cal dateFromComponents:components];
	
	return lastMonth;
}

@end
