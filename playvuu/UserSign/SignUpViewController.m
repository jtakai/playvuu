//
//  SignUpViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/11/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"
#import "PVUser.h"

#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface SignUpViewController ()
{
    PVUser *user;
    enum {
        EMAIL = 0,
        PASSWORD = 1,
        PASSCONFIRM = 2
    };
}
@end

@implementation SignUpViewController

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
    user = [PVUser object];
    user.userData = [PVUserData object];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


NSString *password; // For password confirmation check
- (IBAction)fieldAction:(UITextField *)sender{
    [sender resignFirstResponder];
    switch(sender.tag){
        case EMAIL:
            [user setEmailFields:sender.text];
            //[_passwordField becomeFirstResponder];
            break;
        case PASSWORD:
            [user setPassword:[sender text]];
            //[_passConfirmField becomeFirstResponder];
            break;
        case PASSCONFIRM:
        default:
            break;
    }
    
    BOOL okSignUp = NO;
    
    if([_passwordField.text isEqualToString:_passConfirmField.text])
        _errorLabel.text = @"Passwords do not match!";
    else if(_passwordField.text.length == 0)
        _errorLabel.text = @"Passwords empty!";
    else{
        _errorLabel.text = @"";
        okSignUp = YES;
    }
    
    [_signUpButton setEnabled:YES];
    
}

-(PVUserData *)getData{
    return user.userData;
}

-(void) saveData:(PVUserData *)userData{
    user.userData = userData;
    [_signUpButton setEnabled:NO];
    [_spinner startAnimating];
    
    // Go for it
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"Signed up %@ (%@) %@", user.email, user.username, user.userData.email);
            [self dismissViewControllerAnimated:YES completion:^{}];
        }else{
            NSLog(@"Sign up error: %@", error);
            [_signUpButton setEnabled:YES];
            [_spinner stopAnimating];
            _errorLabel.text = [error localizedDescription];
        }
    }];
}

-(IBAction)goSignUp{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AccountInfoViewController *aivc = (AccountInfoViewController *)[main instantiateViewControllerWithIdentifier:@"AccountInfo"];
    [aivc setDelegate:self];
    [self presentViewController:aivc animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = [segue destinationViewController];
    if([vc isMemberOfClass:[AccountInfoViewController class]])
        [(AccountInfoViewController *)vc setDelegate:self];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
