//
//  BHRProjectsViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/12/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRProjectsViewController.h"
#import "BHRProjectViewController.h"
#import "BHROtherProjectsViewController.h"

#import "BHRSinglePageProjectItem.h"
#import "BHROtherProjectItem.h"

@interface BHRProjectsViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *singlePageProjects;
@property (nonatomic, strong) NSArray *pageViewControllers;

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) BOOL isRotating;

@end

@implementation BHRProjectsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

	[self _setUpScrollView];
	[self _configureProjects];
	[self _updateCurrentPage];
	[self _updateBackgroundColor];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)_setUpScrollView
{
	self.scrollView.pagingEnabled = YES;
	self.scrollView.bounces = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;

	self.scrollView.backgroundColor = [UIColor clearColor];
}

- (void)bhr_rootSubviewDidAppear;
{
	[super bhr_rootSubviewDidAppear];
	[self _updateCurrentPage];
}

- (void)bhr_rootSubviewDidDisappear;
{
	[super bhr_rootSubviewDidDisappear];
	[self _resetIsCurrentPage];
}


- (void)_configureProjects
{
	NSMutableArray *pageViewControllers = [@[] mutableCopy];
	NSMutableDictionary *viewsDict = [NSMutableDictionary dictionary];
	__block NSMutableString *horizontalFormat = [NSMutableString stringWithString:@"H:|"];
	__block NSString *referenceViewId = nil;

	[self.singlePageProjects enumerateObjectsUsingBlock:^(BHRSinglePageProjectItem *project, NSUInteger idx, BOOL *stop)
	{
		Class projectViewClass = [BHRProjectViewController classForType:project.type];
		BHRProjectViewController *projectViewController = [[projectViewClass alloc] init];
		projectViewController.item = project;

		NSString *identifier = [NSString stringWithFormat:@"projectView%lu",(unsigned long)idx];

		[viewsDict setObject:projectViewController.view
					  forKey:identifier];

		if (!referenceViewId) {
			referenceViewId = identifier;
		}

		[pageViewControllers addObject:projectViewController];

		[self _addConstraintsForViewController:projectViewController
								withIdentifier:identifier
						horizontalFormatString:&horizontalFormat];
	}];

	//add other projects
	BHROtherProjectsViewController *otherProjectsViewController = [[BHROtherProjectsViewController alloc] init];
	otherProjectsViewController.projectItems = [self _otherProjects];
	NSString *identifier = @"otherProjects";

	[viewsDict setObject:otherProjectsViewController.view
				  forKey:identifier];

	[self _addConstraintsForViewController:otherProjectsViewController
							withIdentifier:identifier
					horizontalFormatString:&horizontalFormat];

	[pageViewControllers addObject:otherProjectsViewController];

	[horizontalFormat appendString:@"|"];

	[self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat
																			options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
																			metrics:nil
																			  views:viewsDict]];

	self.pageViewControllers = pageViewControllers;
}

- (void)_addConstraintsForViewController:(UIViewController *)viewController
						  withIdentifier:(NSString *)identifier
				  horizontalFormatString:(NSMutableString **)horizontalFormatString
{
	[self addChildViewController:viewController];
	[self.scrollView addSubview:viewController.view];
	[viewController didMoveToParentViewController:self];

	viewController.view.translatesAutoresizingMaskIntoConstraints = NO;

	viewController.view.restorationIdentifier = identifier;

	[*horizontalFormatString appendFormat:@"[%@]", identifier];

	[self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:viewController.view
																attribute:NSLayoutAttributeWidth
																relatedBy:NSLayoutRelationEqual
																   toItem:self.scrollView
																attribute:NSLayoutAttributeWidth
															   multiplier:1.0f
																 constant:0.0f]];

	[self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:viewController.view
																attribute:NSLayoutAttributeHeight
																relatedBy:NSLayoutRelationEqual
																   toItem:self.scrollView
																attribute:NSLayoutAttributeHeight
															   multiplier:1.0f
																 constant:0.0f]];
}

#pragma mark - UIScrollViewDelegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (!self.isRotating) {
		[self _resetIsCurrentPage];
	}

	[self _updateParallaxEffect];
	[self _updateBackgroundColor];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[self _updateCurrentPage];
}

#pragma mark - Helper

- (void)_resetIsCurrentPage
{
	if (self.currentPage < [self.singlePageProjects count])
	{
		BHRProjectViewController *projectViewController = [self.pageViewControllers objectAtIndex:self.currentPage];
		projectViewController.isCurrentPage = NO;
	}
}

- (void)_updateParallaxEffect
{
	[self.pageViewControllers enumerateObjectsUsingBlock:^(BHRProjectViewController *childViewController, NSUInteger idx, BOOL *stop)
	 {
		 CGFloat relativeOffset = [self _relativeOffsetForPageAtIndex:idx
													withContentOffset:self.scrollView.contentOffset];

		 //		NSLog(@"%d %f",idx, relativeOffset);
		 if (relativeOffset > 1.0f || relativeOffset < -1.0f) {
			 return;
		 }

		 if (![childViewController isKindOfClass:[BHRProjectViewController class]]) {
			 return;
		 }

		 [childViewController scrollWithRelativeOffset:relativeOffset];
	 }];
}

- (void)_updateBackgroundColor
{
	NSUInteger otherPageIndex = NSNotFound;
	UIColor *otherBackgroundColor = nil;

	NSUInteger currentPage = [self _currentPageWithContentOffset:self.scrollView.contentOffset];

	CGFloat relativeOffset = [self _relativeOffsetForPageAtIndex:currentPage
											   withContentOffset:self.scrollView.contentOffset];


	//scrolling to the right of current page
	if (relativeOffset < 0.0f &&
		currentPage < [self.pageViewControllers count] - 1)
	{
		otherPageIndex = currentPage + 1;
	}
	else if (relativeOffset > 0.0f &&
			 currentPage > 0)
	{
		otherPageIndex = currentPage - 1;
	}

	otherBackgroundColor = [self _backgroundColorForPageAtIndex:otherPageIndex];
	UIColor *currentItemBackgroundColor = [self _backgroundColorForPageAtIndex:currentPage];

	self.view.backgroundColor = [currentItemBackgroundColor colorByInterpolatingWithColor:otherBackgroundColor
																		   relativeOffset:relativeOffset];
}

- (UIColor *)_backgroundColorForPageAtIndex:(NSUInteger)index
{
	UIColor *otherBackgroundColor = nil;

	if (index != NSNotFound)
	{
		//last is other projects!
		if (index == [self.singlePageProjects count])
		{
			otherBackgroundColor = [(BHROtherProjectsViewController *)[self.pageViewControllers objectAtIndex:index] backgroundColor];
		}
		else
		{
			BHRSinglePageProjectItem *projectItem = [self.singlePageProjects objectAtIndex:index];
			otherBackgroundColor = [projectItem backgroundColor];
		}
	}

	return otherBackgroundColor;
}


- (void)_updateCurrentPage
{
	NSUInteger newPage = [self _currentPageWithContentOffset:self.scrollView.contentOffset];

	if (self.isInFocus)
	{
		[self.pageViewControllers enumerateObjectsUsingBlock:^(BHRProjectViewController *childViewController, NSUInteger idx, BOOL *stop)
		 {
			 if ([childViewController isKindOfClass:[BHRProjectViewController class]] == NO) {
				 return;
			 }

			 if (idx == newPage) {
				 childViewController.isCurrentPage = YES;
			 }
			 else {
				 childViewController.isCurrentPage = NO;
			 }
		 }];
	}

	self.currentPage = newPage;
}

- (NSInteger)_currentPageWithContentOffset:(CGPoint)contentContentOffset
{
	CGFloat pageWidth = [self _pageSize].width;
	NSInteger nearestPage = floor((contentContentOffset.x - pageWidth / 2) / pageWidth) + 1;

	return nearestPage;
}


- (CGSize)_pageSize
{
	CGRect frame = self.view.bounds;
	return CGSizeMake((CGRectGetWidth(frame)),
					  CGRectGetHeight(frame));
}

- (CGRect)_rectForPageAtIndex:(NSUInteger)pageIndex
{
	CGRect frame = self.view.bounds;

	CGSize pageSize = [self _pageSize];
	CGFloat originX = pageSize.width * pageIndex;

	frame.origin.x = originX;

	return frame;
}

- (CGFloat)_relativeOffsetForPageAtIndex:(NSUInteger)pageIndex withContentOffset:(CGPoint)contentOffset
{
	CGRect pageRect = [self _rectForPageAtIndex:pageIndex];
	CGFloat offsetDifference = CGRectGetMinX(pageRect) - contentOffset.x;
	CGFloat pageWidth = [self _pageSize].width;

	CGFloat relativeOffsetDiff = offsetDifference / pageWidth;
	return relativeOffsetDiff;
}

#pragma mark - Auto rotation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	CGRect currentPageRect = [self _rectForPageAtIndex:self.currentPage];

	self.isRotating = YES;

	[self.scrollView setContentOffset:currentPageRect.origin
							 animated:NO];

	self.isRotating = NO;
}


#pragma mark - Data Source

- (NSArray *)singlePageProjects
{
	if (!_singlePageProjects)
	{
		NSMutableArray *projects = [@[] mutableCopy];
		NSArray *projectsDictionaries = [[self _projectsDictionary] objectForKey:@"singlePageProjects"];

		[projectsDictionaries enumerateObjectsUsingBlock:^(NSDictionary *projectDict, NSUInteger idx, BOOL *stop)
		 {
			 BHRSinglePageProjectItem *projectItem = [[BHRSinglePageProjectItem alloc] initWithDictionary:projectDict];
			 [projects addObject:projectItem];
		 }];

		_singlePageProjects = [projects copy];
	}

	return _singlePageProjects;
}

- (NSArray *)_otherProjects
{
	NSMutableArray *projects = [@[] mutableCopy];
	NSArray *projectsDictionaries = [[self _projectsDictionary] objectForKey:@"otherProjects"];

	for (NSDictionary *projectDict in projectsDictionaries)
	{
		BHROtherProjectItem *projectItem = [[BHROtherProjectItem alloc] initWithDictionary:projectDict];
		[projects addObject:projectItem];
	}

	return [projects copy];
}

- (NSDictionary *)_projectsDictionary
{
	NSURL *projectsURL = [[NSBundle mainBundle] URLForResource:@"Projects" withExtension:@"plist"];
	NSDictionary *projectsDictionaries = [NSDictionary dictionaryWithContentsOfURL:projectsURL];

	return projectsDictionaries;
}


@end
