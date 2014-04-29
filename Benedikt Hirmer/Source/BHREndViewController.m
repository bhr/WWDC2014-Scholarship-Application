//
//  BHREndViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/14/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHREndViewController.h"

@interface BHREndViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notSureLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notSureBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *letsMeetWidthConstraint;

@property (weak, nonatomic) IBOutlet BHRColorHighlightButton *notSureButton;
@property (weak, nonatomic) IBOutlet BHRColorHighlightButton *letsMeetButton;
@property (weak, nonatomic) IBOutlet UIImageView *wwdcLogoView;

@property (nonatomic, assign) BOOL pressedNopeButton;

@end

@implementation BHREndViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(deviceOrientationDidChange:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
}

- (IBAction)nope:(id)sender
{
	self.pressedNopeButton = YES;
	[self _updateNotSureButtonPosition];
}

- (IBAction)letsMeet:(id)sender
{
	if (![MFMailComposeViewController canSendMail])
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"THANK YOU"
															message:@"See you soon :)"
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		[alertView show];
		return;
	}

	MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
	mailComposer.mailComposeDelegate = self;
	[mailComposer setToRecipients:@[@"benedikt@hirmer.me"]];
	[mailComposer setSubject:@"Let's meet at WWDC 2014"];
	[mailComposer setMessageBody:@"Hi Ben,\n\nWe'd like to invite you to this years WWDC. We think you'll be excited as we are.\n\nSee you there,\n" isHTML:NO];

	[self presentViewController:mailComposer animated:YES completion:nil];
}

- (void)_updateNotSureButtonPosition
{
	CGFloat newLeading;
	CGFloat newTop;
	BOOL isValidPoint;
	do
	{
		newLeading = arc4random() % (NSInteger)CGRectGetWidth(self.view.bounds);
		newTop = arc4random() % (NSInteger)CGRectGetHeight(self.view.bounds);

		isValidPoint = [self _isValidRandomRect:CGRectMake(newLeading,
														   newTop,
														   CGRectGetWidth(self.notSureButton.bounds),
														   CGRectGetHeight(self.notSureButton.bounds))];
	}

	while (!isValidPoint);

	CGFloat newBottom = CGRectGetHeight(self.view.bounds) - (newTop + CGRectGetHeight(self.notSureButton.bounds));

	[self.view layoutIfNeeded];

	[UIView animateWithDuration:0.5f
					 animations:^{
						 self.notSureLeadingConstraint.constant = newLeading;
						 self.notSureBottomConstraint.constant = newBottom;
						 [self.view layoutIfNeeded];
					 }];
}

- (BOOL)_isValidRandomRect:(CGRect)rect
{
	if (!CGRectContainsRect(self.view.bounds, rect)) {
		return NO;
	}

	for (UIView *subview in [self.view subviews])
	{
		if (subview == self.notSureButton ||
			subview == self.overlayView ||
			subview == self.wwdcLogoView) {
			continue;
		}

		if (CGRectIntersectsRect(rect, subview.frame)) {
			return NO;
		}
	}

	return YES;
}

#pragma mark - BHRColorHighlightButtonDelegate

- (void)colorHighlightButtonDidTouchUpInside:(BHRColorHighlightButton *)colorHighlightButton
{
	if (colorHighlightButton == self.letsMeetButton) {
		[self letsMeet:colorHighlightButton];
	}
}

- (void)colorHighlightButtonDidTouchDownInside:(BHRColorHighlightButton *)colorHighlightButton
{
	if (colorHighlightButton == self.notSureButton) {
		[self nope:colorHighlightButton];
	}
}

#pragma mark - Mail Compose Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Rotation

- (void)deviceOrientationDidChange:(NSNotificationCenter *)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	[self _updateConstraintsForOrientation:(UIInterfaceOrientation)orientation];
}


- (void)_updateConstraintsForOrientation:(UIInterfaceOrientation)orientation
{
	self.letsMeetWidthConstraint.constant = CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.notSureButton.bounds) - 60.0f;

	if (self.pressedNopeButton) {
		[self _updateNotSureButtonPosition];
	}

	NSString *wwdcImageName = @"wwdc2014";
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		wwdcImageName = @"wwdc2014-landscape";
	}

	self.wwdcLogoView.image = [UIImage imageNamed:wwdcImageName];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	[self _updateConstraintsForOrientation:interfaceOrientation];
}

@end
