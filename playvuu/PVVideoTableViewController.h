//
//  PVVideoTableViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 9/7/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <Parse/Parse.h>

@interface PVVideoTableViewController : PFQueryTableViewController
@property (strong) PFQuery *query;
@end
