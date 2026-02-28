//
//  TimelineViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 7/31/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface TimelineViewController : UIViewController<UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *userStatus;
- (IBAction)userStatusChanged:(UITextField *)sender;
- (IBAction)showMenu:(id)sender;


@end
