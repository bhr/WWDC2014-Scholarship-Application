//
//  BHRInterestsItemView.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/14/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRInterestsGroupView.h"

@implementation BHRInterestsGroupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		[self sharedInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		[self sharedInit];
	}
	return self;
}

- (void)sharedInit
{
	[self setUpMotionEffects];
}

- (void)setUpMotionEffects
{
	UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];

	verticalMotionEffect.minimumRelativeValue = @(-50);

	verticalMotionEffect.maximumRelativeValue = @(50);

	UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];

	horizontalMotionEffect.minimumRelativeValue = @(-50);

	horizontalMotionEffect.maximumRelativeValue = @(50);



	UIMotionEffectGroup *group = [UIMotionEffectGroup new];

	group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];

	[self addMotionEffect:group];
}



@end
