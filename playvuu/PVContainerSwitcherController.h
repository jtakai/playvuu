//
//  PVContainerSwitcherController.h
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

@interface PVContainerSwitcherController : NSObject

-(void) setupWithFirstViewController:(UIViewController*)firstViewController
                secondViewController:(UIViewController*)secondViewController
                          parentView:(UIView*)parentView;

-(void) toggleViewControllers;

-(void) switchToFirstViewController;
-(void) switchToSecondViewController;

@end
