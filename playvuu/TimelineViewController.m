//
//  TimelineViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 7/31/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "TimelineViewController.h"
#import "ContainerViewController.h"
#import "PVBubbleView.h"
#import "PVVideoCell.h"
#import <Parse/Parse.h>
#import "PVProject.h"

@interface TimelineViewController (){
    ContainerViewController *containerViewController;
}
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userStatusChanged:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (IBAction)showMenu:(id)sender {
        [self.revealViewController revealToggle:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"embedContainer"]){
        containerViewController = segue.destinationViewController;
    }
}

@end
