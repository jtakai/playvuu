//
//  PVEngine.h
//  PlayvuuSDK
//
//  Created by Brian Smith on 8/14/13.
//  Copyright (c) 2013 Brian Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PVCommon.h"
#import "PVSource.h"
#import "PVStage.h"

@class PVEngine;
@class PVView;
@class PVLayer;

typedef enum
{
    PlayvuuEngineStageNone = 0,
    PlayvuuEngineStageSource,
    PlayvuuEngineStagePreprocessor,
    PlayvuuEngineStagePostprocessor
    
} PlayvuuEngineStage;

@protocol PVEngineDelegate

/**
 * An error occurred in the PlayvuuEngine.  PlayvuuEngine-specific errors
 * are QEError objects.
 */
- (void) pvEngine:(PVEngine *)engine errorOccurred:(NSError *)error;

/**
 * The PlayvuuEngine will update its status as it changes.  See QECommon.h
 */
- (void) pvEngine:(PVEngine *)engine statusChanged:(PlayvuuEngineStatus)status;

/**
 * The PlayvuuEngine will update its opinion of the scene quality as the
 * incoming video feed changes.  See PVCommon.h
 */
- (void) pvEngine:(PVEngine *)engine sceneQualityChanged:(PlayvuuSceneQuality)sceneQuality;

/**
 * The detected features (Faces) has been updated
 */
- (void) pvEngine:(PVEngine *)engine detectedFeatures:(NSArray *)features;

@end

@interface PVEngine : NSObject

@property (nonatomic,weak) id<PVEngineDelegate> delegate;

@property (nonatomic,readonly) NSString * buildTimestamp;

@property (nonatomic,assign) UIInterfaceOrientation interfaceOrientation;

@property (nonatomic,readonly) PlayvuuSceneQuality sceneQuality;
@property (nonatomic,readonly) PlayvuuEngineStatus status;

@property (nonatomic,strong) PVSource * source;
@property (nonatomic,assign) PlayvuuEngineStage movieWriterStage;
@property (nonatomic,assign) float maximumVideoLength;

@property(nonatomic, copy) void(^frameCompletionBlock)(CMTime time);

@property (nonatomic,readonly) NSArray * debugData;

- (void) activate;
- (void) deactivate;

- (void) addGPUImageView:(GPUImageView *)gpuImageView forStage:(PlayvuuEngineStage)stage;
- (void) removeGPUImageView:(GPUImageView *)gpuImageView;

- (void) addGPUImageTarget:(id<GPUImageInput>)target forStage:(PlayvuuEngineStage)stage;
- (void) removeGPUImageTarget:(id<GPUImageInput>)target forStage:(PlayvuuEngineStage)stage;

- (void) addLayer:(PVLayer *)layer;
- (void) insertLayer:(PVLayer *)layer atIndex:(NSUInteger)index;

- (void) removeAllLayers;
- (void) removeLayer:(PVLayer *)layer;
- (void) removeLayerAtIndex:(NSUInteger)index;

/**
 * Start recording the current video stream to disk.  The recording is currently
 * unlimited but will be capped at 30 seconds in the near future.  The completion
 * handler will be called after the write operation completes with the URL to
 * the video.  The Video will be in the TEMP area of the application, so you
 * must move/copy/delete the video at this point.
 
 */
- (void) startRecordingWithCompletionHandler:(void (^)(NSURL * url, NSError * error))handler;

/**
 * Stop recording the current video stream and write it to disk.
 */
- (void) saveRecording;

/**
 * Stop the recording and discard it.
 */
- (void) cancelRecording;

/**
 * When enabled, PVEngine will detect Facial features.
 */
@property (nonatomic,assign) BOOL featureDetectionEnabled;

/**
 * An array of CIFeature objects of the currently detected features in the
 * video stream (currently CIFaceFeature objects)
 */
@property (atomic,copy,readonly) NSArray * features;




@end
