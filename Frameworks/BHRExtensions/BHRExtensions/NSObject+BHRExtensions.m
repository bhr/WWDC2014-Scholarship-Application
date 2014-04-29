//
//  NSObject+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSObject+BHRExtensions.h"

@implementation NSObject (BHRExtensions)

+ (NSString *)documentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [paths objectAtIndex:0];
	
	return documentsPath;
}

@end
