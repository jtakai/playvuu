//
//  BubbleViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/1/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "BubbleViewController.h"
#import "BubbleLayer.h"
#import "PVStatusVars.h"

@interface BubbleViewController ()
{
    PVBubbleWorld* world;
    NSTimer *tickTimer;
    BubbleLayer *bubbleLayer;
    CCScene *bubbleScene;
}
@end

@implementation BubbleViewController

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
    
    CCDirector *director = [CCDirector sharedDirector];
    
    if([director isViewLoaded] == NO)
    {
        // Create the OpenGL view that Cocos2D will render to.
        CCGLView *glView = [CCGLView viewWithFrame:[self.view bounds]//[[[UIApplication sharedApplication] keyWindow] bounds]
                                       pixelFormat:kEAGLColorFormatRGB565
                                       depthFormat:0
                                preserveBackbuffer:NO
                                        sharegroup:[PVStatusVars getGPUImageSharegroup]
                                     multiSampling:NO
                                   numberOfSamples:0];
        
        // View setup
        [director setView:glView];
        
        // Initialize other director settings.
        [director setAnimationInterval:1.0f/60.0f];

        if( ! [director enableRetinaDisplay:YES] )
            CCLOG(@"Retina Display Not supported");

        [director setProjection:kCCDirectorProjection2D];
        [director setDisplayStats:NO];
        
        // Default texture format for PNG/BMP/TIFF/JPEG/GIF images
        // It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
        // You can change anytime.
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

        // Assume that PVR images have premultiplied alpha
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    }
    
    // Set the view controller as the director's delegate, so we can respond to certain events.
    director.delegate = self;
    
    // Add the director as a child view controller of this view controller.
    [self addChildViewController:director];
    
    // Add the director's OpenGL view as a subview so we can see it.
    [self.view addSubview:director.view];
    [self.view sendSubviewToBack:director.view];
    
    // Finish up our view controller containment responsibilities.
    [director didMoveToParentViewController:self];
    
    // Run whatever scene we'd like to run here.
    if(!bubbleScene)
        bubbleScene = [BubbleLayer scene];
    
    if([director runningScene])
        [director replaceScene:bubbleScene];
    else
        [director runWithScene:bubbleScene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)addBubbleAtX:(float)xPos y:(float)yPos withVideo:(NSString *)video andSlideShow:(UIImage*)slideShow{
    int idx = [bubbleLayer createBubble:PVBubbleWorld::E_GROW x:xPos y:yPos];
    PVVideoSprite *bubble = [bubbleLayer getBubbleAtIndex:idx];
    [bubble setMovieAtUrl:nil];
    [bubble setSlideShow:slideShow];
    return idx;
}

-(void)reset{
    [bubbleLayer resetBubbles];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[CCDirector sharedDirector] stopAnimation];
}

@end
