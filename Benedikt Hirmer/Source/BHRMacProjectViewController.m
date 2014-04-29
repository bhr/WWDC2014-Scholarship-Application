//
//  BHRMacProjectViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/12/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRMacProjectViewController.h"
#import "BHRMacProjectMediaViewController.h"

@interface BHRMacProjectViewController ()

@end

@implementation BHRMacProjectViewController


- (NSArray *)portraitConstraints
{
	NSMutableArray *constraints = [@[] mutableCopy];

	UIView *projectMediaView = self.projectMediaViewController.view;
	UIView *titleContainerView = self.titleContainerView;
	UIView *textContainerView = self.textContainerView;
	NSDictionary *viewsDict = NSDictionaryOfVariableBindings(titleContainerView, textContainerView, projectMediaView);

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[titleContainerView]-40-[projectMediaView]-40-[textContainerView(==270)]-40-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[projectMediaView]-40-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[textContainerView]-40-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[titleContainerView]-(>=20)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];


	return constraints;
}

- (NSArray *)landscapeConstraints
{
	NSMutableArray *constraints = [@[] mutableCopy];

	UIView *projectMediaView = self.projectMediaViewController.view;
	UIView *titleContainerView = self.titleContainerView;
	UIView *textContainerView = self.textContainerView;
	NSDictionary *viewsDict = NSDictionaryOfVariableBindings(titleContainerView, textContainerView, projectMediaView);

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[titleContainerView]-20-[projectMediaView]-40-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[projectMediaView]-0-[textContainerView]-20-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-150-[titleContainerView]-(>=20)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];


	[constraints addObject:[NSLayoutConstraint constraintWithItem:projectMediaView
														attribute:NSLayoutAttributeTop
														relatedBy:NSLayoutRelationEqual
														   toItem:self.textContainerView
														attribute:NSLayoutAttributeTop
													   multiplier:1.0f
														 constant:-50.0f]];

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
	return [BHRMacProjectMediaViewController class];
}


@end
