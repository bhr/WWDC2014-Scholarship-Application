//
//  NSObject+VEClasses.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 09.12.12.
//  Copyright (c) 2012 Institute of Ergonomics. All rights reserved.
//

#import "NSObject+BHRClassesAggregation.h"
#import <objc/runtime.h>

@implementation NSObject (BHRClassesAggregation)

+ (NSArray *)allClassNames
{
	NSMutableArray *classNames = [NSMutableArray array];
	
	int count = objc_getClassList(NULL, 0);
    if (count <= 0) {
        return classNames;
    }
    
	NSMutableData *classData = [NSMutableData dataWithLength:sizeof(Class) * count];
	Class *classes = (Class*)[classData mutableBytes];
	
	if (!classes) {
		return nil;
	}
	
	objc_getClassList(classes, count);
	
	
	NSUInteger i;
	for (i = 0; i < (NSUInteger)count; ++i) {
		Class currClass = classes[i];
		
		NSString *className = NSStringFromClass(currClass);
		
		if (className) {
			[classNames addObject:className];
		}
	}
	
	return classNames;
}

+ (NSArray *)allClassNamesWithSuffix:(NSString *)theSuffix
							  prefix:(NSString *)thePrefix
					 subclassOfClass:(Class)theSuperclass
{
	NSString *superclassName = NSStringFromClass(theSuperclass);
	NSMutableArray *classes = [NSMutableArray array];
	
	for (NSString *oneName in [self allClassNames])
	{
		if (theSuffix != nil &&
			![oneName hasSuffix:theSuffix]) {
			continue;
		}
		
		if (thePrefix != nil &&
			![oneName hasPrefix:thePrefix]) {
			continue;
		}
		
		if (superclassName != nil &&
			[superclassName isEqualToString:oneName] &&
			[oneName hasPrefix:@"_"])
		{
			continue;
		}
		
		Class oneClass = NSClassFromString(oneName);
		if (theSuperclass == nil ||
			([oneClass isSubclassOfClass:theSuperclass] &&
			 oneClass != theSuperclass))
		{
			[classes addObject:oneName];
		}
	}
	return classes;
}

@end
