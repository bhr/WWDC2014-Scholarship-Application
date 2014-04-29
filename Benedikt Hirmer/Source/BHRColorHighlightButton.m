//
//  BHRColorHighlightButton.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/14/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRColorHighlightButton.h"

@interface BHRColorHighlightButton ()

@property (nonatomic, strong) UIColor *originalBackgroundColor;
@property (nonatomic, assign) BOOL useHighlightBackgroundColor;

@end

@implementation BHRColorHighlightButton

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
	UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
																									action:@selector(handleLongPress:)];
	gestureRecognizer.minimumPressDuration = 0.0f;
	[self addGestureRecognizer:gestureRecognizer];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
	[super setBackgroundColor:backgroundColor];

	if (!self.useHighlightBackgroundColor) {
		self.originalBackgroundColor = [backgroundColor copy];
	}
}


- (void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
	if (sender.state == UIGestureRecognizerStateBegan)
	{
		self.useHighlightBackgroundColor = YES;

		if ([self.delegate respondsToSelector:@selector(colorHighlightButtonDidTouchDownInside:)])
		{
			[self.delegate colorHighlightButtonDidTouchDownInside:self];
		}

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
		{
			sender.enabled = NO;
			sender.enabled = YES;
		});
	}

	if (sender.state == UIGestureRecognizerStateEnded ||
		sender.state == UIGestureRecognizerStateCancelled ||
		sender.state == UIGestureRecognizerStateFailed)
    {
		self.useHighlightBackgroundColor = NO;
    }

	if (sender.state == UIGestureRecognizerStateEnded)
	{
		CGPoint location = [sender locationInView:self];

        if (CGRectContainsPoint(self.bounds, location))
		{
			if ([self.delegate respondsToSelector:@selector(colorHighlightButtonDidTouchUpInside:)])
			{
				[self.delegate colorHighlightButtonDidTouchUpInside:self];
			}
		}
	}
}

- (void)setUseHighlightBackgroundColor:(BOOL)useHighlightBackgroundColor
{

	if (useHighlightBackgroundColor != _useHighlightBackgroundColor)
	{
		_useHighlightBackgroundColor = useHighlightBackgroundColor;

		if (_useHighlightBackgroundColor)
		{
			self.backgroundColor = [self.originalBackgroundColor colorByAddingBrightness:-0.3f];
		}
		else
		{
			self.backgroundColor = [self.originalBackgroundColor copy];
		}
	}
}


@end
