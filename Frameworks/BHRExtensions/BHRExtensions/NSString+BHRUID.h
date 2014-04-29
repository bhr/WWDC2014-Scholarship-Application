//
//  NSString+UID.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 23.12.12.
//  Copyright (c) 2012 Institute of Ergonomics. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kTestingUID;

@interface NSString (BHRUID)


+ (NSString*) stringWithUID;
+ (NSString *) stringWithTestingUID;

@end
