//
//  UIColor+BHRExtensions.h
//  LGGradingMobile
//
//  Created by Benedikt Hirmer on 1/10/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BHRExtensions)

+ (UIColor *)randomColor;

- (UIColor *)colorByAddingBrightness:(CGFloat)brightnessOffset;
- (UIColor *)colorByAddingAlpha:(CGFloat)alphaOffset;

/**
 * Works only on RGB color spaces
 */
- (UIColor *)colorByInterpolatingWithColor:(UIColor *)color;
- (UIColor *)colorByInterpolatingWithColor:(UIColor *)color relativeOffset:(CGFloat)relativeOffset;

+ (UIColor *)defaultSystemTintColor;
+ (UIColor *)keyboardBackgroundColor;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
- (BOOL)isWhiteColor;

@end
