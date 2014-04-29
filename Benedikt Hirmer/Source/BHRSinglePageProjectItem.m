//
//  BHRSinglePageProjectItem.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRSinglePageProjectItem.h"



NSString * const BHRProjectItemKeyVideoName = @"videoName";
NSString * const BHRProjectitemKeyBackgroundColor = @"backgroundColor";


@interface BHRSinglePageProjectItem ()

@property (nonatomic, strong, readonly) NSString *videoName;

@end

@implementation BHRSinglePageProjectItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
	{
		_videoName = [dictionary objectForKey:BHRProjectItemKeyVideoName];

		NSString *backgroundHexColor = [dictionary objectForKey:BHRProjectitemKeyBackgroundColor];
		if (backgroundHexColor)
		{
			_backgroundColor = [UIColor colorWithHexString:backgroundHexColor];
		}
    }
    return self;
}

- (NSURL *)videoURL
{
	NSRange fileExtensionDelimiterRange = [self.videoName rangeOfString:@"."
																options:NSBackwardsSearch];

	if (fileExtensionDelimiterRange.location == NSNotFound) {
		return nil;
	}

	NSString *videoName = [self.videoName substringToIndex:fileExtensionDelimiterRange.location];
	NSString *extension = [self.videoName substringFromIndex:fileExtensionDelimiterRange.location + 1];

	NSURL *videoURL = [[NSBundle mainBundle] URLForResource:videoName withExtension:extension];
	return videoURL;
}


@end
