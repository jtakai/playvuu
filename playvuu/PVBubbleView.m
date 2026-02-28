//
//  PVBubbleView.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/2/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVBubbleView.h"
#import <Parse/Parse.h>
#import <QuartzCore/CAAnimation.h>

@interface PVBubbleView (){
    CALayer *imageLayer, *backLayer;
    CGPoint offset;
    UIImage *image;
    int frameIndex;
    NSTimer *timer;
}
@end

@implementation PVBubbleView

//@synthesize world;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}

-(void) awakeFromNib{
    // our main layer, holds the main image
    CGRect viewFrame = self.bounds;
    imageLayer = [CALayer layer];
    imageLayer.frame = viewFrame;
    imageLayer.opaque = NO; // this speeds stuff up if you don't need transparency
    [self.layer addSublayer:imageLayer];
    imageLayer.actions = @{ @"contentsRect" : [NSNull null]};//, @"contentsScale" : [NSNull null] };
    
    // Create a mask layer and the frame to determine what will be visible in the view.
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height);
    
    // Create a path with the rectangle in it.
    CGPathRef path = CGPathCreateWithEllipseInRect(maskRect, nil);
    
    // Set the path to the mask layer.
    maskLayer.path = path;
    
    // Release the path since it's not covered by ARC.
    CGPathRelease(path);
    
    self.layer.mask = maskLayer;

    frameIndex = 0;

    // Tap recognizer
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onViewTouch:)];
    touch.minimumPressDuration = 0;
    [self addGestureRecognizer:touch];
}

-(void)stopAnimating{
    [timer invalidate];
    timer = nil;
}

-(void)startAnimating{
    if(!timer)
        timer = [NSTimer scheduledTimerWithTimeInterval:1.1f target:self selector:@selector(nextSlide) userInfo:nil repeats:YES];
        frameIndex = 0;
}

-(void)setSlideShow:(PFFile *)slideFile{
    __weak PVBubbleView *weakSelf = self;
    
    [slideFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error)
            [weakSelf setAtlas:[[UIImage alloc] initWithData:data]];
        else
            NSLog(@"Couldn't fetch data: %@", error);
    }];
}

-(void)setAtlas:(UIImage *)atlasImage{
    image = atlasImage;
    imageLayer.contents = (id)image.CGImage;
	imageLayer.masksToBounds = YES;
	imageLayer.contentsRect = [self rectForFrameIndex:frameIndex];
    [self startAnimating];
}

// remember that CALayers have 0,0 at the lower left
-(CGRect)rectForFrameIndex:(NSInteger)frameIdx
{
    frameIdx%=4;
	NSInteger col = frameIdx % 2;
	NSInteger row = frameIdx / 2;
    return CGRectMake(0.5f*col, 0.5f*row, 0.5f, 0.5f);
}

-(void)nextSlide{
    /*backLayer.contentsRect = [self rectForFrameIndex:frameIndex+1];
    CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];
    crossFade.duration = 1.0;
    crossFade.fromValue = imageLayer.contents;
    crossFade.toValue = imageLayer.contents;
    [imageLayer addAnimation:crossFade forKey:@"animateContents"];*/
    imageLayer.contentsRect = [self rectForFrameIndex:++frameIndex];
}


- (void) onViewTouch:(UILongPressGestureRecognizer *)touch
{
    switch(touch.state){
        case UIGestureRecognizerStateBegan:
            self.transform = CGAffineTransformMakeScale(1.1, 1.1);
            //[self.layer addAnimation:[PVBubbleView getPulseAnimation] forKey:@"touch"];
            break;
        case UIGestureRecognizerStateEnded:
                self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            if(self.tapBlock)
                self.tapBlock();
            break;
        default:
            break;
            ASSERT(NO);
    }
}
/*
+(CABasicAnimation *)getPulseAnimation{
    static CABasicAnimation *pulseAnim;
    
    if(!pulseAnim){
        pulseAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        
        pulseAnim.fromValue = [NSNumber numberWithFloat:1.00];
        pulseAnim.toValue = [NSNumber numberWithFloat:1.10];
        [pulseAnim setDuration:0.20f];
        
        [pulseAnim setFillMode:kCAFillModeForwards];
        [pulseAnim setRemovedOnCompletion:NO];
    }
    
    return pulseAnim;
}*/

@end
