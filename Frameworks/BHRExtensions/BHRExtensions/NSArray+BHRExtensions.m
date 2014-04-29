//
//  NSArray+Shuffling.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 18.12.12.
//  Copyright (c) 2012 Institute of Ergonomics. All rights reserved.
//

#import "NSArray+BHRExtensions.h"

@implementation NSArray (BHRExtensions)

- (NSArray *)shuffledArray
{
	NSMutableArray *array;
	array = [NSMutableArray arrayWithArray:self];
	
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i)
	{
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
		
        [array exchangeObjectAtIndex:i
				   withObjectAtIndex:n];
    }
	
	return array;
}

@end
