//
//  PVLibraryViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/1/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVLibraryViewController.h"
#import "PVLibraryTableViewController.h"
#import "PVContainerSwitcherController.h"
#import "PVVideoGridViewController.h"
#import "PVProject.h"

@interface PVLibraryViewController ()
@property (strong) BOOL(^predicateBlock)(id evaluatedObject, NSDictionary *bindings);
@property (strong) NSArray *projects;
@property (strong) PVContainerSwitcherController *switcherContainer;
@property (strong) PVLibraryTableViewController *tableViewController;
@property (strong) PVVideoGridViewController *gridViewController;

@end


@implementation PVLibraryViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code (if view created from XIB)
        [self doInit];
    }
    return self;
}

-(void)doInit{
    self.projects = [NSArray array];
    self.switcherContainer = [[PVContainerSwitcherController alloc] init];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configureViewControllers];
}

-(void) configureViewControllers {
    [self addGridViewController];
    [self addTableViewController];
    
    [self.switcherContainer setupWithFirstViewController:self.tableViewController
                                    secondViewController:self.gridViewController
                                              parentView:self.videoLayer];
    
    
}

-(void)addGridViewController{
    self.gridViewController = [[PVVideoGridViewController alloc] initWithItemSize:CGSizeMake(88, 99) type:GridForProfile];
    [self addChildViewController:self.gridViewController];
}

-(void) addTableViewController {
    self.tableViewController = [[PVLibraryTableViewController alloc] initWithClassName:[PVProject parseClassName]];
    [self addChildViewController:self.tableViewController];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu:(id)sender {
    [self.revealViewController revealToggle:self];
}

- (IBAction)toggleContent:(id)sender{
    [self.switcherContainer toggleViewControllers];
}



@end
