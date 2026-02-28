//
//  MovieViewController.h
//  PlayvuuSampleApp
//
//  Created by Brian Smith on 8/26/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#import "CaptureViewController.h"


@interface MovieViewController : CaptureViewController<PVMovieSourceDelegate>
{
    PVMovieSource * _movieSource;
}

@property (nonatomic,strong) NSURL * url;

@property (nonatomic,weak) IBOutlet UIButton * playPauseButton;
@property (nonatomic,weak) IBOutlet UILabel * movieStatusLabel;

- (IBAction) playpause:(id)sender;


@end
