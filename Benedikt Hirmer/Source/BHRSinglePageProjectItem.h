//
//  BHRSinglePageProjectItem.h
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRProjectItem.h"

@interface BHRSinglePageProjectItem : BHRProjectItem

@property (nonatomic, strong) UIColor *backgroundColor;

- (NSURL *)videoURL;

@end
