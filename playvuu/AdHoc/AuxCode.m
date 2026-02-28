//
//  AuxCode.m
//  playvuu
//
//  Created by Pablo Vasquez on 7/31/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AuxCode.h"
#import "QuartzCore/CAAnimation.h"
#import "QuartzCore/CAMediaTimingFunction.h"
#import "QuartzCore/CADisplayLink.h"


@implementation AuxCode


NSThread *m_animationthread;
BOOL m_animationthreadrunning;

NSArray *balls;

- (void)startAnimating
{
    //called from UI thread
    NSLog(@"creating animation thread");
    m_animationthread = [[NSThread alloc] initWithTarget:self selector:@selector(animationThread:) object:nil];
    [m_animationthread start];
}

- (void)stopAnimating
{
    // called from UI thread
    NSLog(@"quitting animationthread");
    [self performSelector:@selector(quitAnimationThread) onThread:m_animationthread withObject:nil waitUntilDone:NO];
    
    // wait until thread actually exits
    while(![m_animationthread isFinished])
        [NSThread sleepForTimeInterval:0.01];
    NSLog(@"thread exited");
    
    m_animationthread = nil;
}


-(void)pulse
{
    static int cnt = 0;
    UIView *oldBall = [balls objectAtIndex:(cnt%4)];
    UIView *newBall = [balls objectAtIndex:(++cnt%4)];
    float value = 1.2;
    float duration = 0.3;
    /*
     [oldBall setHidden:YES];
     [newBall setHidden:NO];*/
    [UIView animateWithDuration:0.1 animations:^{
        oldBall.alpha = 0;
    }];
    [UIView animateWithDuration:0.2 animations:^{
        newBall.alpha = 1;
    }];
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = duration;
    pulseAnimation.toValue = [NSNumber numberWithFloat:value];;
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = 1;
    
    [newBall.layer addAnimation:pulseAnimation forKey:nil];
}

- (void)animationThread:(id)object
{
    @autoreleasepool
    {
        NSLog(@"animation thread started");
        m_animationthreadrunning = YES;
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        CADisplayLink *displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        [displaylink setFrameInterval:3];
        
        [displaylink addToRunLoop:runLoop forMode:NSDefaultRunLoopMode];
        
        while(m_animationthreadrunning)
        {
            [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"runloop gap");
        }
        
        [displaylink removeFromRunLoop:runLoop forMode:NSDefaultRunLoopMode];
        
        NSLog(@"animation thread quit");
    }
}

- (void)quitAnimationThread
{
    NSLog(@"quitanimationthread called");
    m_animationthreadrunning = NO;
}

- (void)displayLinkAction:(CADisplayLink *)sender
{
    NSLog(@"display link called");
    //[self drawView];
}



@end



