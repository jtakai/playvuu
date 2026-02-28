//
//  PVContainerSwitcherController.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVContainerSwitcherController.h"

@interface PVContainerSwitcherController ()

@property (nonatomic, assign) BOOL firstIsShown;
@property (nonatomic, strong) UIViewController *firstViewController;
@property (nonatomic, strong) UIViewController *secondViewController;
@property (nonatomic, strong) UIView *parentView;

@end

@implementation PVContainerSwitcherController

-(void) setupWithFirstViewController:(UIViewController*)firstViewController
                secondViewController:(UIViewController*)secondViewController
                          parentView:(UIView *)parentView {
    ASSERT(firstViewController);
    ASSERT(secondViewController);
    self.parentView = parentView;
    
    self.firstViewController = firstViewController;
    self.secondViewController = secondViewController;
    
    [self.parentView addSubview:firstViewController.view];
    
    firstViewController.view.frameHeight = self.parentView.frameHeight;
    firstViewController.view.frameOriginY = 0;
    [self switchToFirstViewController];
}

-(void) toggleViewControllers {
    if (self.firstIsShown) {
        [self switchToSecondViewController];
    } else {
        [self switchToFirstViewController];
    }
}

// We should maybe set this up so that it supports more than two
// viewcontrollers. i.e.
// setupWithParent:(UIViewController*)parent controllers:(NSArray *)vcs
// switchToViewController:(int)vcIndex

-(void) switchToFirstViewController {
    self.firstViewController.view.alpha = 0;
    [self.parentView addSubview:self.firstViewController.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.firstViewController.view.alpha = 1;
        self.secondViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.secondViewController.view removeFromSuperview];
        
        self.firstViewController.view.frameHeight = self.parentView.frameHeight;
        self.firstViewController.view.frameOriginY = 0;
        
        self.firstIsShown = YES;
    }];
    
}

-(void) switchToSecondViewController {
    self.secondViewController.view.alpha = 0;
    
    [self.parentView addSubview:self.secondViewController.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.secondViewController.view.alpha = 1;
        self.firstViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.firstViewController.view removeFromSuperview];
        self.secondViewController.view.frameHeight = self.parentView.frameHeight;
        self.secondViewController.view.frameOriginY = 0;
        self.firstIsShown = NO;
    }];
}

@end
