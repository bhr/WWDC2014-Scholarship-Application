//
//  BHRProjectMediaViewController.m
//  Benedikt Hirmer
//
//  Created by Benedikt Hirmer on 4/12/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRProjectMediaViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface BHRProjectMediaViewController ()

@property (nonatomic, strong) UIScrollView *screenShotsScrollView;
@property (nonatomic, strong) MPMoviePlayerController* player;

@property (nonatomic, strong) NSURL *videoURL;
@end

@implementation BHRProjectMediaViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
						   bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.contentView.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setContent:(id)content
{
	if (content != _content)
	{
		_content = content;

		if ([content isKindOfClass:[NSURL class]])
		{
			_videoURL = (NSURL *)content;
			[self prepareVideoPlayer];
		}
	}
}


- (void)prepareVideoPlayer
{
	self.player = [[MPMoviePlayerController alloc] initWithContentURL:self.videoURL];
	[self.player setControlStyle:MPMovieControlStyleEmbedded];



	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(playbackDidFinish:)
												 name:MPMoviePlayerPlaybackDidFinishNotification
											   object:self.player];


	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(playerLoadStateDidChange:)
												 name:MPMoviePlayerLoadStateDidChangeNotification
											   object:self.player];

	[self.player prepareToPlay];
}




-(void) playbackDidFinish:(NSNotification*)notification
{
	if (notification.object != self.player) {
		return;
	}

	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:self.player];
}

-(void) playerLoadStateDidChange:(NSNotification*)notification
{
	if (notification.object != self.player) {
		return;
	}

	if ([self.player loadState] == MPMovieLoadStateUnknown) {
		return;
	}

	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerLoadStateDidChangeNotification
												  object:self.player];

	[self.player.view setFrame: self.contentView.bounds];
	[self.contentView addSubview: self.player.view];

	[self.player play];
}


- (void)startPlayback
{
	if (self.player.isPreparedToPlay) {
		[self.player play];
		return;
	}

	[self prepareVideoPlayer];
}

- (void)stopPlayback
{
	[self.player stop];
	self.player = nil;
}

@end
