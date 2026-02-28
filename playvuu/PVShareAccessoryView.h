//
//  PVShareAccessoryView.h
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PVShareAccessoryView : UIView

@property (nonatomic, copy) void (^sharePressedBlock)(void);

-(void) setupWithDate:(NSDate*)date;

-(IBAction) shareButtonPressed:(UIButton*)button;

@end
