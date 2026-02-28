//
//  ShuffleViewController.m
//  TestingPicker
//
//  Created by MN on 7/18/13.
//  Copyright (c) 2013 MN. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ShuffleViewController.h"
#import "ReelStopInformation.h"
#import "PVCaptureViewController.h"
#import "SWRevealViewController.h"

NSString * kItemKey = @"ItemKey";
NSString * kItemImage =  @"kItemImage";
NSString * kItemLabel  = @"kItemLabel";

NSUInteger kExtraSetOfItemAbove = 15;
NSUInteger kExtraSetOfItemBelow = 2;
NSUInteger kExtraSetOfItemComponents = 4;

@interface ShuffleViewController ()
{
}
@property (nonatomic, strong) IBOutlet UIPickerView * picker;
@property (nonatomic, strong) NSMutableArray * reelCitiesInfo;
@property (nonatomic, strong) NSMutableArray * reelConfigInfo;
@property (nonatomic, weak) NSMutableArray * currentReel; // weak

@property (nonatomic, assign) NSUInteger lastCitySelectedIndex;

@property (nonatomic, assign) BOOL verticalOrientation;
@property (nonatomic, assign) BOOL showText;
@property (strong, nonatomic) IBOutlet UILabel *titleTextView;
@property (strong, nonatomic) IBOutlet UILabel *notesTextView;
@property (strong, nonatomic) IBOutlet UIButton *spinButton;

@property (nonatomic, weak) IBOutlet UIView * cityView;
@property (nonatomic, weak) IBOutlet UILabel * cityLabel;

@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect pickerFrame;
@property (nonatomic, assign) CGRect notesFrame;
@property (nonatomic, assign) CGRect buttonFrame;

-(IBAction)nextCityLeft:(id)sender;
-(IBAction)nextCityRight:(id)sender;

-(IBAction)spinButtonPressed:(id)sender;

@end


@implementation ShuffleViewController

@synthesize picker = _picker;
@synthesize reelCitiesInfo = _reelCitiesInfo;
@synthesize reelConfigInfo = _reelConfigInfo;
@synthesize currentReel = _currentReel;

@synthesize titleTextView = _titleTextView;
@synthesize notesTextView = _notesTextView;
@synthesize spinButton = _spinButton;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleFrame = self.titleTextView.frame;
    self.pickerFrame = self.picker.frame;
    self.notesFrame = self.notesTextView.frame;
    self.buttonFrame = self.spinButton.frame;
    [self.navigationController setToolbarHidden:NO];
    self.notesTextView.font = [UIFont proximaNovaSemiBoldFontWithSize:20.0];
    self.titleTextView.font = [UIFont proximaNovaSemiBoldFontWithSize:20.0];
    self.notesTextView.textColor = [UIColor lightGrayColor];
    self.titleTextView.textColor = [UIColor lightGrayColor];
    
    [self configOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)awakeFromNib{
    NSArray * cities = @[
                         @[
                             @{
                                 kItemKey       : @"PARIS",
                                 kItemLabel     : @"Paris"
                                 },
                             @{
                                 kItemKey       : @"MI",
                                 kItemLabel     : @"Miami"
                                 },
                             @{
                                 kItemKey       : @"LA",
                                 kItemLabel     : @"Los Angeles"
                                 },
                             @{
                                 kItemKey       : @"LND",
                                 kItemLabel     : @"London"
                                 },
                             @{
                                 kItemKey       : @"NY",
                                 kItemLabel     : @"New York City"
                                 }
                             ]
                         ];
    
    
    NSArray * configReels = @[
                              @[
                                  @{
                                      kItemKey       : @"S1",
                                      kItemImage     : @"AI.png",
                                      kItemLabel     : @"Rodeo Drive"
                                      },
                                  @{
                                      kItemKey       : @"S2",
                                      kItemImage     : @"AL.png",
                                      kItemLabel     : @"5th Avenue"
                                      },
                                  @{
                                      kItemKey       : @"S3",
                                      kItemImage     : @"AQ.png",
                                      kItemLabel     : @"Abey Road"
                                      },
                                  @{
                                      kItemKey       : @"S4",
                                      kItemImage     : @"AW.png",
                                      kItemLabel     : @"2nd Street"
                                      }
                                  ],
                              @[
                                  @{
                                      kItemKey       : @"N1",
                                      kItemImage     : @"AR.png",
                                      kItemLabel     : @"LA Billboard"
                                      },
                                  @{
                                      kItemKey       : @"N2",
                                      kItemImage     : @"AI.png",
                                      kItemLabel     : @"NYC Billboard"
                                      },
                                  @{
                                      kItemKey       : @"N3",
                                      kItemImage     : @"AI.png",
                                      kItemLabel     : @"London Sign"
                                      },
                                  @{
                                      kItemKey       : @"N4",
                                      kItemImage     : @"AI.png",
                                      kItemLabel     : @"Street Sign"
                                      }
                                  ],
                              @[
                                  @{
                                      kItemKey       : @"L1",
                                      kItemImage     : @"AR.png",
                                      kItemLabel     : @"Hollywood"
                                      },
                                  @{
                                      kItemKey       : @"L2",
                                      kItemImage     : @"AI.png",
                                      kItemLabel     : @"Statue of Liberty"
                                      },
                                  @{
                                      kItemKey       : @"L3",
                                      kItemImage     : @"AI.png",
                                      kItemLabel     : @"Big Ben"
                                      }
                                  ],
                              @[
                                  @{
                                      kItemKey       : @"X1",
                                      kItemImage     : @"AR.png",
                                      kItemLabel     : @"The Greek  "
                                      },
                                  @{
                                      kItemKey       : @"X2",
                                      kItemImage     : @"AI.png",
                                      kItemLabel     : @"Time Square"
                                      },
                                  @{
                                      kItemKey       : @"X3",
                                      kItemImage     : @"AI.png",
                                      kItemLabel     : @"Westmister"
                                      }
                                  ]
                              ];
    
    [self setCities:cities];
    [self setReelConfiguration:configReels];
}

#pragma mark - Shake

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        if (![self isSpinning])
        {
            [self spin];
        }
    }
}

#pragma mark - Slot Machine

-(void)setCities:(NSArray*)cities
{
    self.reelCitiesInfo = [NSMutableArray array];
    
    NSUInteger component = 0;
    for (NSArray * reel in cities)
    {
        ReelStopInformation * reelInfo = [[ReelStopInformation alloc] init];
        reelInfo.reel = reel;
        reelInfo.component = component;
        
        [self.reelCitiesInfo addObject:reelInfo];
        
        //[reelInfo release];
        reelInfo = nil;
        
        component++;
    }
    [self.picker reloadAllComponents];
}

-(void)setReelConfiguration:(NSArray*)reels
{
    self.reelConfigInfo = [NSMutableArray array];
    
    NSUInteger component = 0;
    for (NSArray * reel in reels)
    {
        ReelStopInformation * reelInfo = [[ReelStopInformation alloc] init];
        reelInfo.reel = reel;
        reelInfo.component = component;
        
        [self.reelConfigInfo addObject:reelInfo];
        
        //[reelInfo release];
        reelInfo = nil;
        
        component++;
    }
    [self.picker reloadAllComponents];
}

//
//  Actual Reel: { A, B }
//     ___
// 0  | A |
// 1  | B | <-- reelInfo.stop = 1   
//     ---
//     ___
// 2  | A |
// 3  | B |
//     ---
//     ___
// 4  | A |
// 5  | B | <-- reelInfo.logicStop = 5
//     ---
//     ___
// 6  | A |
// 7  | B |
//     ---
//
// reelInfo.logicCount = 8

-(void)spin
{
    for (ReelStopInformation * reelInfo in self.currentReel)
    {
        // Fixed values
        reelInfo.stop = arc4random() % [reelInfo.reel count];
        NSUInteger extraCountSet = ((kExtraSetOfItemComponents * reelInfo.component) + kExtraSetOfItemAbove - 1);
        reelInfo.logicStop = reelInfo.stop + (extraCountSet * [reelInfo.reel count]);
        reelInfo.logicCount = [reelInfo.reel count] * (extraCountSet + kExtraSetOfItemBelow);

        // Dynamic values
        reelInfo.index = reelInfo.stop;
        reelInfo.spinning = YES;

        [self.picker selectRow:reelInfo.index
                   inComponent:reelInfo.component
                      animated:NO];

        NSLog(@"row:%d count:%d reelInfo:%@", reelInfo.component, [reelInfo.reel count], reelInfo);
    }
    
    [self.picker reloadAllComponents];
    
    [self spinpicker];
}

-(BOOL)isSpinning
{
    BOOL spinning = NO;
    for (ReelStopInformation * reelInfo in self.currentReel)
    {
        if (reelInfo.spinning)
        {
            spinning = YES;
            break;
        }
    }
    return spinning;
}

-(void)spinpicker
{
//    NSLog(@"---- spinpicker ----");
    for (ReelStopInformation * reelInfo in self.currentReel)
    {
        if (reelInfo.spinning)
        {
            if (reelInfo.index + [reelInfo.reel count] > reelInfo.logicStop)
            {
                reelInfo.spinning = NO;
                
                NSDictionary * item = [reelInfo.reel objectAtIndex:reelInfo.stop];
                NSLog(@"row:%d stop with data:%@", reelInfo.component, [item objectForKey:kItemLabel]);
            }
            else
            {
                reelInfo.index += [reelInfo.reel count];
                [self.picker selectRow:reelInfo.index
                           inComponent:reelInfo.component
                              animated:YES];
                
//              NSLog(@"moveto:%d component:%d", reelInfo.index, reelInfo.component);
            }
        }
    }
    
    if ([self isSpinning])
    {
        [self performSelector:@selector(spinpicker) withObject:nil afterDelay:0.1f];
    }
    else
    {
        // All reels are stopped
//        [self startWinnerAnimation];
    }
}

-(void)startWinnerAnimation
{
    ReelStopInformation * reelInfo = [self.currentReel objectAtIndex:0];
    
    UIView * view = [self.picker viewForRow:reelInfo.logicStop forComponent:0];
    reelInfo.imageView = [[view subviews] objectAtIndex:0];
    reelInfo.frame = 0;
    
    [self animateImageForReelInfo:reelInfo];
}

const CGFloat kFrameAnimationTime = 0.1f;

//-(void)animateImageView:(UIImageView*)imageView reelInfo:(ReelStopInformation*)reelInfo
-(void)animateImageForReelInfo:(ReelStopInformation*)reelInfo
{
    reelInfo.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag%d.png", reelInfo.frame]];
    
    CATransition *transition = [CATransition animation];
    transition.duration = kFrameAnimationTime;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;
    
    [reelInfo.imageView.layer addAnimation:transition forKey:nil];
    
    reelInfo.frame = (reelInfo.frame + 1) % 4;
    
    [self performSelector:@selector(animateImageForReelInfo:) withObject:reelInfo afterDelay:kFrameAnimationTime];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [self.currentReel count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    ReelStopInformation * reelInfo = [self.currentReel objectAtIndex:component];
    return reelInfo.logicCount;
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *pickerCustomView = (id)view;
    UILabel *pickerViewLabel;
    UIImageView *pickerImageView;
    
    ReelStopInformation * reelInfo = [self.currentReel objectAtIndex:component];
    
    NSDictionary * item = [reelInfo.reel objectAtIndex:row % [reelInfo.reel count]];
    
    if (pickerCustomView)
    {
        pickerImageView = [[pickerCustomView subviews] objectAtIndex:0];
        pickerViewLabel = [[pickerCustomView subviews] objectAtIndex:1];
    }
    else
    {
        CGSize size = [pickerView rowSizeForComponent:component];
        
        pickerCustomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                    size.width,
                                                                    size.height)];
        
        pickerImageView = [[UIImageView alloc] initWithFrame:pickerCustomView.frame];
        pickerImageView.contentMode = UIViewContentModeScaleAspectFit;

        pickerViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f,
                                                                     size.width - 15.0f,
                                                                     size.height)];

        pickerViewLabel.backgroundColor = [UIColor clearColor]; //[UIColor colorWithRed:1 green:0 blue:0 alpha:0.2f];
        pickerViewLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        pickerViewLabel.textAlignment = NSTextAlignmentCenter;
        pickerViewLabel.adjustsFontSizeToFitWidth = YES;
        pickerViewLabel.adjustsLetterSpacingToFitWidth = YES;
        pickerViewLabel.numberOfLines = 1;
        pickerViewLabel.minimumScaleFactor = 0.1;
                
        [pickerCustomView addSubview:pickerImageView]; // index 0
        [pickerCustomView addSubview:pickerViewLabel]; // index 1
    }
    
    if (self.showText)
    {
        pickerViewLabel.text = [item objectForKey:kItemLabel];
        pickerImageView.image = nil;
    }
    else
    {
        pickerViewLabel.text = @"";
        pickerImageView.image = [UIImage imageNamed:[item objectForKey:kItemImage]];
    }
    
    return pickerCustomView;
}

#pragma mark - Rotation

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(BOOL)shouldAutorotate
{
    return ![self isSpinning];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (self.verticalOrientation)
    {
        NSUInteger index = [self.picker selectedRowInComponent:0];
        ReelStopInformation * reelStop = [self.reelCitiesInfo objectAtIndex:0];
        
//        NSDictionary * dic =  [reelStop.reel objectAtIndex:index%reelStop.reel.count];
        self.lastCitySelectedIndex = index%reelStop.reel.count;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self configOrientation];
}

-(void)configOrientation
{    
    switch ([[UIDevice currentDevice] orientation])
    {
        default:
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            self.verticalOrientation = YES;
            break;

        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            self.verticalOrientation = NO;
            break;
    }
    
    if (self.verticalOrientation)
    {
        self.currentReel = self.reelCitiesInfo;
        self.showText = YES;
        
        self.titleTextView.alpha = 1;
        self.notesTextView.alpha = 1;
        self.spinButton.alpha = 1;
        
        [self.navigationItem setRightBarButtonItem:nil];
        //[self.navigationItem setTitle:@""];
        
        self.cityView.hidden = YES;
        self.cityLabel.text = @"";
        
        self.titleTextView.frame = self.titleFrame;
        self.picker.frame = self.pickerFrame;
        self.notesTextView.frame = self.notesFrame;
        self.spinButton.frame = self.buttonFrame;
    }
    else
    {
        self.currentReel = self.reelConfigInfo;
        self.showText = YES;
        
        self.titleTextView.alpha = 0;
        self.notesTextView.alpha = 0;
        self.spinButton.alpha = 0;
        
        UIBarButtonItem * button = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Shuffle!"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(spin)];

        [self.navigationItem setRightBarButtonItem:button];
        
//        [self.navigationItem setTitle:[self.lastCitySelected objectForKey:kItemLabel]];
        //[self.navigationItem setTitle:@""];
        
        self.cityView.hidden = NO;
        
        ReelStopInformation * reelStop = [self.reelCitiesInfo objectAtIndex:0];
        NSDictionary * dic =  [reelStop.reel objectAtIndex:self.lastCitySelectedIndex];
        self.cityLabel.text = [dic objectForKey:kItemLabel];

        CGRect frameParent = self.picker.superview.frame;
        
        CGRect framePicker = self.picker.frame;
        framePicker.origin.y = frameParent.size.height - framePicker.size.height - 35;
        self.picker.frame =  framePicker;

        CGRect frameCity = self.cityView.frame;
        frameCity.origin.y = 30;
        self.cityView.frame = frameCity;
    }
    
    [self.picker reloadAllComponents];
    [self spin];
}

#pragma mark - IBActions

-(IBAction)spinButtonPressed:(id)sender
{
    [self spin];
}

-(IBAction)nextCityLeft:(id)sender
{
    ReelStopInformation * reelStop = [self.reelCitiesInfo objectAtIndex:0];
    
    if (self.lastCitySelectedIndex == 0)
    {
        self.lastCitySelectedIndex =  [reelStop.reel count] - 1;
    }
    else
    {
        self.lastCitySelectedIndex--;
    }
    
    NSDictionary * dic =  [reelStop.reel objectAtIndex:self.lastCitySelectedIndex];
    self.cityLabel.text = [dic objectForKey:kItemLabel];
}

-(IBAction)nextCityRight:(id)sender
{
    ReelStopInformation * reelStop = [self.reelCitiesInfo objectAtIndex:0];
    
    self.lastCitySelectedIndex ++;
    if (self.lastCitySelectedIndex >= [reelStop.reel count])
    {
        self.lastCitySelectedIndex = 0;
    }
    
    NSDictionary * dic =  [reelStop.reel objectAtIndex:self.lastCitySelectedIndex];
    self.cityLabel.text = [dic objectForKey:kItemLabel];
}

- (IBAction)showMenu:(id)sender {
    [self.revealViewController revealToggle:self];
}
@end
