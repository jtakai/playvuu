//
//  PVChooseVideosViewController.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/19/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVChooseVideosViewController.h"
#import "PVComposerVideoChooserCell.h"
#import "PVVideoGridViewController.h"


@interface PVChooseVideosViewController ()

@property (strong, nonatomic) IBOutlet PVVideoGridViewController* videoGrid;
@property (weak, nonatomic) IBOutlet UILabel *chooseVideosLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseVideoSubtitle;
@property (weak, nonatomic) IBOutlet UIView *gridContainer;

@end

@implementation PVChooseVideosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self doInit];
    }
    return self;
}

-(void) awakeFromNib {
    [super awakeFromNib];
    [self doInit];
}

-(void) doInit {

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTitles];
    self.videoGrid = [[PVVideoGridViewController alloc] initWithItemSize:CGSizeMake(89, 99) type:GridForComposer];
    [self addChildViewController:self.videoGrid];
    self.videoGrid.collectionView.frame = self.gridContainer.bounds;
    self.videoGrid.collectionView.backgroundColor = self.view.backgroundColor;
    [self.gridContainer addSubview:self.videoGrid.collectionView];
}

-(void) setupTitles {
    self.chooseVideosLabel.textColor = [UIColor navigationBarBlueColor];
    self.chooseVideosLabel.font = [UIFont proximaNovaSemiBoldFontWithSize:17];
    
    self.chooseVideoSubtitle.textColor = [UIColor videoCellDarkGrayColor];
    self.chooseVideoSubtitle.font = [UIFont proximaNovaRegularWithSize:12];
}


- (IBAction)previousPage:(id)sender {
    NSLog(@"previousPage");
/*
    NSArray *visibleArray = [self.tableview indexPathsForVisibleRows];

    NSIndexPath *idx = visibleArray[0];
    
    NSInteger page = MAX(0, idx.row -1);
    
    [self.tableview setContentOffset:CGPointMake(0, 300*page) animated:YES];
 */
    
}

- (IBAction)nextPage:(id)sender {
    NSLog(@"nextPage");
    /*
    NSArray *visibleArray = [self.tableview indexPathsForVisibleRows];
    
    NSIndexPath *idx = visibleArray[0];
    
    NSInteger page = MAX(0, idx.row +1);
        [self.tableview setContentOffset:CGPointMake(0, 300*page) animated:YES];
     */
}

@end
