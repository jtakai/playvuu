//
//  ProfileViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 7/31/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "ProfileViewController.h"
#import "ContainerViewController.h"
#import "PVUser.h"
#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface ProfileViewController (){
    PVUser *user;
    PVUserData *userData;
}
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) ContainerViewController *containerViewController;
@end

@implementation ProfileViewController
#define GM_TAG        1002


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}

- (void)awakeFromNib{
    // Custom initialization
    
    JCGridMenuColumn *bubbles = [[JCGridMenuColumn alloc]
                                 initWithButtonAndImages:CGRectMake(0, 0, 44, 44)
                                 normal:@"popover_bubbles"
                                 selected:nil
                                 highlighted:nil
                                 disabled:nil];
    [bubbles.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.8f]];
    [bubbles setCloseOnSelect:YES];
    
    JCGridMenuColumn *table = [[JCGridMenuColumn alloc]
                               initWithButtonAndImages:CGRectMake(0, 0, 44, 44)
                               normal:@"popover_list"
                               selected:nil
                               highlighted:nil
                               disabled:nil];
    [table.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.8f]];
    [table setCloseOnSelect:YES];
    
    JCGridMenuColumn *grid = [[JCGridMenuColumn alloc]
                              initWithButtonAndImages:CGRectMake(0, 0, 44, 44)
                              normal:@"popover_grid"
                              selected:nil
                              highlighted:nil
                              disabled:nil];
    [grid.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.8f]];
    [grid setCloseOnSelect:YES];
    
    
    JCGridMenuRow *share = [[JCGridMenuRow alloc] initWithImages:@"three_dot" selected:@"Close" highlighted:@"ShareSelected" disabled:@"Share"];
    [share setColumns:[[NSMutableArray alloc] initWithObjects:bubbles, table, grid, nil]];
    [share setIsModal:NO];
    
    NSArray *rows = [[NSArray alloc] initWithObjects:share, nil];
    self.gmDemo = [[JCGridMenuController alloc] initWithFrame:CGRectMake(0,109,320,44) rows:rows tag:GM_TAG];
    [self.gmDemo setDelegate:self];
    [self.view addSubview:_gmDemo.view];
    //[self.navigationController.view addSubview:self.gmDemo.view];
    [self.gmDemo open];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    user = [PVUser currentUser];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [user.userData fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        _profilePicture.file = user.userData.profilePicture;
        [_profilePicture loadInBackground];
        _displayName.text = user.userData.displayName;
    }];
    
    if(user.status.length)
        self.statusLabel.text = user.status;
}

-(void)viewDidAppear:(BOOL)animated{
    if(![[PVUser currentUser] isAuthenticated])
        [self presentUserSign];
}


#pragma mark - JCGridMenuController Delegate

- (void)jcGridMenuRowSelected:(NSInteger)indexTag indexRow:(NSInteger)indexRow isExpand:(BOOL)isExpand
{
    
    if (isExpand) {
        NSLog(@"jcGridMenuRowSelected %i %i isExpand", indexTag, indexRow);
    } else {
        NSLog(@"jcGridMenuRowSelected %i %i !isExpand", indexTag, indexRow);
    }
    
    if (indexTag==GM_TAG) {
        
        // We can change the share button icon here...
        
        [[[[_gmDemo rows] objectAtIndex:indexRow] button] setSelected:isExpand];
    }
    
}

- (void)jcGridMenuColumnSelected:(NSInteger)indexTag indexRow:(NSInteger)indexRow indexColumn:(NSInteger)indexColumn
{
    static int currentStatus = 1;
    NSLog(@"jcGridMenuColumnSelected %i %i %i", indexTag, indexRow, indexColumn);
    if(indexColumn != currentStatus && indexColumn !=3){
        [self.containerViewController swapViewControllers];
        currentStatus = indexColumn;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userStatusChanged:(UITextField *)sender {
    user.status = _userStatus.text;
    self.statusLabel.text = _userStatus.text;
    [user saveEventually];
}

- (IBAction)swapButtonPressed:(UIButton *)sender {
    [self.containerViewController swapViewControllers];
}

- (IBAction)showMenu:(id)sender {
    [self.revealViewController revealToggle:self];
}

//for resigning on done button
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
