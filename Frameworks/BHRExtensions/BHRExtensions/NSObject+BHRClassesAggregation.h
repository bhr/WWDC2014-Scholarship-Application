//
//  NSObject+VEClasses.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 09.12.12.
//  Copyright (c) 2012 Institute of Ergonomics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BHRClassesAggregation)

+ (NSArray *)allClassNames;
+ (NSArray *)allClassNamesWithSuffix:(NSString *)theSuffix
							  prefix:(NSString *)thePrefix
					 subclassOfClass:(Class)theSuperclass;

@end
