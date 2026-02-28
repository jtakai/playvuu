//
//  ProfileViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 7/31/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
#import "JCGridMenuController.h"

@interface ProfileViewController : UIViewController <JCGridMenuControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userStatus;
- (IBAction)userStatusChanged:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;
- (IBAction)showMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundImage;

@property (nonatomic, strong) JCGridMenuController *gmDemo;

@end
