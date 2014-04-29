//
//  BHRiPadProjectPortraitViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRiPadProjectPortraitViewController.h"
#import "BHRiPadProjectPortraitMediaViewController.h"

@interface BHRiPadProjectPortraitViewController ()

@end

@implementation BHRiPadProjectPortraitViewController

- (NSArray *)portraitConstraints
{
	NSMutableArray *constraints = [@[] mutableCopy];

	UIView *projectMediaView = self.projectMediaViewController.view;
	UIView *titleContainerView = self.titleContainerView;
	UIView *textContainerView = self.textContainerView;
	NSDictionary *viewsDict = NSDictionaryOfVariableBindings(titleContainerView, textContainerView, projectMediaView);

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[titleContainerView]-20-[projectMediaView]-10-[textContainerView(==240)]"
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

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[titleContainerView]-(>=20)-|"
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

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[titleContainerView]-100-[textContainerView]-40-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(120)-[projectMediaView]-20-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[textContainerView(==440)]-20-[projectMediaView]-20-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[titleContainerView]-(>=20)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	return constraints;
}


- (Class)mediaVewControllerClass
{
	return [BHRiPadProjectPortraitMediaViewController class];
}


@end
