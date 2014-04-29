//
//  BHRProjectViewController.h
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/11/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHRSinglePageProjectItem.h"

@protocol BHRProjectViewControllerDelegate;
@class BHRProjectMediaViewController;

@interface BHRProjectViewController : UIViewController

@property (nonatomic, strong) BHRSinglePageProjectItem *item;
@property (nonatomic, assign) BOOL isCurrentPage;

- (void)scrollWithRelativeOffset:(CGFloat)relativeOffset;

@property (weak, nonatomic) IBOutlet UIView *textContainerView;
@property (weak, nonatomic) IBOutlet UIView *titleContainerView;

@property (strong, nonatomic, readonly) BHRProjectMediaViewController *projectMediaViewController;

+ (Class)classForType:(BHRProjectType)type;

/**
 * For Subclasses
 */
- (NSArray *)portraitConstraints;
- (NSArray *)landscapeConstraints;
- (Class)mediaVewControllerClass;

@end