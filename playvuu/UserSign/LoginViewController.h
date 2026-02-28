//
//  ViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 7/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
- (IBAction)fieldAction:(UITextField *)sender;
- (IBAction)buttonAction:(UIButton *)sender;
- (IBAction)userLogin:(UITextField *)sender;
- (IBAction)userSignUp:(UIButton *)sender;
- (IBAction)cancel:(id)sender;
@end

