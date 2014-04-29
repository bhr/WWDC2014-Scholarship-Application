//
//  NSURL+BHRExtensions.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 2/20/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSURL+BHRExtensions.h"

@implementation NSURL (BHRExtensions)

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
