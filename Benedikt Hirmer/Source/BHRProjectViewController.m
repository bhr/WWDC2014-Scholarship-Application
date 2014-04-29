//
//  BHRProjectViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/11/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRProjectViewController.h"
#import "BHRProjectItem.h"
#import "BHRiPhoneProjectViewController.h"
#import "BHRMacProjectViewController.h"
#import "BHRiPadProjectLandscapeViewController.h"
#import "BHRiPadProjectPortraitViewController.h"
#import "BHRProjectMediaViewController.h"

@interface BHRProjectViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong, nonatomic) BHRProjectMediaViewController *projectMediaViewController;

@property (strong, nonatomic) NSArray *customConstraints;

@end

@implementation BHRProjectViewController

- (instancetype)init
{
    self = [super initWithNibName:NSStringFromClass([BHRProjectViewController class])
						   bundle:nil];
    if (self)
	{

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(deviceOrientationDidChange:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];


	[self _updateContent];

	self.textContainerView.backgroundColor = [UIColor clearColor];
	[self _updateTextColor];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}


#pragma mark - Public

- (void)scrollWithRelativeOffset:(CGFloat)relativeOffset
{
	CGFloat scaleDamping = 7.0f;
	CGFloat layerTransfromOffset = (1.0f - fabs(relativeOffset) / scaleDamping);

	[self _applyScrollScaleEffectToView:self.projectMediaViewController.view offset:layerTransfromOffset];
	[self _applyScrollTranslateEffectToView:self.titleContainerView offset:relativeOffset];
}

- (void)_applyScrollScaleEffectToView:(UIView *)view offset:(CGFloat)offset
{
	view.layer.transform = CATransform3DMakeScale(offset, offset, 1.0f);
}

- (void)_applyScrollTranslateEffectToView:(UIView *)view offset:(CGFloat)offset
{
	CATransform3D offsetTransform = CATransform3DMakeTranslation(offset * CGRectGetWidth(view.frame),
																 0.0f,
																 0.0f);

	view.layer.transform = offsetTransform;
}

- (void)_resetTranslateEffects
{
	self.projectMediaViewController.view.layer.transform = CATransform3DIdentity;
	self.titleContainerView.layer.transform = CATransform3DIdentity;
}

#pragma mark -

- (void)setItem:(BHRSinglePageProjectItem *)item
{
	if (item != _item)
	{
		_item = item;
		[self _updateContent];
	}
}

- (void)_updateContent
{
	self.iconView.image = self.item.icon;
	self.descriptionTextView.text = self.item.description;
	self.projectLabel.text = [self.item.title uppercaseString];
	self.subTitleLabel.text = self.item.subTitle;
}

#pragma mark - Constraints

- (void)deviceOrientationDidChange:(NSNotificationCenter *)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	[self _updateConstraintsForOrientation:(UIInterfaceOrientation)orientation];
}

- (void)_updateConstraintsForOrientation:(UIInterfaceOrientation)orientation
{
	[self _resetTranslateEffects];
	
	if (self.customConstraints)
	{
		[self.view removeConstraints:self.customConstraints];
	}

	NSArray *newConstraints = nil;

	if (UIInterfaceOrientationIsPortrait(orientation)) {
		newConstraints = [self portraitConstraints];
	} else {
		newConstraints = [self landscapeConstraints];
	}

	[self.view addConstraints:newConstraints];

	self.customConstraints = newConstraints;
}

- (NSArray *)portraitConstraints
{
	return @[];
}

- (NSArray *)landscapeConstraints
{
	return @[];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
								duration:(NSTimeInterval)duration
{
	[self _updateConstraintsForOrientation:toInterfaceOrientation];
}


- (BHRProjectMediaViewController *)projectMediaViewController
{
	if (!_projectMediaViewController)
	{
		Class mediaViewControllerClass = [self mediaVewControllerClass];
		BHRProjectMediaViewController *iPhoneMediaViewController = [[mediaViewControllerClass alloc] init];
		iPhoneMediaViewController.view.translatesAutoresizingMaskIntoConstraints = NO;

		iPhoneMediaViewController.content = [self.item videoURL];

		[self addChildViewController:iPhoneMediaViewController];
		[self.view addSubview:iPhoneMediaViewController.view];

		_projectMediaViewController = iPhoneMediaViewController;
	}

	return _projectMediaViewController;
}

- (void)setIsCurrentPage:(BOOL)isCurrentPage
{
	if (_isCurrentPage != isCurrentPage)
	{
		_isCurrentPage = isCurrentPage;

		if (isCurrentPage) {
			[self.projectMediaViewController startPlayback];
		}
		else {
			[self.projectMediaViewController stopPlayback];
		}
	}
}

+ (Class)classForType:(BHRProjectType)type
{
	switch (type) {
		case BHRProjectTypeMac:
			return [BHRMacProjectViewController class];
			break;
		case BHRProjectTypeiPhone:
			return [BHRiPhoneProjectViewController class];
			break;
		case BHRProjectTypeiPadLandscape:
			return [BHRiPadProjectLandscapeViewController class];
			break;
		case BHRProjectTypeiPadPortrait:
			return [BHRiPadProjectPortraitViewController class];
		default:
			return nil;
			break;
	}
}

- (Class)mediaVewControllerClass
{
	return nil;
}

- (void)_updateTextColor
{
	UIColor *backgroundColor = [self.item backgroundColor];
	CGFloat brightness = 1.0f;

	[backgroundColor getHue:nil saturation:nil brightness:&brightness alpha:nil];

	UIColor *textColor = [UIColor whiteColor];
	UIColor *linkTextColor = [UIColor colorWithWhite:0.8f alpha:1.0f];

	if (brightness > 0.5f)
	{
		textColor = [UIColor blackColor];
		linkTextColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
	}

	self.projectLabel.textColor = textColor;
	self.subTitleLabel.textColor = textColor;
	self.descriptionTextView.textColor = textColor;
	self.descriptionTextView.tintColor = linkTextColor;
}

@end
