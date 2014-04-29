//
//  SIKeyboardStateController.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/22/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRKeyboardStateController.h"

@interface BHRKeyboardStateController ()

@property (nonatomic, strong) NSLayoutConstraint *constraint;

@end

@implementation BHRKeyboardStateController

- (instancetype)initWithConstraint:(NSLayoutConstraint *)constraint
{
    self = [super init];
    if (self)
	{
		_constraint = constraint;
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillShow:)
													 name:UIKeyboardWillShowNotification
												   object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillHide:)
													 name:UIKeyboardWillHideNotification
												   object:nil];

    }
    return self;
}


- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Keyboard Show/Hide

- (void)keyboardWillShow:(NSNotification *)notification
{
	NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
	
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
    CGFloat height = isPortrait ? keyboardFrame.size.height : keyboardFrame.size.width;

//    DDLogVerbose(@"The keyboard height is: %f", height);
//    DDLogVerbose(@"Updating constraints.");
    // Because the "space" is actually the difference between the bottom lines of the 2 views,
    // we need to set a negative constant value here.
    self.constraint.constant = height;
	
    // Update the layout before rotating to address the following issue.
    // https://github.com/ghawkgu/keyboard-sensitive-layout/issues/1
//    if (self.currentOrientation != orientation) {
//        [self.view layoutIfNeeded];
//    }
    
    [UIView animateWithDuration:animationDuration animations:^
	{
        [[self superview] layoutIfNeeded];
    }];
}


- (void)keyboardWillHide:(NSNotification *)notification
{
	NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
    self.constraint.constant = 0.0f;
    [UIView animateWithDuration:animationDuration animations:^{
        [[self superview] layoutIfNeeded];
    }];
}

- (UIView *)superview
{
	if ([[self.constraint firstItem] superview] == [self.constraint secondItem]) {
		[self.constraint secondItem];
	}
	return [self.constraint firstItem];
}

@end
