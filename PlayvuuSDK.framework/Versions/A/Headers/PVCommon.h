//
//  PVCommon.h
//  PlayvuuSDK
//
//  Created by Brian Smith on 8/14/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#ifndef PlayvuuSDK_PVCommon_h
#define PlayvuuSDK_PVCommon_h

#import <AVFoundation/AVFoundation.h>

//
// The video size to use when processing and recording.
//
typedef enum
{
    PlayvuuOutputSizePresetDefault = 0,
    PlayvuuOutputSizePreset352x288,
    PlayvuuOutputSizePreset640x480,
    PlayvuuOutputSizePreset1000x562,
    PlayvuuOutputSizePreset1280x720,
    PlayvuuOutputSizePreset1920x1080
    
} PlayvuuOutputSizePreset;

//
// The camera position (front / back
//
typedef enum
{
    PlayvuuCameraPositionUnspecified = AVCaptureDevicePositionUnspecified,
    PlayvuuCameraPositionBack = AVCaptureDevicePositionBack,
    PlayvuuCameraPositionFront = AVCaptureDevicePositionFront
    
} PlayvuuCameraPosition;

//
// PlayvuuEngineStatus is the overall status of the PlayvuuEngine
//

#define PLAYVUUENGINE_STATUS_ACTIVE 1 << 8
#define PLAYVUUENGINE_STATUS_INACTIVE 1 << 9

typedef enum
{
    //
    // PlayvuuEngineStatusInactive
    // Engine not currently running and video is being processed.  This
    // may be due to not yet calling "start", calling "stop", or if
    // an internal error occurred.
    //
    PlayvuuEngineStatusInactive = 1 | PLAYVUUENGINE_STATUS_INACTIVE,
    
    //
    // PlayvuuEngineStatusActive
    // Engine is currently processing video and determining the advice level
    //
    PlayvuuEngineStatusActive = 1 | PLAYVUUENGINE_STATUS_ACTIVE,
    
    //
    // PlayvuuEngineStatusRecordingVideo
    // Engine is recording video.
    //
    PlayvuuEngineStatusRecordingVideo = 2 | PLAYVUUENGINE_STATUS_ACTIVE,
    
    //
    // PlayvuuEngineStatusFinishingVideo
    // Engine is saving the video to a temporary area.  After this state
    // completes, the engine transitions back to the Active state.
    //
    PlayvuuEngineStatusFinishingVideo = 3 | PLAYVUUENGINE_STATUS_ACTIVE,
    
} PlayvuuEngineStatus;

//
// PlayvuuSceneQuality advises the host application if the PlayvuuEngine
// has determined if the video is of sufficient quality to start recording.
//
typedef enum
{
    //
    // The None quality is set when the engine isn't active.
    //
    PlayvuuSceneQualityNone = 0,
    
    //
    // The Poor quality indicates that the scene quality is below the
    // desired quality
    //
    PlayvuuSceneQualityPoor,
    
    //
    // The Fair quality indicates that the scene quality is acceptable
    //
    PlayvuuSceneQualityFair,
    
    //
    // The Good quality indicates that the scene quality is excellent
    //
    PlayvuuSceneQualityGood
    
} PlayvuuSceneQuality;

/*
 * converts the 
 */
NSString * playvuuCameraPositionToString(PlayvuuCameraPosition position);
NSString * playvuuEngineStatusToString(PlayvuuEngineStatus status);
NSString * playvuuSceneQualityToString(PlayvuuSceneQuality quality);

#endif
