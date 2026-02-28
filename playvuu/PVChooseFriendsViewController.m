//
//  PVChooseFriendsViewController.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/19/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVChooseFriendsViewController.h"
#import "PVComposeFriendChooserCell.h"
#import "PVComposeFriends.h"

@interface PVChooseFriendsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *chooseYourFriendsLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) PVComposeFriends *composeFriends;

@end

@implementation PVChooseFriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self doInit];
    }
    return self;
}

-(void) doInit {
    
}

-(NSString*) nibName {
    return NSStringFromClass([self class]);
}

-(void) awakeFromNib {
    [super awakeFromNib];
    [self doInit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTitles];
    
}

-(void) setupTitles {
    self.chooseYourFriendsLabel.textColor = [UIColor navigationBarBlueColor];
    self.chooseYourFriendsLabel.font = [UIFont proximaNovaSemiBoldFontWithSize:17];
    
    self.subtitle.textColor = [UIColor videoCellDarkGrayColor];
    self.subtitle.font = [UIFont proximaNovaRegularWithSize:12];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return [self.composeFriends count];
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"PVComposeFriendChooserID";
    PVComposeFriendChooserCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadFirstNibNamedWithNoOwner:[PVComposeFriendChooserCell class]];
    }
    
    [cell setupWithModel:nil];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PVComposeFriendChooserCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    
}

-(NSArray*) chosenFriends {
    return [self.composeFriends selectedFriends];
}



@end
