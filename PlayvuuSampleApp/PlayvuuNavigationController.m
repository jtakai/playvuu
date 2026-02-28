//
//  PlayvuuNavigationController.m
//  PlayvuuSampleApp
//
//  Created by Brian Smith on 8/29/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#import "PlayvuuNavigationController.h"

@interface PlayvuuNavigationController ()

@end

@implementation PlayvuuNavigationController

- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

@end
