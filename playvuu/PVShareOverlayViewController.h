//
//  PVShareOverlayViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 9/20/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALRadialMenu.h"
#import "PVProject.h"

@interface PVShareOverlayViewController : UIViewController <ALRadialMenuDelegate>
@property (strong) PVProject *project;
@end
