//
//  SharingMenuViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/21/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVSharingMenuViewController.h"

@interface PVSharingMenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end

@implementation PVSharingMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.font = [UIFont proximaNovaBoldWithSize:24.0];
    self.titleLabel.textColor = [UIColor navigationBarBlueColor];
    self.commentLabel.font = [UIFont proximaNovaSemiBoldFontWithSize:18];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
