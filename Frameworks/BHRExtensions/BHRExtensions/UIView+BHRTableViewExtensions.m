//
//  UIView+SIExtensions.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 2/23/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIView+BHRTableViewExtensions.h"

@implementation UIView (BHRTableViewExtensions)

- (UITableViewCell *)tableViewCell
{
	UIView *superview = self.superview;
	
	if (superview == nil) {
		return nil;
	}
	
	if ([superview isKindOfClass:[UITableViewCell class]]) {
		return (UITableViewCell *)superview;
	}
	
	return [superview tableViewCell];
}

@end
