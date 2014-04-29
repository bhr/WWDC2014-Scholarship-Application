//
//  BHRColorHighlightButton.h
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/14/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BHRColorHighlightButtonDelegate;

@interface BHRColorHighlightButton : UIButton

@property (nonatomic, weak) IBOutlet id<BHRColorHighlightButtonDelegate> delegate;

@end


@protocol BHRColorHighlightButtonDelegate <NSObject>

- (void)colorHighlightButtonDidTouchUpInside:(BHRColorHighlightButton *)colorHighlightButton;
- (void)colorHighlightButtonDidTouchDownInside:(BHRColorHighlightButton *)colorHighlightButton;

@end
