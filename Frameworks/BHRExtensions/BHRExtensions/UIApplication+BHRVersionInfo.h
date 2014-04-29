//
//  UIApplication+BHRVersionInfo.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/11/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (BHRVersionInfo)

+ (NSString *)appName;
+ (NSString *) appVersion;
+ (NSString *) build;
+ (NSString *) versionBuild;
+ (NSString *)appIdentifier;

@end

