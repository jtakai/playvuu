//
//  SplashViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 7/24/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconSlider.h"

@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
- (IBAction)twitter:(id)sender;
- (IBAction)facebook:(id)sender;
@end
