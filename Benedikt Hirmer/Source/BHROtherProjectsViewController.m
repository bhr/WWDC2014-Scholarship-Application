//
//  BHROtherProjectsViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHROtherProjectsViewController.h"
#import "BHROtherProjectItem.h"
#import "BHROtherProjectView.h"

@interface BHROtherProjectsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *otherProjectLabel;

@end

@implementation BHROtherProjectsViewController

- (instancetype)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
						   bundle:nil];
    if (self)
	{
		_backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProjectItems:(NSArray *)projectItems
{
	UIView *containerContainerView = [self _createContainerContainerView];

	NSMutableArray *containerViews = [@[] mutableCopy];
	NSMutableString *verticalFormatString = [@"V:|" mutableCopy];
	NSMutableDictionary *viewsDict = [@{} mutableCopy];

	[projectItems enumerateObjectsUsingBlock:^(BHROtherProjectItem *item, NSUInteger idx, BOOL *stop)
	{
		if (idx%2 != 0) {
			return;
		}

		UIView *containerView = [[UIView alloc] initWithFrame:CGRectZero];
		containerView.translatesAutoresizingMaskIntoConstraints = NO;

		[containerContainerView addSubview:containerView];
		[containerViews addObject:containerView];

		NSString *viewID = [NSString stringWithFormat:@"containerView%lu", (unsigned long)idx];
		[viewsDict setObject:containerView
					  forKey:viewID];

		if (idx > 0) {
			[verticalFormatString appendFormat:@""];
		}

		[verticalFormatString appendFormat:@"-20-[%@]", viewID];

		NSString *horizontalFormat = [NSString stringWithFormat:@"H:|[%@]|", viewID];
		[containerContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat
																					   options:0
																					   metrics:nil
																						 views:viewsDict]];

		NSArray *items;

		if (idx < [projectItems count] - 1) {
			items = @[item, [projectItems objectAtIndex:idx + 1]];
		}
		else {
			items = @[item];
		}

		[self _projectItemViewsWithProjectItems:items
								  containerView:containerView];
	}];

	[verticalFormatString appendFormat:@"-20-|"];

	[containerContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalFormatString
																				   options:0
																				   metrics:nil
																					 views:viewsDict]];
}

- (NSArray *)_projectItemViewsWithProjectItems:(NSArray *)projectItems
								 containerView:(UIView *)containerView
{
	NSAssert([projectItems count] < 3, @"Project items must be less than two");
	NSAssert([projectItems count] > 0, @"Project items must be greater than zero");

	NSMutableArray *itemViews = [@[] mutableCopy];

	__block NSString *referenceID = nil;
	NSMutableString *horizontalVisualFormatString = [@"H:|" mutableCopy];
	NSMutableDictionary *viewsDict = [@{} mutableCopy];

	[projectItems enumerateObjectsUsingBlock:^(BHROtherProjectItem *item, NSUInteger idx, BOOL *stop)
	{
		BHROtherProjectView *itemView = [[BHROtherProjectView alloc] initWithFrame:CGRectZero];
		itemView.item = item;

		[containerView addSubview:itemView];
		[itemViews addObject:itemView];

		NSString *viewID = [NSString stringWithFormat:@"itemView%lu", (unsigned long)idx];
		[viewsDict setObject:itemView
					  forKey:viewID];

		if (referenceID == nil) {
			referenceID = viewID;
		}

		[horizontalVisualFormatString appendFormat:@"-40-[%@(==%@)]", viewID, referenceID];
	}];

	[horizontalVisualFormatString appendFormat:@"-40-|"];

	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalVisualFormatString
																		  options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
																		  metrics:nil
																			views:viewsDict]];

	NSString *verticalVisualFormatString = [NSString stringWithFormat:@"V:|[%@]|", referenceID];
	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalVisualFormatString
																		  options:0
																		  metrics:nil
																			views:viewsDict]];

	return itemViews;
}


- (UIView *)_createContainerContainerView
{
	UIView *containerContainerView = [[UIView alloc] initWithFrame:CGRectZero];
	containerContainerView.translatesAutoresizingMaskIntoConstraints = NO;

	[self.view addSubview:containerContainerView];

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[containerContainerView]-(>=0)-|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(containerContainerView)]];

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=40)-[_otherProjectLabel]-20-[containerContainerView]-(>=0)-|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(containerContainerView, _otherProjectLabel)]];

	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:containerContainerView
														  attribute:NSLayoutAttributeCenterX
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeCenterX
														 multiplier:1.0f
														   constant:0.0f]];

	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:containerContainerView
														  attribute:NSLayoutAttributeCenterY
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeCenterY
														 multiplier:1.0f
														   constant:50.0f]];
	return containerContainerView;
}


@end
