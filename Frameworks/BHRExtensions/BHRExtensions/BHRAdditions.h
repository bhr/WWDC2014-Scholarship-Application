//
//  LGAdditions.h
//  LGGradingMobile
//
//  Created by Benedikt Hirmer on 1/10/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHRAdditions : NSObject

@end

CGFloat clampf(CGFloat x, CGFloat low, CGFloat high);
CGMutablePathRef CGPathCreatePathRotatedAroundBoundingBoxCenter(CGPathRef path, CGFloat radians);
CGRect CGRectWithScale(CGRect rect, CGFloat scale);

NSString *NSStringFromBOOL(BOOL boolean);