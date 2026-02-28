//
//  CaptureViewController.h
//  PlayvuuSampleApp
//
//  Created by Brian Smith on 6/29/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GPUImage/GPUImage.h>
#import <PlayvuuSDK/PlayvuuSDK.h>
#import "PVOutputFrameWriter.h"

@interface PVCaptureViewController : UIViewController<UIAlertViewDelegate,PVEngineDelegate,PVOutputFrameWriterDelegate>
{
    NSURL * _savedVideoURL;
    NSMutableArray * _featureViews;
    
    PVEngine * _playvuuEngine;
    
    PVLayer * _filterLayer;
    PVLayer * _overlayLayer;
    PVLayer * _glassesLayer;
}
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@property (nonatomic,weak) IBOutlet GPUImageView * outputView;

@property (nonatomic,weak) IBOutlet UIImageView * adviceImageView;
@property (nonatomic,weak) IBOutlet UILabel * statusLabel;
@property (nonatomic,weak) IBOutlet UILabel * debugLabel;

- (IBAction)toggleRecord:(UIBarButtonItem *)sender;
- (IBAction)swapCamera:(id)sender;

@property (nonatomic,weak) IBOutlet UISwitch * toggleFacesSwitch;
@property (nonatomic,weak) IBOutlet UISwitch * toggleDebugSwitch;
@property (nonatomic,weak) IBOutlet UISwitch * toggleGlassesLayerSwitch;
@property (nonatomic,weak) IBOutlet UISwitch * toggleOverlayLayerSwitch;
@property (nonatomic,weak) IBOutlet UISwitch * toggleFilterLayerSwitch;
- (IBAction)cancel:(id)sender;

- (void) setupPlayvuuEngine;

- (IBAction) switchToggled:(id)sender;

- (void) startRecording;
- (void) saveRecording;

- (void) rotateOutputViewToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

@end
