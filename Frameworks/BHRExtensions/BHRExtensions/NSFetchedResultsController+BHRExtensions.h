//
//  NSFetchedResultsController+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface NSFetchedResultsController (BHRExtensions)

- (void)moveObjectAtIndexPath:(NSIndexPath *)sourceIndexPath
				  toIndexPath:(NSIndexPath *)destinationIndexPath;

- (void)deleteObjectsAtIndexPaths:(NSArray *)indexPaths;

@end
