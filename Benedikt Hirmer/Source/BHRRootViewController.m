//
//  BHRRootViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/11/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRRootViewController.h"
#import "BHRProjectsViewController.h"
#import "BHRRootItemViewController.h"

@interface BHRRootViewController ()

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, assign) NSUInteger currentPage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation BHRRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self _setUpScrollView];
	[self _setUpViewControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_setUpScrollView
{
	self.scrollView.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];

	self.scrollView.pagingEnabled = YES;
	self.scrollView.bounces = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
}

- (void)_setUpViewControllers
{
	self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

	NSArray *itemStoryboardIDs = [self _itemStoryboardIDs];
	NSMutableArray *viewControllers = [@[] mutableCopy];
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
															 bundle:[NSBundle mainBundle]];

	[itemStoryboardIDs enumerateObjectsUsingBlock:^(NSString *storyboardID, NSUInteger idx, BOOL *stop)
	{
		UIViewController *viewController = [mainStoryboard instantiateViewControllerWithIdentifier:storyboardID];
		[viewControllers addObject:viewController];
	}];

	self.viewControllers = [viewControllers copy];

	[self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop)
	{
		[self _loadScrollViewWithPage:idx];
	}];
}

- (void)_loadScrollViewWithPage:(NSUInteger)pageIndex
{
	if (pageIndex >= [self.viewControllers count]) {
        return;
    }

    UIViewController *controller = self.viewControllers[pageIndex];

	// add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
		CGRect frame = [self _rectForPageAtIndex:pageIndex];
		controller.view.frame = frame;

        [self addChildViewController:controller];

		UIView *preView = nil;
		if (pageIndex > 0) {
			preView = [self.viewControllers[pageIndex - 1] view];
		}

		if (preView == nil) {
			[self.scrollView addSubview:controller.view];
		}
		else {
			[self.scrollView insertSubview:controller.view
							  belowSubview:preView];
		}

		[controller didMoveToParentViewController:self];

		controller.view.layer.shadowColor = [UIColor blackColor].CGColor;
		controller.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
		controller.view.layer.shadowRadius = 4.0f;
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self _updateScrollEffect];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	self.currentPage = [self _computeCurrentPage];

	if (self.currentPage < [self.viewControllers count])
	{
		BHRProjectsViewController *currentViewController = [self.viewControllers objectAtIndex:self.currentPage];
		[self.scrollView bringSubviewToFront:currentViewController.view];
		[currentViewController bhr_rootSubviewDidAppear];
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	if (self.currentPage < [self.viewControllers count])
	{
		BHRProjectsViewController *currentViewController = [self.viewControllers objectAtIndex:self.currentPage];
		[currentViewController bhr_rootSubviewDidDisappear];
	}
}


- (void)_updateScrollEffect
{
	[self.viewControllers enumerateObjectsUsingBlock:^(BHRRootItemViewController *childViewController, NSUInteger idx, BOOL *stop)
	 {
		 CGFloat relativeOffset = [self _relativeOffsetForPageAtIndex:idx
													withContentOffset:self.scrollView.contentOffset];


		 [childViewController updateScrollEffectWithRelativeOffset:relativeOffset
											   viewControllerIndex:idx
													 isCurrentPage:(idx == _currentPage)];
	 }];

}

#pragma mark - Helpers


- (CGSize)_pageSize
{
	CGRect frame = self.view.bounds;
	return CGSizeMake(CGRectGetWidth(frame),
					  CGRectGetHeight(frame));
}

- (CGFloat)_relativeOffsetForPageAtIndex:(NSUInteger)pageIndex withContentOffset:(CGPoint)contentOffset
{
	CGRect pageRect = [self _rectForPageAtIndex:pageIndex];
	CGFloat offsetDifference = CGRectGetMinY(pageRect) - contentOffset.y;
	CGFloat pageHeight = [self _pageSize].height;

	CGFloat relativeOffsetDiff = offsetDifference / pageHeight;
	return relativeOffsetDiff;
}

- (CGRect)_rectForPageAtIndex:(NSUInteger)pageIndex
{
	CGRect frame = self.view.bounds;

	CGSize pageSize = [self _pageSize];
	CGFloat originY = pageSize.height * pageIndex;

	frame.origin.y = originY;

	return frame;
}


- (NSInteger)_computeCurrentPage
{
	return [self _currentPageWithContentOffset:self.scrollView.contentOffset];
}

- (NSInteger)_currentPageWithContentOffset:(CGPoint)contentContentOffset
{
	CGFloat pageHeight = [self _pageSize].height;
	NSInteger nearestPage = floor((contentContentOffset.y - pageHeight / 2) / pageHeight) + 1;

	return nearestPage;
}

#pragma mark -

- (NSArray *)_itemStoryboardIDs
{
	return @[
			 @"homeViewController",
			 @"projectsViewController",
			 @"interestsViewController",
			 @"endViewController",
			 ];
}

#pragma mark - Autorotate

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];

	[self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop)
	 {
		 CGRect viewControllerFrame = [self _rectForPageAtIndex:idx];
		 viewController.view.frame = viewControllerFrame;

		 if (idx == self.currentPage)
		 {
			 [self.scrollView setContentOffset:viewControllerFrame.origin
									  animated:NO];
		 }
	 }];

	dispatch_async(dispatch_get_main_queue(), ^{
					   self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
																self.scrollView.frame.size.height * [self.viewControllers count]);

				   });

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	[super willAnimateRotationToInterfaceOrientation:interfaceOrientation
											duration:duration];

	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
											 self.scrollView.frame.size.height * [self.viewControllers count]);

}

@end
