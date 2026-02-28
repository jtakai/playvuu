//
//  MainViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 7/31/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountInfoViewController.h"

@interface MenuViewController : UIViewController <AccountInfoViewControllerDelegate>

- (IBAction)logOutAction:(id)sender;

@end
