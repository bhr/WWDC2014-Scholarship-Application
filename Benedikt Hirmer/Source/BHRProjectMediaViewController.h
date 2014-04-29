//
//  BHRProjectMediaViewController.h
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/12/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHRProjectMediaViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *contentView;

/*
 * content is either one video url or an array of image urls
 */
@property (nonatomic, strong) id content;

- (void)startPlayback;
- (void)stopPlayback;

@end
