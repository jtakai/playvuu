//
//  SplashViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 7/24/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "SignInViewController.h"
#import "AccountInfoViewController.h"
#import "PVUser.h"
#import "PVStatusVars.h"

#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface SignInViewController ()

@end

@implementation SignInViewController

@synthesize errorLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    if([[PVUser currentUser] isAuthenticated]){
        [self.navigationController dismissViewControllerAnimated:YES completion:^(void){}];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
    
    if([[PVUser currentUser] isAuthenticated])
       [PVStatusVars refreshUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSpinner:nil];
    [self setErrorLabel:nil];
    [super viewDidUnload];
}

- (void)stopSpinning
{
    [self.spinner stopAnimating];
}


- (void)startSpinning
{
    [self.spinner setHidden:NO];
    [self.spinner startAnimating];
}

- (IBAction)twitter:(id)sender {
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        [self stopSpinning];
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else {
            if (user.isNew){
                NSLog(@"User signed up and logged in with Twitter!");
                PVUser *current = [PVUser currentUser];
                current.userData = [PVUserData object];
                [current saveInBackground];
            }else
                NSLog(@"User logged in with Twitter!");
            
            [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
        }
    }];
    [self startSpinning];
}

- (IBAction)facebook:(id)sender {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [self stopSpinning]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else{
            
            if (user.isNew){
                NSLog(@"User with facebook signed up and logged in!");
                PVUser *current = [PVUser currentUser];
                [PVUserData saveWithFacebookUser:current];
            }
            else
                NSLog(@"User with facebook logged in!");
            
            [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
        }
    }];
    
    [self startSpinning]; // Show loading indicator until login is finished
}
@end
