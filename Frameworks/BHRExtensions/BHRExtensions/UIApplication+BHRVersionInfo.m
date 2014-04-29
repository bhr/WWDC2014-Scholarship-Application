//
//  UIApplication+BHRVersionInfo.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/11/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIApplication+BHRVersionInfo.h"

@implementation UIApplication (BHRVersionInfo)

+ (NSString *)appName
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+ (NSString *) appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

+ (NSString *) build
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
}

+ (NSString *) versionBuild
{
    NSString * version = [self appVersion];
    NSString * build = [self build];
	
    NSString * versionBuild = [NSString stringWithFormat: @"v%@", version];
	
    if (![version isEqualToString: build]) {
        versionBuild = [NSString stringWithFormat: @"%@ (%@)", versionBuild, build];
    }
	
    return versionBuild;
}

+ (NSString *)appIdentifier
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

@end
