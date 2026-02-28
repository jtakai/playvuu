//
//  PVLibraryTableViewController.h
//  playvuu
//
//  Created by Ariel Groesman on 9/18/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <Parse/Parse.h>

@interface PVLibraryTableViewController : PFQueryTableViewController
@property (strong) PFQuery *query;
@end
