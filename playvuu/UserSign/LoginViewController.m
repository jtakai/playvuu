//
//  ViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 7/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "PVUser.h"
#import "PVStatusVars.h"

#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface LoginViewController ()
{
    enum {
        EMAIL = 0,
        PASSWORD = 1
    };
}

@end

@implementation LoginViewController

- (IBAction)fieldAction:(UITextField *)sender {
    switch (sender.tag) {
        case EMAIL:
            //[user setEmail:[sender text]];
            [_passwordField becomeFirstResponder];
            break;
        case PASSWORD:
            //[user setPassword:[sender text]];
            [self userLogin:sender];
            
        default:
            break;
    }
    
    /* Maybe we should perform validation here.
     Probably not, as most login selectors will validate themselves. */
    [_errorLabel setText:@""];
    
}

//  wipe fields
- (void)viewWillAppear:(BOOL)animated
{
    if([[PVUser currentUser] isAuthenticated])
        [self dismissViewControllerAnimated:NO completion:^{}];
    
    [_emailField setText:@""];
    [_passwordField setText:@""];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    user = [PFUser object];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    // Clean up field outlets.
    
    [self setEmailField:nil];
    [self setPasswordField:nil];
    [self setErrorLabel:nil];
    [self setSpinner:nil];
    [self setSignUpButton:nil];
    [super viewDidUnload];
}

- (IBAction)userLogin:(UITextField *)sender {
    [self.spinner startAnimating];
    [PVUser logInWithUsernameInBackground:[_emailField text] password:[_passwordField text] block:^(PFUser *user, NSError *error) {
        if(user != nil){
            NSLog(@"User %@ logged in", [user username]);
            PVUser *pvuser = (PVUser *)user;
            [pvuser.userData fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {}];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
            //[self.parentViewController.parentViewController.parentViewController dismissViewControllerAnimated:YES completion:nil];
        }else
            NSLog(@"%@", [error localizedDescription]);
        [self.spinner stopAnimating];
    }];
}

- (void)stopSpinning
{
    [self.emailField setEnabled:YES];
    [self.passwordField setEnabled:YES];
    [self.signUpButton setEnabled:YES];
    [self.spinner stopAnimating];
}


- (void)startSpinning
{
    [self.emailField setEnabled:NO];
    [self.passwordField setEnabled:NO];
    [self.spinner setHidden:NO];
    [self.spinner startAnimating];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
