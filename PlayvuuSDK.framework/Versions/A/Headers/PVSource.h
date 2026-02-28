//
//  PVSource.h
//  PlayvuuSDK
//
//  Created by Brian Smith on 8/14/13.
//  Copyright (c) 2013 Brian Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

#import "PVCommon.h"

@class PVSource;

typedef enum
{
    PlayvuuSourceStatusInactive,
    PlayvuuSourceStatusActive
    
} PlayvuuSourceStatus;

@protocol PVSourceDelegate

- (void) pvSource:(PVSource *)pvSource errorOccurred:(NSError *)error;
- (void) pvSource:(PVSource *)pvSource willOutputPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end

@interface PVSource : NSObject

@property (nonatomic,weak) id<PVSourceDelegate> delegate;
@property (nonatomic,readonly) GPUImageOutput * output;

@property (nonatomic,assign) UIInterfaceOrientation interfaceOrientation;

@property (nonatomic,readonly) PlayvuuSourceStatus status;
@property (nonatomic,readonly) PlayvuuSceneQuality sceneQuality;

@property (nonatomic,assign) PlayvuuOutputSizePreset outputSizePreset;
@property (nonatomic,readonly) CGSize outputSize;
@property (nonatomic,readonly) CGSize inputSize;

@property(readwrite, nonatomic, retain) GPUImageMovieWriter * audioEncodingTarget;

@property (nonatomic,readonly) NSArray * debugData;

- (void) initialize;
- (void) activate;
- (void) deactivate;

@end
