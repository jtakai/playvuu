//
//  PVLibraryTableViewController.m
//  playvuu
//
//  Created by Ariel Groesman on 9/18/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVLibraryTableViewController.h"
#import "PVShareOverlayViewController.h"
#import "PVProject.h"
#import "PVVideoCell.h"


@interface PVLibraryTableViewController ()

@end

@implementation PVLibraryTableViewController


- (id)init
{
    self = [super init];
    if (self) {
        [self doInit];
    }
    return self;
}

-(void) doInit {
    // The className to query on
    self.parseClassName = [PVProject parseClassName];
    
    // The key of the PFObject to display in the label of the default cell style
    // self.textKey = @"text";
    
    // Whether the built-in pull-to-refresh is enabled
    self.pullToRefreshEnabled = YES;
    
    // Whether the built-in pagination is enabled
    self.paginationEnabled = YES;
    
    // The number of objects to show per page
    self.objectsPerPage = 5;
}
-(void)awakeFromNib{
    
    [self doInit];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(PFQuery *)queryForTable{
    return self.query?self.query:[super queryForTable];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PVVideoCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"PVVideoCell";
    PVVideoCell *cell = (PVVideoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadFirstNibNamedWithNoOwner:[PVVideoCell class]];
        ASSERT(cell != nil);
    }
    
    PVProject *project = (PVProject *)object;
    ASSERT_CLASS(project, PVProject);
    
    cell.sharePressedBlock = ^ {
        // @TODO: Miya -- Share button pressed!
        NSLog(@"ShareButtonPressed");
    };
    
    __weak PVLibraryTableViewController *safeMe = self;
    
    cell.bubbleTapBlock = ^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ShareOverlay" bundle: nil];
        PVShareOverlayViewController *pvoc = [sb instantiateInitialViewController];
        pvoc.project = project;
        [safeMe.navigationController addChildViewController:pvoc];
        
        [safeMe.navigationController.view addSubview:pvoc.view];
        pvoc.view.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            pvoc.view.alpha = 1;
        }];
    };
    
    [cell setupWithProject:project videoCellType:PVShareType];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
