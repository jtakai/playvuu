//
//  PVComposerViewController.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/18/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVComposerViewController.h"
#import "PVComposeFriendChooserCell.h"
#import "PVComposeFriends.h"
#import "PVComposeFriendViewModel.h"
#import "PVChooseFriendsViewController.h"
#import "PVChooseVideosViewController.h"

@interface PVComposerViewController ()

@property (weak, nonatomic) IBOutlet UIView *chooseYourNameContainer;
@property (weak, nonatomic) IBOutlet UIView *chooseYourVideoContainer;

@end

@implementation PVComposerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self doInit];
    }
    return self;
}

-(void) doInit {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"x_button.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
    
}

-(void) close {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void) awakeFromNib {
    [super awakeFromNib];
    [self doInit];
}

-(NSString*) nibName {
    return NSStringFromClass([self class]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"COMPOSE";
    
    PVChooseFriendsViewController *vc = [[PVChooseFriendsViewController alloc] init];
    [self addChildViewController:vc];
    [self.chooseYourNameContainer addSubview:vc.view];
    
    PVChooseVideosViewController *videoChooser = [[PVChooseVideosViewController alloc] init];
    [self addChildViewController:videoChooser];
    [self.chooseYourVideoContainer addSubview:videoChooser.view];
    
}

@end
