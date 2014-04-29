//
//  NSString+UID.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 23.12.12.
//  Copyright (c) 2012 Institute of Ergonomics. All rights reserved.
//

#import "NSString+BHRUID.h"

NSString * const kTestingUID = @"00000000";


@implementation NSString (BHRUID)

+ (NSString*) stringWithUID
{
	CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return uuidString;
}

+ (NSString *) stringWithTestingUID
{
	return kTestingUID;
}

@end
