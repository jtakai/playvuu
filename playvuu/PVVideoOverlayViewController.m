//
//  PVVideoOverlayViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/19/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVVideoOverlayViewController.h"
#import "PVBubbleView.h"
#import <MediaPlayer/MPMoviePlayerController.h>

@interface PVVideoOverlayViewController ()
@property (weak, nonatomic) IBOutlet PVBubbleView *bubbleView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *playerContainer;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) MPMoviePlayerController* moviePlayer;
- (IBAction)exit:(id)sender;
@end

@implementation PVVideoOverlayViewController

-(void) awakeFromNib {
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.font = [UIFont proximaNovaSemiBoldFontWithSize:22];
    self.titleLabel.text = self.project.title;
    
    [self.bubbleView setSlideShow:self.project.slideTexture];
    
    self.dateLabel.font = [UIFont proximaNovaRegularWithSize:17];
    //self.dateLabel.text = self.project.createdAt;
    
    self.descriptionTitleLabel.font = [UIFont proximaNovaSemiBoldFontWithSize:24];
    self.descriptionLabel.font = [UIFont proximaNovaSemiBoldFontWithSize:16];
    //self.descriptionLabel.text = self.project.description;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testvideopvuu" ofType:@"mov"];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
    [self.moviePlayer.view setFrame:self.playerContainer.bounds];
    [self.moviePlayer play];
    [self.playerContainer addSubview:self.moviePlayer.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exit:(id)sender {
    [self.view removeFromSuperview];
    //[self removeFromParentViewController];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
@end
