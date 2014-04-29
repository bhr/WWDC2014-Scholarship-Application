//
//  BHRTriangleView.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/14/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRTriangleView.h"

@interface BHRTriangleView ()

@property (nonatomic, strong) CAShapeLayer *triangleLayer;

@end

@implementation BHRTriangleView

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
	self.backgroundColor = [UIColor clearColor];
	
	_triangleLayer = [CAShapeLayer layer];
	_triangleLayer.fillColor = [[UIColor colorWithWhite:0.5f alpha:0.5f] CGColor];
	_triangleLayer.contentsScale = [[UIScreen mainScreen] scale];

	[self.layer addSublayer:_triangleLayer];
}


- (void)layoutSubviews
{
	[super layoutSubviews];

	self.triangleLayer.frame = self.bounds;
	self.triangleLayer.path = [[self trianglePath] CGPath];
}


- (UIBezierPath *)trianglePath
{
	UIBezierPath *trianglePath = [UIBezierPath bezierPath];

	[trianglePath moveToPoint:CGPointMake(0.0f, 0.0f)];
	[trianglePath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), 0.0f)];;
	[trianglePath addLineToPoint:CGPointMake(0.5f * CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
	[trianglePath closePath];

	return trianglePath;
}

@end
