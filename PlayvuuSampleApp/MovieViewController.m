//
//  MovieViewController.m
//  PlayvuuSampleApp
//
//  Created by Brian Smith on 8/26/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "MovieViewController.h"

@interface MovieViewController ()

- (void) updateDebugLabel;
- (void) updateMovieStatusLabel;

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc
{
    _movieSource = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Playback";
    self.outputView.alpha = 0.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate
{
    return YES;
}

- (void) rotateOutputViewToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGSize parentViewSize = self.view.bounds.size;
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation) != UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        CGRect newFrame = AVMakeRectWithAspectRatioInsideRect(self.outputView.frame.size, CGRectMake(0, 0, parentViewSize.height, parentViewSize.width));
        
        [UIView animateWithDuration:duration animations:^{

            self.outputView.frame = newFrame;

        }];
    }
}


- (void) setupPlayvuuEngine
{
    //
    // create the PlayvuueEngine source : a movie with the given URL
    //

    _movieSource = [[PVMovieSource alloc] initWithURL:self.url];
    _movieSource.movieDelegate = self;
    
    self.playPauseButton.enabled = NO;
    
    //
    // create the playvuu engine and set its parameters
    //
    _playvuuEngine = [[PVEngine alloc] init];
    _playvuuEngine.delegate = self;
    _playvuuEngine.interfaceOrientation = UIInterfaceOrientationPortrait;
    _playvuuEngine.source = _movieSource;
    
    //
    // We have a GPUImageView in the NIB, so we just add that as the output of the Preprocessor stage
    // of the engine.
    //
    [_playvuuEngine addGPUImageView:self.outputView forStage:PlayvuuEngineStagePostprocessor];
    
    //
    // we plan to record the preprocessor output
    //
    //_playvuuEngine.movieWriterStage = PlayvuuEngineStagePreprocessor;
    
    __unsafe_unretained MovieViewController * self_ = self;
    [_playvuuEngine setFrameCompletionBlock:^(CMTime time) {
        
        [self_ updateDebugLabel];
        
    }];
    
    [_playvuuEngine activate];
}

- (void) updateDebugLabel
{
    if (!self.debugLabel.hidden)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSArray * debugArray = _playvuuEngine.debugData;
            self.debugLabel.numberOfLines = [debugArray count] + 2;
            
            self.debugLabel.text = [[debugArray componentsJoinedByString:@"\n"] stringByAppendingFormat:@"\n\nengBuild: %@", _playvuuEngine.buildTimestamp];
            
        });
    }
}

- (IBAction) playpause:(id)sender
{
    if (_movieSource.movieStatus == PlayvuuMovieSourceStatusPlaying)
        [_movieSource pause];
    else
        [_movieSource play];
}

- (void) updateMovieStatusLabel
{
    NSString * status = @"Movie: ";;
    
    switch (_movieSource.movieStatus) {
        case PlayvuuMovieSourceStatusNone:
            status = [status stringByAppendingString:@"Movie not ready"];
            break;
            
        case PlayvuuMovieSourceStatusPlaying:
            status = [status stringByAppendingString:@"Playing"];
            break;
            
        case PlayvuuMovieSourceStatusPaused:
            status = [status stringByAppendingString:@"Paused"];
            break;
            
        case PlayvuuMovieSourceStatusReadyToPlay:
            status = [status stringByAppendingString:@"Ready"];
            break;
            
        case PlayvuuMovieSourceStatusAtEnd:
            status = [status stringByAppendingString:@"At End"];
            break;
            
        case PlayvuuMovieSourceStatusError:
            status = [status stringByAppendingString:@"Error"];
            break;
            
        default:
            break;
    }
    
    float currentTime = (double)_movieSource.currentMovieTime.value / (double)_movieSource.currentMovieTime.timescale;
    float duration = (double)_movieSource.movieDuration.value / (double)_movieSource.movieDuration.timescale;
    
    self.movieStatusLabel.text = [NSString stringWithFormat:@"%@ %0.2fs/%0.2fs", status, currentTime, duration];
}

#pragma mark PVMovieSourceDelegate

- (void) pvMovieSource:(PVMovieSource *)source statusChanged:(PlayvuuMovieSourceStatus)status
{
    if (status == PlayvuuMovieSourceStatusReadyToPlay)
    {
        NSLog(@"movie size = %dx%d", (int)_movieSource.inputSize.width, (int)_movieSource.inputSize.height);
        
        //
        // set the frame of the outputView
        //
        self.outputView.frame = AVMakeRectWithAspectRatioInsideRect(_movieSource.inputSize, self.view.frame);
        [UIView animateWithDuration:0.2f animations:^{
            self.outputView.alpha = 1.f;
        }];
        
        self.playPauseButton.enabled = YES;
    }
    else if (status & PLAYVUUMOVIESOURCE_STATUS_STOPPED)
    {
        [self.playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
        
        if (status == PlayvuuMovieSourceStatusAtEnd)
            [_movieSource seekToTime:kCMTimeZero];
    }
    else if (status & PLAYVUUMOVIESOURCE_STATUS_PLAYING)
    {
        [self.playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
    [self updateMovieStatusLabel];
}

- (void) pvMovieSource:(PVMovieSource *)source timeChanged:(CMTime)time
{
    [self updateMovieStatusLabel];
}


@end
