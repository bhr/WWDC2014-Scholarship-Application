//
//  BHRRootItemViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/14/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRRootItemViewController.h"

@interface BHRRootItemViewController ()

@end

@implementation BHRRootItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bhr_rootSubviewDidAppear
{
	_isInFocus = YES;
}

- (void)bhr_rootSubviewDidDisappear
{
	_isInFocus = NO;
}

- (void)updateScrollEffectWithRelativeOffset:(CGFloat)relativeOffset
						 viewControllerIndex:(NSUInteger)idx
							   isCurrentPage:(BOOL)isCurrentPage
{
	if (isCurrentPage) {
		return;
	}

	if (relativeOffset > 1.0f || relativeOffset < -1.0f) {
		return;
	}

	CGFloat newOffset = CGRectGetHeight(self.view.frame) * idx - (0.5f * relativeOffset * CGRectGetHeight(self.view.frame));

	CGRect newFrame = self.view.frame;
	newFrame.origin.y = newOffset;
	self.view.frame = newFrame;

	self.overlayView.alpha = [self _offsetAlphaWithRelativeOffset:relativeOffset];
}

- (CGFloat)_offsetAlphaWithRelativeOffset:(CGFloat)relativeOffset
{
	CGFloat alpha = fabs(relativeOffset);

	alpha = floorf(alpha * 100 + 0.5) / 100;

	return alpha;
}


#pragma mark -


- (UIView *)overlayView
{
	if (!_overlayView)
	{
		_overlayView = [[UIView alloc] initWithFrame:CGRectZero];
		_overlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
		_overlayView.translatesAutoresizingMaskIntoConstraints = NO;
		_overlayView.alpha = 0.0f;

		[self.view addSubview:_overlayView];

		NSDictionary *views = @{@"subview": _overlayView};

		NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[subview]-(0)-|"
																	   options:0
																	   metrics:0
																		 views:views];
		[self.view addConstraints:constraints];

		constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[subview]-(0)-|"
															  options:0
															  metrics:0
																views:views];

		[self.view addConstraints:constraints];


		[self.view bringSubviewToFront:_overlayView];
	}

	return _overlayView;
}

@end
