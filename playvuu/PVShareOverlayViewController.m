//
//  PVShareOverlayViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/20/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVShareOverlayViewController.h"
#import "PVVideoGridViewController.h"
#import "PVBubbleView.h"

@interface PVShareOverlayViewController ()
@property (strong) ALRadialMenu *shareMenu;
@property (weak, nonatomic) IBOutlet PVBubbleView *bubbleView;
@end

@implementation PVShareOverlayViewController

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
	// Do any additional setup after loading the view, typically from a nib.
	
	//create an instance of the radial menu and set ourselves as the delegate.
	self.shareMenu = [[ALRadialMenu alloc] init];
	self.shareMenu.delegate = self;
    
    [self.bubbleView setSlideShow:self.project.slideTexture];
    [self.shareMenu buttonsWillAnimateFromButton:self.bubbleView withFrame:self.bubbleView.frame inView:self.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu {
    return 4;
}


- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu {
    return 90;
}


- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu {
    return 150;
}


- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index {
    static NSArray *radialImageNames;
    
    if(!radialImageNames)
        radialImageNames = @[@"facebook-big", @"messenger-generic", @"email", @"twitter-big"];
    
    return [UIImage imageNamed:[radialImageNames objectAtIndex:index-1]];
 }


- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"Touched %d", index);
}

- (IBAction)exit:(id)sender {
    [self.view removeFromSuperview];
    //[self removeFromParentViewController];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

@end
