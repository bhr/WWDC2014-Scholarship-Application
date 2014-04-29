//
//  NSString+BHExtensions.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 27.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "NSString+BHRExtensions.h"

@implementation NSString (BHRExtensions)

- (NSString *)stringByDissolvingCamelCase
{
	NSRegularExpression *regexp;
	NSString *newString;
	
	regexp = [NSRegularExpression regularExpressionWithPattern:@"([a-z])([A-Z])"
													   options:0
														 error:NULL];
	
	newString = [regexp stringByReplacingMatchesInString:self
												 options:0
												   range:NSMakeRange(0, self.length)
											withTemplate:@"$1 $2"];
	
	return newString;
}

- (BOOL)startsWith:(NSString *)string
{
	NSRange foundRange;
	NSRange searchRange;
	
	searchRange = NSMakeRange(0, [string length]);
	foundRange = [self rangeOfString:string
							 options:NSCaseInsensitiveSearch
							   range:searchRange];
	
	if (foundRange.location == NSNotFound) {
		return NO;
	}
	
	return YES;
}


-(float)scaleToAspectFit:(CGSize)source
					into:(CGSize)into
				 padding:(float)padding
{
    return MIN((into.width-padding) / source.width, (into.height-padding) / source.height);
}


- (CGFloat)fontSizeForSize:(CGSize)size
					  font:(UIFont *)font
{
	CGSize sampleSize;

	if (font == nil) {
		font = [UIFont systemFontOfSize:16.0f];
	}
	
    sampleSize = [self sizeWithAttributes:@{NSFontAttributeName: font}];
	
    float scale = [self scaleToAspectFit:sampleSize
									into:size
								 padding:1];
    return (scale * font.pointSize);
}


#pragma mark Trimming Methods

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet
{
    NSRange rangeOfFirstWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]];
    if (rangeOfFirstWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringFromIndex:rangeOfFirstWantedCharacter.location];
}

- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters
{
    return [self stringByTrimmingLeadingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet
{
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringToIndex:rangeOfLastWantedCharacter.location+1]; // non-inclusive
}

- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters
{
    return [self stringByTrimmingTrailingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


#pragma mark - Conversion

- (NSUInteger)integerValueFromHex;
{
	unsigned int hexInt = 0;

	// Create scanner
	NSScanner *scanner = [NSScanner scannerWithString:self];

	// Tell scanner to skip the # character
	[scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];

	// Scan hex value
	[scanner scanHexInt:&hexInt];

	return hexInt;
}

@end
