//
//  SocializerViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/13/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "SocializerViewController.h"
#import "SWRevealViewController.h"
#import "BubbleViewController.h"
#import "PVUser.h"
#import "PVProject.h"
#import "TestFlight.h"
#import "PVVideoCell.h"
#import "PVContainerSwitcherController.h"
#import "PVSocializerTableViewController.h"
#import "PVVideoGridViewController.h"
#import "UIView+Frame.h"
#import "PVComposerViewController.h"

#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface SocializerViewController ()

@property (nonatomic,strong) BOOL(^predicateBlock)(id evaluatedObject, NSDictionary *bindings);
@property (nonatomic,strong) NSArray *projects;
@property (nonatomic,strong) BubbleViewController *bubblizer;
@property (nonatomic,strong) PVContainerSwitcherController *switcherContainer;
@property (strong) PVSocializerTableViewController *tableViewController;
@property (strong) PVVideoGridViewController *gridViewController;

@end

@implementation SocializerViewController

@synthesize projects;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code (if view created from XIB)
        [self doInit];
    }
    return self;
}

// Is this even necessary?
-(void)doInit{
    self.projects = [NSArray array];
    self.switcherContainer = [[PVContainerSwitcherController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureViewControllers];
    //[self reloadData:nil];
}

-(void) configureViewControllers {
    [self addGridViewController];
    [self addTableViewController];
    
    [self.switcherContainer setupWithFirstViewController:self.tableViewController
                                    secondViewController:self.gridViewController
                                              parentView:self.bubbleLayer];
}

-(void)addGridViewController{
    self.gridViewController = [[PVVideoGridViewController alloc] initWithItemSize:CGSizeMake(88, 99) type:GridForProfile];
    [self addChildViewController:self.gridViewController];
}

-(void) addBubblizer {
    /*self.bubblizer = [[BubbleViewController alloc] init];
    [self addChildViewController:self.bubblizer];*/
}

-(void) addTableViewController {
    self.tableViewController = [[PVSocializerTableViewController alloc] initWithClassName:[PVProject parseClassName]];
    [self addChildViewController:self.tableViewController];
    
}

-(IBAction)toggleContent:(id)sender {
    [self.switcherContainer toggleViewControllers];
}

#pragma mark -
#pragma mark BubbleLayer Data Source

- (int) getMaxBubbles {
    return 12;
}

- (IBAction)showMenu:(id)sender {
    [self.revealViewController revealToggle:self];
}

- (IBAction)showComposer:(id)sender {
    PVComposerViewController *vc = [[PVComposerViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.navigationController presentViewController:navController
                                            animated:YES
                                          completion:^{
        
    }];
}

//for resigning on done button
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
