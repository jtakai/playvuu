//
//  MainViewController.h
//  PlayvuuSampleApp
//
//  Created by Brian Smith on 8/23/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIImagePickerControllerDelegate>

@property (nonatomic,weak) IBOutlet UIButton * playbackButton;

- (IBAction) showCamera:(id)sender;
- (IBAction) showPrerecorded:(id)sender;

@end
