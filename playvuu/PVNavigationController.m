//
//  PVMainNavigationController.m
//  playvuu
//
//  Created by Ariel Elkin on 21/08/2013.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVNavigationController.h"
#import "UIViewController+Utils.h"
#import "PVUser.h"

@interface PVNavigationController ()

@end

@implementation PVNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark Orientation

//see:
//http://stackoverflow.com/a/12528444/1072846
- (BOOL)shouldAutorotate
{
    //return [self.topViewController shouldAutorotate];
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
