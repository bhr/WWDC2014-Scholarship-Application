//
//  BHRIPhoneViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/12/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRiPhoneProjectViewController.h"
#import "BHRiPhoneProjectMediaViewController.h"

@interface BHRiPhoneProjectViewController ()

@end

@implementation BHRiPhoneProjectViewController


- (NSArray *)portraitConstraints
{
	NSMutableArray *constraints = [@[] mutableCopy];

	UIView *projectMediaView = self.projectMediaViewController.view;
	UIView *titleContainerView = self.titleContainerView;
	UIView *textContainerView = self.textContainerView;
	NSDictionary *viewsDict = NSDictionaryOfVariableBindings(titleContainerView, textContainerView, projectMediaView);

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[titleContainerView]-40-[projectMediaView]-40-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[projectMediaView]-40-[textContainerView]-40-|"
																			 options:NSLayoutFormatAlignAllBottom
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[titleContainerView]-(>=20)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];


	[constraints addObject:[NSLayoutConstraint constraintWithItem:projectMediaView
														attribute:NSLayoutAttributeTop
														relatedBy:NSLayoutRelationEqual
														   toItem:self.textContainerView
														attribute:NSLayoutAttributeTop
													   multiplier:1.0f
														 constant:-140.0f]];


	return constraints;
}

- (NSArray *)landscapeConstraints
{
	NSMutableArray *constraints = [@[] mutableCopy];

	UIView *projectMediaView = self.projectMediaViewController.view;
	UIView *titleContainerView = self.titleContainerView;
	UIView *textContainerView = self.textContainerView;
	NSDictionary *viewsDict = NSDictionaryOfVariableBindings(titleContainerView, textContainerView, projectMediaView);

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[projectMediaView]-20-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[titleContainerView]-60-[textContainerView]"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[projectMediaView]-80-[textContainerView]-40-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-430-[titleContainerView]-(>=20)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];


	[constraints addObject:[NSLayoutConstraint constraintWithItem:projectMediaView
														attribute:NSLayoutAttributeBottom
														relatedBy:NSLayoutRelationEqual
														   toItem:self.textContainerView
														attribute:NSLayoutAttributeBottom
													   multiplier:1.0f
														 constant:0.0f]];

	return constraints;
}


- (Class)mediaVewControllerClass
{
	return [BHRiPhoneProjectMediaViewController class];
}

- (CGFloat)titleContainerViewLeadingSpaceForOrientation:(UIInterfaceOrientation)orientation
{
	if (UIInterfaceOrientationIsPortrait(orientation)) {
		return 100.0f;
	}
	return 440.0f;
}

@end
