//
//  PVVideoTableViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/7/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVVideoTableViewController.h"
#import "PVVideoCell.h"
#import "PVProject.h"
#import "PVVideoOverlayViewController.h"
#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface PVVideoTableViewController ()
@property int selectedCommentsCell;
@end

@implementation PVVideoTableViewController

-(void)awakeFromNib{
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self doInit];
}


- (id) init{
    if(self = [super init]){
        [self doInit];
    }
    
    return self;
}

-(void) doInit{
    NSLog(@"doInit called on %@", [self class]);
    // The className to query on
    self.parseClassName = [PVProject parseClassName];

    // Whether the built-in pull-to-refresh is enabled
    self.pullToRefreshEnabled = YES;
    
    // The number of objects to show per page
    //self.objectsPerPage = 5;
    //self.selectedCommentsCell = -1;
//    (UITableView *)self.view
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(PFQuery *)queryForTable{
    return self.query?self.query:[super queryForTable];
}


#pragma mark -
#pragma mark TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PVVideoCell height];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"PVVideoCell";
    PVVideoCell *cell = (PVVideoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadFirstNibNamedWithNoOwner:[PVVideoCell class]];
        ASSERT(cell != nil);
    }
    
    PVProject *project = (PVProject *)object;
    ASSERT_CLASS(project, PVProject);
    
    __weak PVVideoTableViewController *safeMe = self;
    
    cell.bubbleTapBlock = ^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"VideoOverlay" bundle: nil];
        PVVideoOverlayViewController *pvoc = [sb instantiateInitialViewController];
        pvoc.project = project;
        [safeMe.navigationController addChildViewController:pvoc];

        [safeMe.navigationController.view addSubview:pvoc.view];
        pvoc.view.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            pvoc.view.alpha = 1.0;
        }];
    };
    
    cell.TappedCommentsBlock = ^{
        NSLog(@"TappedCommentsBlock");
    };
    
    cell.likeButtonPressedBlock = ^ {
        // @TODO: miya : Like button pressed;
        NSLog(@"Like button pressed");
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setupWithProject:project videoCellType:PVLikesAndCommentType];
    
    return cell;
}

@end
