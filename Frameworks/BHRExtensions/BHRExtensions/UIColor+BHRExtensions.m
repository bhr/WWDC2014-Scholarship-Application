//
//  UIColor+BHRExtensions.m
//  LGGradingMobile
//
//  Created by Benedikt Hirmer on 1/10/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIColor+BHRExtensions.h"
#import "NSString+BHRExtensions.h"

@implementation UIColor (BHRExtensions)


+ (UIColor *)randomColor
{
	CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
	CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
	CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
	return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (UIColor *)colorByAddingBrightness:(CGFloat)brightnessOffset
{
	CGFloat hue = 0.0f;
	CGFloat saturation = 0.0f;
	CGFloat brightness = 0.0f;
	CGFloat alpha = 0.0f;

	BOOL succeeded = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

	if (succeeded)
	{
		brightness += brightnessOffset;

		return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
	}

	CGFloat white = 0.0f;

	succeeded = [self getWhite:&white alpha:&alpha];

	if (succeeded)
	{
		white += brightnessOffset;

		return [UIColor colorWithWhite:white alpha:alpha];
	}

	return nil;
}

- (UIColor *)colorByAddingAlpha:(CGFloat)alphaOffset
{
	CGFloat hue = 0.0f;
	CGFloat saturation = 0.0f;
	CGFloat brightness = 0.0f;
	CGFloat alpha = 0.0f;

	BOOL succeeded = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

	if (succeeded)
	{
		alpha += alphaOffset;

		return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
	}

	CGFloat white = 0.0f;

	succeeded = [self getWhite:&white alpha:&alpha];

	if (succeeded)
	{
		alpha += alphaOffset;

		return [UIColor colorWithWhite:white alpha:alpha];
	}

	return nil;
}

- (UIColor *)colorByInterpolatingWithColor:(UIColor *)color relativeOffset:(CGFloat)relativeOffset
{
	if (color == nil) {
		color = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
	}

	CGFloat ownColorWeight = 1.0f - fabsf(relativeOffset);
	CGFloat otherColorWeight = 1.0f - ownColorWeight;

	CGFloat firstHue = 0.0f;
	CGFloat firstSaturation = 0.0f;
	CGFloat firstBrightness = 0.0f;
	CGFloat firstAlpha = 0.0f;

	CGFloat secondHue = 0.0f;
	CGFloat secondSaturation = 0.0f;
	CGFloat secondBrightness = 0.0f;
	CGFloat secondAlpha = 0.0f;

	BOOL succeeded = [self getHue:&firstHue saturation:&firstSaturation brightness:&firstBrightness alpha:&firstAlpha];

	NSAssert(succeeded, @"First Color needs to be in RGB color space");

	succeeded = [color getHue:&secondHue saturation:&secondSaturation brightness:&secondBrightness alpha:&secondAlpha];

	NSAssert(succeeded, @"Second Color needs to be in RGB color space");

	return [UIColor colorWithHue:firstHue * ownColorWeight + secondHue * otherColorWeight
					  saturation:firstSaturation * ownColorWeight + secondSaturation * otherColorWeight
					  brightness:firstBrightness * ownColorWeight + secondBrightness * otherColorWeight
						   alpha:firstAlpha * ownColorWeight + secondAlpha * otherColorWeight];
}

- (UIColor *)colorByInterpolatingWithColor:(UIColor *)color
{
	return [self colorByInterpolatingWithColor:color relativeOffset:0.5f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
	if ([hexString length]==3)
	{
		NSString *oneR = [hexString substringWithRange:NSMakeRange(0, 1)];
		NSString *oneG = [hexString substringWithRange:NSMakeRange(1, 1)];
		NSString *oneB = [hexString substringWithRange:NSMakeRange(2, 1)];

		hexString = [NSString stringWithFormat:@"%@%@%@%@%@%@", oneR, oneR, oneG, oneG, oneB, oneB];
	}

	if ([hexString length]!=6)
	{
		return nil;
	}

	CGFloat red = [[hexString substringWithRange:NSMakeRange(0, 2)] integerValueFromHex]/255.0;
	CGFloat green = [[hexString substringWithRange:NSMakeRange(2, 2)] integerValueFromHex]/255.0;
	CGFloat blue = [[hexString substringWithRange:NSMakeRange(4, 2)] integerValueFromHex]/255.0;


	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor*)defaultSystemTintColor
{
	static UIColor* systemTintColor = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		UIView* view = [[UIView alloc] init];
		systemTintColor = view.tintColor;
	});
	return systemTintColor;
}

+ (UIColor *)keyboardBackgroundColor
{
	return [UIColor colorWithHue:0.600 saturation:0.029 brightness:0.887 alpha:1.000];
}

- (BOOL)isWhiteColor
{
	CGFloat white = 0.f;
	CGFloat alpha = 0.f;
	BOOL success = [self getWhite:&white alpha:&alpha];

	if (success &&
		white == 1.0f &&
		alpha == 1.0f)
	{
		return YES;
	}
	return NO;
}

@end
