//
//  PVStage.h
//  PlayvuuSDK
//
//  Created by Brian Smith on 8/14/13.
//  Copyright (c) 2013 Brian Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

#import <GPUImage/GPUImage.h>

@class PVStage;

@protocol PVStageDelegate

- (void) pvStage:(PVStage *)stage errorOccurred:(NSError *)error;
- (void) pvStage:(PVStage *)stage frameFinishedWithTime:(CMTime)time;

@end


@interface PVStage : NSObject


@property (nonatomic,weak) id<PVStageDelegate> delegate;

@property (nonatomic,strong,readonly) GPUImageOutput<GPUImageInput> * input;
@property (nonatomic,strong,readonly) GPUImageOutput * output;
@property (nonatomic,readonly) NSArray * debugData;

@end
