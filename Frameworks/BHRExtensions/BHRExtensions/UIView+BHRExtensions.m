//
//  UIView+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 2/27/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIView+BHRExtensions.h"

@implementation UIView (BHRExtensions)


-(UIImage *)blurredSnapshotWithEffect:(UIImageBlurEffect)effect
{
	// Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);

    // There he is! The new API method
	[self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];

    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();

	UIImage *blurredSnapshotImage;

	//	blurredSnapshotImage = [snapshotImage applyDarkEffect];
	blurredSnapshotImage = [snapshotImage applyEffect:effect];
	//	blurredSnapshotImage = [snapshotImage applyLightEffect];
	//	blurredSnapshotImage = [snapshotImage applyExtraLightEffect];

    // Be nice and clean your mess up
    UIGraphicsEndImageContext();

    return blurredSnapshotImage;
}


-(UIImage *)blurredSnapshot
{
	return [self blurredSnapshotWithEffect:UIImageBlurEffectNeutral];
}

- (UIImage *)snapshot
{
	// Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
	
    // There he is! The new API method
	[self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
	
    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
	return snapshotImage;
}

- (void)insertConstraintBasedSubview:(UIView *)view belowSubView:(UIView *)otherView
{
	[self insertSubview:view belowSubview:otherView];
	[self _addConstraintsForSubview:view withInsets:UIEdgeInsetsZero];
}

- (void)insertConstraintBasedSubview:(UIView *)view aboveSubView:(UIView *)otherView
{
	[self insertSubview:view aboveSubview:otherView];
	[self _addConstraintsForSubview:view withInsets:UIEdgeInsetsZero];
}

- (void)addConstraintBasedSubview:(UIView *)view
{
	[self addConstraintBasedSubview:view withInsets:UIEdgeInsetsZero];
}

- (void)addConstraintBasedSubview:(UIView *)view withInsets:(UIEdgeInsets)insets
{
	[self addSubview:view];
	[self _addConstraintsForSubview:view withInsets:insets];
}

- (void)_addConstraintsForSubview:(UIView *)view withInsets:(UIEdgeInsets)insets
{
	view.frame = self.bounds;
	[self setTranslatesAutoresizingMaskIntoConstraints:NO];

	NSDictionary *views = @{@"subview": view};
	NSDictionary *metrics = @{
							  @"left": @(insets.left),
							  @"right": @(insets.right),
							  @"top": @(insets.top),
							  @"bottom": @(insets.bottom),
							  };

	NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[subview]-right-|"
																   options:0
																   metrics:metrics
																	 views:views];
	[self addConstraints:constraints];

	constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[subview]-bottom-|"
														  options:0
														  metrics:metrics
															views:views];

	[self addConstraints:constraints];
}

#pragma mark -

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder)
	{
        [self resignFirstResponder];
        return YES;
    }
	
    for (UIView *subView in self.subviews)
	{
        if ([subView findAndResignFirstResponder]) {
            return YES;
		}
    }
	
    return NO;
}

@end
