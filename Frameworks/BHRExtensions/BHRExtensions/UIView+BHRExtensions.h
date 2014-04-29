//
//  UIView+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 2/27/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageEffects.h"

@interface UIView (BHRExtensions)

-(UIImage *)blurredSnapshotWithEffect:(UIImageBlurEffect)effect;
- (UIImage *)blurredSnapshot;
- (UIImage *)snapshot;

- (void)insertConstraintBasedSubview:(UIView *)view belowSubView:(UIView *)otherView;
- (void)insertConstraintBasedSubview:(UIView *)view aboveSubView:(UIView *)otherView;
- (void)addConstraintBasedSubview:(UIView *)view;
- (void)addConstraintBasedSubview:(UIView *)view withInsets:(UIEdgeInsets)insets;

- (BOOL)findAndResignFirstResponder;

@end
