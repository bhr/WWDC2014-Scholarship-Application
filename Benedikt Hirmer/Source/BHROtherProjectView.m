//
//  BHROtherProjectView.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHROtherProjectView.h"
#import "BHROtherProjectItem.h"

@interface BHROtherProjectView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *yearLabel;

@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) NSLayoutConstraint *typeImageWidthConstraint;
@end

@implementation BHROtherProjectView

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
	self.translatesAutoresizingMaskIntoConstraints = NO;
	[self _createAndSetupViews];
}

- (void)_createAndSetupViews
{
	UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	UIImageView *typeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
	typeImageView.contentMode = UIViewContentModeScaleAspectFit;


	iconView.translatesAutoresizingMaskIntoConstraints = NO;
	titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
	yearLabel.translatesAutoresizingMaskIntoConstraints = NO;
	typeImageView.translatesAutoresizingMaskIntoConstraints = NO;

	[self addSubview:iconView];
	[self addSubview:titleLabel];
	[self addSubview:subTitleLabel];
	[self addSubview:descriptionLabel];
	[self addSubview:yearLabel];
	[self addSubview:typeImageView];

	titleLabel.numberOfLines = 0;
	subTitleLabel.numberOfLines = 0;
	descriptionLabel.numberOfLines = 0;
	yearLabel.numberOfLines = 0;
	yearLabel.textAlignment = NSTextAlignmentLeft;

	titleLabel.font = [self _projectViewFontWithSize:24.0f];
	subTitleLabel.font = [self _projectViewFontWithSize:14.0f];
	descriptionLabel.font = [self _projectViewFontWithSize:14.0f];
	yearLabel.font = [self _projectViewFontWithSize:11.0f];
	yearLabel.adjustsFontSizeToFitWidth = YES;

	NSDictionary *viewsDict = NSDictionaryOfVariableBindings(iconView, titleLabel, subTitleLabel, descriptionLabel, yearLabel, typeImageView);

	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[iconView(==80)]-20-[titleLabel]|"
																 options:NSLayoutFormatAlignAllTop
																 metrics:nil
																   views:viewsDict]];

	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[iconView(==80)]-8-[typeImageView]-(>=0)-|"
																 options:NSLayoutFormatAlignAllTrailing
																 metrics:nil
																   views:viewsDict]];

	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]-8-[subTitleLabel]-8-[descriptionLabel]-(>=8)-|"
																 options:NSLayoutFormatAlignAllTrailing | NSLayoutFormatAlignAllLeading
																 metrics:nil
																   views:viewsDict]];

	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[yearLabel]-(>=4)-[typeImageView]"
																 options:NSLayoutFormatAlignAllCenterY
																 metrics:nil
																   views:viewsDict]];
	self.typeImageView = typeImageView;
	self.iconView = iconView;
	self.titleLabel = titleLabel;
	self.subTitleLabel = subTitleLabel;
	self.descriptionLabel = descriptionLabel;
	self.yearLabel = yearLabel;
}

- (UIFont *)_projectViewFontWithSize:(CGFloat)size
{
	return [UIFont fontWithName:@"Helvetica-Light" size:size];
}

- (void)setItem:(BHROtherProjectItem *)item
{
	if (item != _item)
	{
		_item = item;

		self.iconView.image = item.icon;
		self.titleLabel.text = item.title;
		self.subTitleLabel.text = item.subTitle;
		self.descriptionLabel.text = item.description;
		self.yearLabel.text = item.years;
		self.typeImageView.image = [self _typeImage];

		self.typeImageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.typeImageView
																	 attribute:NSLayoutAttributeWidth
																	 relatedBy:NSLayoutRelationEqual
																		toItem:nil
																	 attribute:NSLayoutAttributeNotAnAttribute
																	multiplier:1.0f
																	  constant:self.typeImageView.image.size.width];
		[self addConstraint:self.typeImageWidthConstraint];
	}
}

- (UIImage *)_typeImage
{
	switch (self.item.type) {
		case BHRProjectTypeMac:
			return [UIImage imageNamed:@"outlineMac"];
			break;
		case BHRProjectTypeiPhone:
			return [UIImage imageNamed:@"outlineiPhone"];
			break;
		case BHRProjectTypeiPadLandscape:
			return [UIImage imageNamed:@"outlineiPad"];
			break;

		case BHRProjectTypeiPadPortrait:
			return [UIImage imageNamed:@"outlineiPad"];
			break;

		default:
			return nil;
			break;
	}
}

@end
