//
//  MainViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 7/31/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "MenuViewController.h"
#import "SignInViewController.h"
#import "ShuffleViewController.h"
#import "SWRevealViewController.h"
#import "PVUser.h"
#import "TestFlight.h"
#import "SocializerViewController.h"
#import "PVLibraryViewController.h"
#import "UIViewController+Utils.h"

#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface MenuViewController (){
    PVUser *user;
}

- (IBAction)socializerButtonPressed:(UIButton*)sender;
- (IBAction)libraryButtonPressed:(UIButton*)sender;
- (IBAction)captureButtonPressed:(UIButton *)sender;
@end

@implementation MenuViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if([[PVUser currentUser] isMemberOfClass:[PVUser class]]){
        user = [PVUser currentUser];
        NSLog(@"Soy miembro!");
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutAction:(id)sender {
    [PVUser logOut];
    [self presentUserSign];
    //[self performSegueWithIdentifier:@"showLogin" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = [segue destinationViewController];
    if([vc isMemberOfClass:[AccountInfoViewController class]]){
        [user.userData fetchIfNeeded];
        [(AccountInfoViewController *)vc setDelegate:self];
    }

    // Deprecated. We're moving to not-this-shit
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
    {
        SWRevealViewControllerSegue* rvcs = (SWRevealViewControllerSegue*) segue;
        
        SWRevealViewController* rvc = self.revealViewController;
        
        NSAssert( rvc != nil, @"oops! must have a revealViewController" );
        NSAssert( [rvc.frontViewController isKindOfClass: [UINavigationController class]], @"oops!  for this segue we want a permanent navigation controller in the front!" );

        rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {

            UINavigationController* navController = (UINavigationController*)rvc.frontViewController;
            
            [navController setViewControllers: @[dvc] animated: NO ];
            [rvc _dispatchSetFrontViewController:navController animated:YES];
        };
    }
    
 }

-(PVUserData *)getData{
    return user.userData;
}

-(void) saveData:(PVUserData *)userData{
    [userData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"User data saved!");
        }else if(error){
            NSLog(@"%@", error);
        }
    }];
}

-(IBAction)socializerButtonPressed:(id)sender {
    [self presentStoryBoard:@"Socializer"];
}

- (IBAction)libraryButtonPressed:(id)sender{
    [self presentStoryBoard:@"Library"];
}

- (IBAction)captureButtonPressed:(UIButton *)sender {
    [self presentStoryBoard:@"Capture"];
}

@end
