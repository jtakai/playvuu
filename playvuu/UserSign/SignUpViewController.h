//
//  SignUpViewController.h
//  playvuu
//
//  Created by Nicolas Estecha on 7/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountInfoViewController.h"

@interface SignUpViewController : UIViewController<AccountInfoViewControllerDelegate>;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic)UITextField *phonenumberField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
- (IBAction)fieldAction:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *passConfirmField;
- (IBAction)cancel:(id)sender;
@end

