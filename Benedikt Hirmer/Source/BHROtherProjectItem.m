//
//  BHROtherProjectItem.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHROtherProjectItem.h"

NSString * const BHRProjectItemKeyYears = @"years";


@implementation BHROtherProjectItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
	{
		_years = [dictionary objectForKey:BHRProjectItemKeyYears];
    }
    return self;
}


@end
