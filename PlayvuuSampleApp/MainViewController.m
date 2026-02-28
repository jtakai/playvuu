//
//  MainViewController.m
//  PlayvuuSampleApp
//
//  Created by Brian Smith on 8/23/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#import "MainViewController.h"
#import "CaptureViewController.h"
#import "ChooseMovieViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Main";
}

- (BOOL) shouldAutorotate
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0];

    NSArray * files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:nil];
    
    self.playbackButton.enabled = [files count] > 0;
}

- (IBAction) showCamera:(id)sender
{
    CaptureViewController * vc = [[CaptureViewController alloc] initWithNibName:@"CaptureView" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction) showPrerecorded:(id)sender
{
    ChooseMovieViewController * vc = [[ChooseMovieViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
