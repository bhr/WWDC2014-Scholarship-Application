//
//  BHRRootItemViewController.h
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/14/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHRRootItemViewController : UIViewController

@property (nonatomic, assign, readonly) BOOL isInFocus;
@property (nonatomic, strong) UIView *overlayView;

- (void)bhr_rootSubviewDidAppear;
- (void)bhr_rootSubviewDidDisappear;

- (void)updateScrollEffectWithRelativeOffset:(CGFloat)relativeOffset
						 viewControllerIndex:(NSUInteger)idx
							   isCurrentPage:(BOOL)isCurrentPage;

@end
