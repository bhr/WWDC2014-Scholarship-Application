//
//  BHRProjectItem.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/12/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRProjectItem.h"


NSString * const BHRProjectItemKeyTitle = @"title";
NSString * const BHRProjectItemKeySubTitle = @"subTitle";
NSString * const BHRProjectItemKeyDescription = @"description";
NSString * const BHRProjectItemKeyIconName = @"iconName";
NSString * const BHRProjectItemKeyType = @"type";

@interface BHRProjectItem ()

@property (nonatomic, strong, readonly) NSString *iconName;

@end

@implementation BHRProjectItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
	{
		_type = [[dictionary objectForKey:BHRProjectItemKeyType] unsignedIntegerValue];
		_title = [dictionary objectForKey:BHRProjectItemKeyTitle];
		_subTitle = [dictionary objectForKey:BHRProjectItemKeySubTitle];
		_description = [dictionary objectForKey:BHRProjectItemKeyDescription];

		_iconName = [dictionary objectForKey:BHRProjectItemKeyIconName];
		_icon = [UIImage imageNamed:_iconName];
    }
    return self;
}

@end
