//
//  LibraryViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 9/1/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface PVLibraryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *videoLayer;


- (IBAction)showMenu:(id)sender;
- (IBAction)toggleContent:(id)sender;

@end
