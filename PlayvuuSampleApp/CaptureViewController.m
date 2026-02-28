//
//  CaptureViewController.m
//  PlayvuuSampleApp
//
//  Created by Brian Smith on 6/29/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

#import "CaptureViewController.h"

@interface CaptureViewController ()
{
    CGSize _portraitSize;
    BOOL isRecording;
}

- (void) updateDebugLabel;

@end

@implementation CaptureViewController

- (void)viewDidLoad
{
    [GPUImageView class];
    
    self.navigationItem.title = @"Camera";
    
    _portraitSize = self.view.bounds.size;
    
    _featureViews = [[NSMutableArray alloc] initWithCapacity:10];
    _debugLabel.hidden = YES;
    
    [super viewDidLoad];    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self rotateOutputViewToInterfaceOrientation:self.interfaceOrientation duration:0];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self setupPlayvuuEngine];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_playvuuEngine deactivate];
    _playvuuEngine = nil;
    
    _savedVideoURL = nil;
    _featureViews = nil;
}

- (BOOL) shouldAutorotate
{
    return _playvuuEngine.status != PlayvuuEngineStatusRecordingVideo;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self rotateOutputViewToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

}

- (void) rotateOutputViewToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGSize viewSize = _portraitSize;
    
    //
    // we are changing to landscape, so swap the width/height
    //
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
        viewSize = CGSizeMake(viewSize.height, viewSize.width);
    
    CGRect outputViewFrame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            transform = CGAffineTransformMakeRotation(M_PI);
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            transform = CGAffineTransformMakeRotation(M_PI / 2.f);
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            transform = CGAffineTransformMakeRotation(- M_PI / 2.f);
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        self.outputView.transform = transform;
        self.outputView.frame = outputViewFrame;
        
    }];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    _playvuuEngine.interfaceOrientation = self.interfaceOrientation;
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
}

#if 0
- (UIResponder *) nextResponder
{
    if (_outputView)
        return _outputView;
    else
        return [super nextResponder];
}
#endif

- (void) setupPlayvuuEngine
{
    //
    // create the PlayvuueEngine source : a camera
    //
    PVCameraSource * cameraSource = [[PVCameraSource alloc] init];
    cameraSource.cameraPosition = PlayvuuCameraPositionBack;
    cameraSource.outputSizePreset = PlayvuuOutputSizePreset1000x562;
    
    //
    // create the playvuu engine and set its parameters
    //
    _playvuuEngine = [[PVEngine alloc] init];
    _playvuuEngine.delegate = self;
    _playvuuEngine.interfaceOrientation = self.interfaceOrientation;
    _playvuuEngine.source = cameraSource;
    
    //
    // We have a GPUImageView in the NIB, so we just add that as the output of the Preprocessor stage
    // of the engine.
    //
    [_playvuuEngine addGPUImageView:_outputView forStage:PlayvuuEngineStagePostprocessor];
    
    //
    // we plan to record the preprocessor output
    //
    _playvuuEngine.movieWriterStage = PlayvuuEngineStagePreprocessor;
    
    __unsafe_unretained CaptureViewController * self_ = self;
    [_playvuuEngine setFrameCompletionBlock:^(CMTime time) {
        
        [self_ updateDebugLabel];
        
    }];
    
    [_playvuuEngine activate];

}

- (IBAction)buttonTouched:(id)sender
{
    if (sender == _recordButton)
    {
        if (_recordButton.tag == 0)
        {
            _recordButton.tag = 1;
            [_recordButton setTitle:@"Stop/Save" forState:UIControlStateNormal];

            [self startRecording];
        }
        else if (_recordButton.tag == 1)
        {
            _recordButton.enabled = NO;
            [_recordButton setTitle:@"Saving..." forState:UIControlStateNormal];

            [self saveRecording];
        }
    }
    
    else if (sender == _swapCameraButton)
    {
        if ([_playvuuEngine.source isKindOfClass:[PVCameraSource class]])
        {
            PVCameraSource * camera = (PVCameraSource *)_playvuuEngine.source;
            [camera swapCameras];
        }
    }
}

- (IBAction) switchToggled:(id)sender
{
    if (sender == _toggleDebugSwitch)
    {
        _debugLabel.hidden = !_toggleDebugSwitch.on;
    }
    else if (sender == _toggleFacesSwitch)
    {
        _playvuuEngine.featureDetectionEnabled = _toggleFacesSwitch.on;
        
        if (!_playvuuEngine.featureDetectionEnabled)
        {            
            //
            // clear the feature views
            //
            for (int i = 0; i < [_featureViews count]; i++)
            {
                UIView * v = [_featureViews objectAtIndex:i];
                [v removeFromSuperview];
            }
            
            [_featureViews removeAllObjects];
        }
    }
    else if (sender == _toggleFilterLayerSwitch)
    {
        if (_toggleFilterLayerSwitch.on && !_filterLayer)
        {
            _filterLayer = [PVLayer newLayerFromName:@"pvgrayscalelayer"];
            [_playvuuEngine addLayer:_filterLayer];
        }
        else if (!_toggleFilterLayerSwitch.on && _filterLayer)
        {
            [_playvuuEngine removeLayer:_filterLayer];
            _filterLayer = nil;
        }
    }
    else if (sender == _toggleOverlayLayerSwitch)
    {
        if (_toggleOverlayLayerSwitch.on && !_overlayLayer)
        {
            _overlayLayer = [PVLayer newLayerFromName:@"pvoverlaylayer"];
            _overlayLayer.parameters = @{@"picture": [[NSBundle mainBundle] URLForResource:@"skyline.png" withExtension:nil]};
            
            [_playvuuEngine addLayer:_overlayLayer];
        }
        else if (!_toggleOverlayLayerSwitch.on && _overlayLayer)
        {
            [_playvuuEngine removeLayer:_overlayLayer];
            
            _overlayLayer = nil;
        }
    }
}

- (void) updateDebugLabel
{
    if (!_debugLabel.hidden)        
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSArray * debugArray = _playvuuEngine.debugData;
            _debugLabel.numberOfLines = [debugArray count] + 2;
            
            _debugLabel.text = [[debugArray componentsJoinedByString:@"\n"] stringByAppendingFormat:@"\n\nengBuild: %@", _playvuuEngine.buildTimestamp];
            
        });
    }

}

- (void) startRecording
{
    [_playvuuEngine startRecordingWithCompletionHandler:^(NSURL *url, NSError *error) {

        if (!error)
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            NSString *documentsPath = [paths objectAtIndex:0];
            NSString *filePath = [documentsPath stringByAppendingPathComponent:url.lastPathComponent];
            
            [[NSFileManager defaultManager] moveItemAtPath:url.path toPath:filePath error:&error];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertView * alert = nil;
            
            if (error) {
                alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription]
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            } else {
                alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Now you can watch it again by going to 'Playback' in the main menu."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            }
            
            [alert show];
            
            if(_recordButton){
                _recordButton.tag = 0;
                _recordButton.enabled = YES;
                [_recordButton setTitle:@"Record" forState:UIControlStateNormal];
            }
            isRecording = NO;
        });
                
    }];     
}

- (void) saveRecording
{
    [_playvuuEngine saveRecording];
}

#pragma mark PVEngineDelegate methods

- (void) pvEngine:(PVEngine *)engine errorOccurred:(NSError *)error
{
    NSLog(@"PVEngine errorOccurred : %@", [error localizedDescription]);
}

- (void) pvEngine:(PVEngine *)engine statusChanged:(PlayvuuEngineStatus)status
{
    switch (status) {
        case PlayvuuEngineStatusInactive:
            self.recordButton.enabled = NO;
            self.statusLabel.text = @"Inactive";
            break;
            
        case PlayvuuEngineStatusActive:
            self.recordButton.enabled = YES;
            self.statusLabel.text = @"Active";
            break;
            
        case PlayvuuEngineStatusRecordingVideo:
            self.recordButton.enabled = YES;
            self.statusLabel.text = @"Recording";
            break;
            
        case PlayvuuEngineStatusFinishingVideo:
            self.recordButton.enabled = NO;
            self.statusLabel.text = @"Saving";
            break;

        default:
            break;
    }
}

- (void) pvEngine:(PVEngine *)engine sceneQualityChanged:(PlayvuuSceneQuality)sceneQuality
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.adviceImageView.hidden = sceneQuality == PlayvuuSceneQualityNone;
        
        switch (sceneQuality) {
                
            case PlayvuuSceneQualityPoor:
                self.adviceImageView.image = [UIImage imageNamed:@"red.png"];
                break;
                
            case PlayvuuSceneQualityFair:
                self.adviceImageView.image = [UIImage imageNamed:@"yellow.png"];
                break;
                
            case PlayvuuSceneQualityGood:
                self.adviceImageView.image = [UIImage imageNamed:@"green.png"];
                break;
                
            default:
                break;
        }
        
    });

}

CGRect convertFeatureRect(CGRect featureRect, float scale, CGRect videoRect, BOOL isMirrored)
{
    featureRect = CGRectMake(featureRect.origin.y * scale,
                             featureRect.origin.x * scale,
                             featureRect.size.height * scale,
                             featureRect.size.width * scale);
    
    if (isMirrored)
        featureRect = CGRectOffset(featureRect, videoRect.origin.x + videoRect.size.width - featureRect.size.width - (featureRect.origin.x * 2), videoRect.origin.y);
    else
        featureRect = CGRectOffset(featureRect, videoRect.origin.x, videoRect.origin.y);
    
    return featureRect;
}


- (void) pvEngine:(PVEngine *)engine detectedFeatures:(NSArray *)features
{
    //
    //
    // IMPORTANT!  THESE ARE OLD NOTES !! The GPUImageView (was QEView) is not
    // attached to the window anymore...so we are needing to figure that out.  Soon.
    //
    //
    // here we draw some bounding boxes for the detected features.  It's a little overly
    // complicated right now since the QEView is attached to the window (not this
    // UIViewController), so regardless of this VC's orientation, the QE is always in
    // portrait mode.  Furthermore, the VIDEO & the feature rects are based in a landscape
    // coordinate system, so we have to map all the coordinates properly (see below)
    //
    
    //
    // this delegate may be called from another thread, so we have to dispatch back to
    // the main queue here since we're dealing with UI bits.
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        //
        // we want to reuse the UIViews that are marking facial features, so first we
        // remove any excess UIViews if the number of features we now have are less
        // than the number previously used.
        //
        if ([features count] < [_featureViews count])
        {
            for (int i = [features count]; i < [_featureViews count]; i++)
            {
                UIView * v = [_featureViews objectAtIndex:i];
                [v removeFromSuperview];
            }

            [_featureViews removeObjectsInRange:NSMakeRange([features count], [_featureViews count] - [features count])];
        }
        
        //
        // now determine the video size & rectangle that is actually being displayed.  Remember,
        // the videostream is landscape oriented, so self.outputView.cameraVideoSize contains landscape
        // dimensions.  And QEView's bounds (self.outputView.bounds) are locked to portrait (as
        // a subview of the window, not the UIViewController).
        //
        // That means we calculate the videoRect (the actual displayed video rect) based on a size
        // which swaps the width/height of video (self.outputView.videoSize)
        //
        // FYI we move everything into the portrait coordinate system (rather than landscape) since
        // we'll be drawing views in portrait mode (the orientation of the self.outputView).  The
        // features are based on the landscape orientation of the video stream
        //

        BOOL isMirrored = NO;
        
        if ([_playvuuEngine.source isKindOfClass:[PVCameraSource class]])
        {
            PVCameraSource * cameraSource = (PVCameraSource *)_playvuuEngine.source;
            isMirrored = cameraSource.cameraPosition == PlayvuuCameraPositionFront;
        }
        
        CGSize videoSize = _playvuuEngine.source.inputSize;
        videoSize = CGSizeMake(videoSize.height, videoSize.width);
        
        CGRect viewBounds = self.outputView.bounds;
        CGRect videoRect = AVMakeRectWithAspectRatioInsideRect(videoSize, viewBounds);
        
        float scale = videoRect.size.width / videoSize.width;
        
        [features enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            UIView * featureView = nil;
            UIView * faceView = nil;
            UIView * leftEyeView = nil;
            UIView * rightEyeView = nil;
            UIView * mouthView = nil;
            
            if (idx < [_featureViews count])
            {
                featureView = [_featureViews objectAtIndex:idx];
                faceView = [[featureView subviews] objectAtIndex:0];
                leftEyeView = [[featureView subviews] objectAtIndex:1];
                rightEyeView = [[featureView subviews] objectAtIndex:2];
                mouthView = [[featureView subviews] objectAtIndex:3];
            }
            else
            {
                featureView = [[UIView alloc] initWithFrame:CGRectZero];
                featureView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.1f];
                [_featureViews addObject:featureView];
                [self.outputView addSubview:featureView];
                
                CGRect defaultRect = CGRectMake(0, 0, 50, 50);
                
                faceView = [[UIView alloc] initWithFrame:defaultRect];
                faceView.backgroundColor = [UIColor clearColor];
                faceView.layer.cornerRadius = 4.f;
                faceView.layer.borderWidth = 2.f;
                faceView.layer.borderColor = [UIColor redColor].CGColor;
                
                leftEyeView = [[UIView alloc] initWithFrame:defaultRect];
                leftEyeView.backgroundColor = [UIColor clearColor];
                leftEyeView.layer.cornerRadius = 4.f;
                leftEyeView.layer.borderWidth = 2.f;
                leftEyeView.layer.borderColor = [UIColor greenColor].CGColor;

                rightEyeView = [[UIView alloc] initWithFrame:defaultRect];
                rightEyeView.backgroundColor = [UIColor clearColor];
                rightEyeView.layer.cornerRadius = 4.f;
                rightEyeView.layer.borderWidth = 2.f;
                rightEyeView.layer.borderColor = [UIColor yellowColor].CGColor;
                
                mouthView =  [[UIView alloc] initWithFrame:defaultRect];
                mouthView.backgroundColor = [UIColor clearColor];
                mouthView.layer.cornerRadius = 4.f;
                mouthView.layer.borderWidth = 2.f;
                mouthView.layer.borderColor = [UIColor blueColor].CGColor;
                
                [featureView addSubview:faceView];
                [featureView addSubview:leftEyeView];
                [featureView addSubview:rightEyeView];
                [featureView addSubview:mouthView];
                
                [@[faceView, leftEyeView, rightEyeView, mouthView] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                  
                    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(2, defaultRect.size.height - 10, defaultRect.size.width, 10)];
                    label.text = [@[@"FACE", @"LE", @"RE", @"M"] objectAtIndex:idx];
                    label.font = [UIFont systemFontOfSize:8.f];
                    label.textColor = [UIColor whiteColor];
                    label.textAlignment = NSTextAlignmentLeft;
                    label.shadowColor = [UIColor blackColor];
                    label.shadowOffset = CGSizeMake(1, 1);
                    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
                    label.backgroundColor = [UIColor clearColor];
                    [obj addSubview:label];
                    
                }];
                

            }
            
            CIFeature * feature = obj;
            featureView.frame = convertFeatureRect(feature.bounds, scale, videoRect, isMirrored);

            faceView.frame = [featureView convertRect:featureView.frame fromView:self.outputView];;
            
            
            if ([feature isKindOfClass:[CIFaceFeature class]])
            {
                CIFaceFeature * face = (CIFaceFeature *)feature;
                
                CGSize subfeatureSize = CGSizeMake(feature.bounds.size.width * 0.25f, feature.bounds.size.height * 0.25f);
                CGPoint subfeatureOffset = CGPointMake(-subfeatureSize.width / 2.f, -subfeatureSize.height / 2.f);
                
                {
                    leftEyeView.hidden = face.hasLeftEyePosition == NO;
                    leftEyeView.frame = convertFeatureRect(CGRectMake(face.leftEyePosition.x + subfeatureOffset.x,
                                                                      face.leftEyePosition.y + subfeatureOffset.y,
                                                                      subfeatureSize.width, subfeatureSize.height),
                                                           scale, videoRect, isMirrored);
                    leftEyeView.frame = [featureView convertRect:leftEyeView.frame fromView:self.outputView];
                }
                {
                    rightEyeView.hidden = face.hasRightEyePosition == NO;
                    rightEyeView.frame = convertFeatureRect(CGRectMake(face.rightEyePosition.x + subfeatureOffset.x,
                                                                      face.rightEyePosition.y + subfeatureOffset.y,
                                                                      subfeatureSize.width, subfeatureSize.height),
                                                           scale, videoRect, isMirrored);
                    rightEyeView.frame = [featureView convertRect:rightEyeView.frame fromView:self.outputView];
                }
                {
                    mouthView.hidden = face.hasMouthPosition == NO;
                    mouthView.frame = convertFeatureRect(CGRectMake(face.mouthPosition.x + subfeatureOffset.x,
                                                                       face.mouthPosition.y + subfeatureOffset.y,
                                                                       subfeatureSize.width, subfeatureSize.height),
                                                            scale, videoRect, isMirrored);
                    mouthView.frame = [featureView convertRect:mouthView.frame fromView:self.outputView];   
                }
            }
            
            CGAffineTransform xform = CGAffineTransformIdentity;
            
            switch (self.interfaceOrientation) {
                case UIInterfaceOrientationPortrait:
                    xform = CGAffineTransformMakeRotation(0.f);
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                    xform = CGAffineTransformMakeRotation(M_PI);
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                    xform = CGAffineTransformMakeRotation(-M_PI / 2.f);
                    break;
                case UIInterfaceOrientationLandscapeRight:
                    xform = CGAffineTransformMakeRotation(M_PI / 2.f);
                    break;
                default:
                    break; // leave the layer in its last known orientation
            }
            
            faceView.transform = xform;
            leftEyeView.transform = xform;
            rightEyeView.transform = xform;
            mouthView.transform = xform;

        }];
        
    }); // dispatch_async
}

#pragma mark UIAlertViewDelegate method

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
}


- (IBAction)swapCamera:(UIBarButtonItem *)sender {
        if ([_playvuuEngine.source isKindOfClass:[PVCameraSource class]])
        {
            PVCameraSource * camera = (PVCameraSource *)_playvuuEngine.source;
            [camera swapCameras];
        }
}

- (IBAction)toggleRecord:(UIBarButtonItem *)sender {
    if(!isRecording){
        isRecording = YES;
        [sender setTitle:@"Stop"];
        [self startRecording];
    }else{
        [sender setTitle:@"Record"];
        [self saveRecording];
    }
}
@end
