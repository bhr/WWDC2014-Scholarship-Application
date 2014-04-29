//
//  LGAdditions.m
//  LGGradingMobile
//
//  Created by Benedikt Hirmer on 1/10/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRAdditions.h"

@implementation BHRAdditions

@end

CGFloat clampf(CGFloat x, CGFloat low, CGFloat high)
{
	if (x > high) {
		return high;
	}
	if (x < low) {
		return low;
	}
	
	return x;
}

CGMutablePathRef CGPathCreatePathRotatedAroundBoundingBoxCenter(CGPathRef path, CGFloat radians)
{
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, center.x, center.y);
    transform = CGAffineTransformRotate(transform, radians);
    transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
    return CGPathCreateMutableCopyByTransformingPath(path, &transform);
}

CGRect CGRectWithScale(CGRect rect, CGFloat scale)
{
	return CGRectMake(scale * rect.origin.x,
					  scale * rect.origin.y,
					  scale * rect.size.width,
					  scale * rect.size.height);
}

NSString *NSStringFromBOOL(BOOL boolean)
{
	if (boolean) {
		return @"YES";
	}
	return @"NO";
}