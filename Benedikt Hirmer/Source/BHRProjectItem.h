//
//  BHRProjectItem.h
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/12/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum BHRProjectType : NSUInteger
{
	BHRProjectTypeMac = 0,
	BHRProjectTypeiPhone,
	BHRProjectTypeiPadLandscape,
	BHRProjectTypeiPadPortrait
} BHRProjectType;

@interface BHRProjectItem : NSObject

@property (nonatomic, assign, readonly) BHRProjectType type;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *subTitle;
@property (nonatomic, strong, readonly) NSString *description;
@property (nonatomic, strong, readonly) UIImage *icon;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

