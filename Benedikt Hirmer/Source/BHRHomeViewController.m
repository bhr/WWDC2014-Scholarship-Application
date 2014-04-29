//
//  BHRHomeViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/11/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRHomeViewController.h"
#import "BHRTriangleView.h"

@interface BHRHomeViewController ()

@property (nonatomic, strong) NSArray *customConstraints;

@property (weak, nonatomic) IBOutlet UIImageView *myPhotoImageView;
@property (weak, nonatomic) IBOutlet UIView *textContainerView;
@property (weak, nonatomic) IBOutlet BHRTriangleView *triangleView;

@end

@implementation BHRHomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

	self.myPhotoImageView.layer.shadowOpacity = 1.0f;
	self.myPhotoImageView.layer.shadowOffset = CGSizeMake(0.f, 0.f);

	[self setUpMotionEffects];

	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(deviceOrientationDidChange:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];


}


#pragma mark - Animation and FX

- (void)updateScrollEffectWithRelativeOffset:(CGFloat)relativeOffset
						 viewControllerIndex:(NSUInteger)idx
							   isCurrentPage:(BOOL)isCurrentPage
{
	[super  updateScrollEffectWithRelativeOffset:relativeOffset
							 viewControllerIndex:idx
								   isCurrentPage:isCurrentPage];
	
	self.triangleView.layer.opacity = 1.0f - (2.0f * fabs(relativeOffset));
}


- (void)_animateInView:(UIView *)view offset:(CGFloat)offset
{
	view.layer.transform = CATransform3DMakeScale(offset, offset, 1.0f);

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
				   {
					   [UIView animateWithDuration:0.3f
											 delay:0.0f
							usingSpringWithDamping:0.5f
							 initialSpringVelocity:0.5f
										   options:0
										animations:^{
											view.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.0f);
										}
										completion:nil];
				   });
}

- (void)setUpMotionEffects
{
	UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
																										type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];

	verticalMotionEffect.minimumRelativeValue = @(-25);
	verticalMotionEffect.maximumRelativeValue = @(25);

	UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
																										  type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];

	horizontalMotionEffect.minimumRelativeValue = @(-25);
	horizontalMotionEffect.maximumRelativeValue = @(25);


	UIMotionEffectGroup *group = [UIMotionEffectGroup new];

	group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];

	[self.myPhotoImageView addMotionEffect:group];


	UIInterpolatingMotionEffect *verticalShadowMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"shadowOffset.height"
																											  type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];

	verticalShadowMotionEffect.minimumRelativeValue = @(3);
	verticalShadowMotionEffect.maximumRelativeValue = @(-3);

	UIInterpolatingMotionEffect *horizontalShadowMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"shadowOffset.width"
																												type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];

	horizontalShadowMotionEffect.minimumRelativeValue = @(3);
	horizontalShadowMotionEffect.maximumRelativeValue = @(-3);


	UIMotionEffectGroup *shadowGroup = [UIMotionEffectGroup new];

	shadowGroup.motionEffects = @[horizontalShadowMotionEffect, horizontalShadowMotionEffect];

	[self.myPhotoImageView addMotionEffect:shadowGroup];
}


#pragma mark - Orientation

- (void)deviceOrientationDidChange:(NSNotificationCenter *)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	[self _updateConstraintsForOrientation:(UIInterfaceOrientation)orientation];

	[self.view layoutIfNeeded];

	[self _animateInView:self.myPhotoImageView offset:0.5f];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
								duration:(NSTimeInterval)duration
{
	[self _updateConstraintsForOrientation:toInterfaceOrientation];
}

#pragma mark - Constraints

- (void)_updateConstraintsForOrientation:(UIInterfaceOrientation)orientation
{
	if (self.customConstraints)
	{
		[self.view removeConstraints:self.customConstraints];
	}

	NSArray *newConstraints = nil;

	if (UIInterfaceOrientationIsPortrait(orientation)) {
		newConstraints = [self _portraitConstraints];
	}
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		newConstraints = [self _landscapeConstraints];
	}

	if (newConstraints != nil) {
		[self.view addConstraints:newConstraints];
	}


	self.customConstraints = newConstraints;
}

- (NSArray *)_portraitConstraints
{
	NSMutableArray *constraints = [@[] mutableCopy];

	NSDictionary *viewsDict = NSDictionaryOfVariableBindings(_myPhotoImageView, _textContainerView);

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[_myPhotoImageView]-50-[_textContainerView]-(>=0)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-110-[_textContainerView]-110-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObject:[NSLayoutConstraint constraintWithItem:self.view
														attribute:NSLayoutAttributeCenterX
														relatedBy:NSLayoutRelationEqual
														   toItem:self.myPhotoImageView
														attribute:NSLayoutAttributeCenterX
													   multiplier:1.0f
														 constant:0.0f]];


	return constraints;
}

- (NSArray *)_landscapeConstraints
{
	NSMutableArray *constraints = [@[] mutableCopy];

	NSDictionary *viewsDict = NSDictionaryOfVariableBindings(_myPhotoImageView, _textContainerView);

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-110-[_myPhotoImageView]-70-[_textContainerView]-(>=0)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[constraints addObject:[NSLayoutConstraint constraintWithItem:self.view
														attribute:NSLayoutAttributeCenterY
														relatedBy:NSLayoutRelationEqual
														   toItem:self.myPhotoImageView
														attribute:NSLayoutAttributeCenterY
													   multiplier:1.0f
														 constant:0.0f]];

	[constraints addObject:[NSLayoutConstraint constraintWithItem:self.view
														attribute:NSLayoutAttributeCenterY
														relatedBy:NSLayoutRelationEqual
														   toItem:self.textContainerView
														attribute:NSLayoutAttributeCenterY
													   multiplier:1.0f
														 constant:0.0f]];



	return constraints;
}

@end
