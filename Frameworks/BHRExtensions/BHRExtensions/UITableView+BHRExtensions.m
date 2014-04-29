//
//  UITableView+BHRExtensions.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 2/23/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UITableView+BHRExtensions.h"
#import "UIView+BHRTableViewExtensions.h"

@implementation UITableView (BHRExtensions)

- (void)selectNextResponderForView:(UIView *)view
{
	[view resignFirstResponder];
	
    UITableViewCell *currentCell = (UITableViewCell *)[view tableViewCell];
	
	UIView *nextResponder = [self nextSubviewInTableViewCell:currentCell
											  relativeToView:view];
	
	if (nextResponder != nil)
	{
		[nextResponder becomeFirstResponder];
		return;
	}
	
	NSIndexPath *nextIndexPath = nil;
	UITableViewCell *nextCell = currentCell;

	do {
		NSIndexPath *currentIndexPath = [self indexPathForCell:nextCell];
		
		
		NSIndexPath *nextIndexPath = [self nextIndexForPath:currentIndexPath];
		
		if (nextIndexPath == nil)
		{
			return;
		}
		
		nextCell = [self cellForRowAtIndexPath:nextIndexPath];
		
		[self scrollToRowAtIndexPath:nextIndexPath
					atScrollPosition:UITableViewScrollPositionMiddle
							animated:YES];
		
		nextResponder = [self nextSubviewInTableViewCell:nextCell
										  relativeToView:nil];

	} while (nextResponder == nil || nextIndexPath != nil);
	
	[nextResponder becomeFirstResponder];
	
	return;
}

- (UIView *)nextSubviewInTableViewCell:(UITableViewCell *)tableViewCell relativeToView:(UIView *)view
{
	UIView *nearestNextSubview = nil;
	CGFloat xDifferenceCurrentNearestToCurrentTextField = NSIntegerMax;
	CGRect viewFrame = view.frame;
	
	for (UIView *subview in tableViewCell.contentView.subviews)
	{
		if (![subview canBecomeFirstResponder] || subview == view)
		{
			continue;
		}
		
		CGFloat xDifferenceToCurrentTextField = CGRectGetMinX(subview.frame) - CGRectGetMaxX(viewFrame);
		
		if (xDifferenceToCurrentTextField >= 0.0f && xDifferenceToCurrentTextField < xDifferenceCurrentNearestToCurrentTextField)
		{
			xDifferenceCurrentNearestToCurrentTextField = xDifferenceToCurrentTextField;
			nearestNextSubview = subview;
		}
	}
	
	return nearestNextSubview;
}


- (NSIndexPath *)nextIndexForPath:(NSIndexPath *) indexPath
{
    NSInteger numOfSections = [self.dataSource numberOfSectionsInTableView:self];
    NSInteger nextSection = (indexPath.section + 1);
	
	NSInteger nextRow = indexPath.row + 1;
	NSInteger rowsInSection = [self.dataSource tableView:self numberOfRowsInSection:indexPath.section];
	
    if (nextRow < rowsInSection)
	{
		return [NSIndexPath indexPathForRow:nextRow
								  inSection:indexPath.section];
		
    }
	else if (nextSection < numOfSections)
	{
		return [NSIndexPath indexPathForRow:0 inSection:nextSection];
    }
	
	return nil;
}


- (NSArray *)allIndexPaths
{
	NSMutableArray *allIndexPaths = [@[] mutableCopy];
	
	NSInteger sections = [self numberOfSections];
	
	for (NSInteger section = 0; section < sections; section++)
	{
		NSInteger rows = [self numberOfRowsInSection:section];
		
		for (NSInteger row = 0; row < rows; row++)
		{
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
			[allIndexPaths addObject:indexPath];
		}
	}
	
	return allIndexPaths;
}

- (void)registerNibWithClass:(Class)class forCellReuseIdentifier:(NSString *)identifier
{
	UINib *nib = [UINib nibWithNibName:NSStringFromClass(class)
								bundle:nil];
	[self registerNib:nib forCellReuseIdentifier:identifier];
}

@end
