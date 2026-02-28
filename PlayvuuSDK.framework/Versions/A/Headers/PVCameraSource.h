//
//  PVCameraSource.h
//  PlayvuuSDK
//
//  Created by Brian Smith on 8/14/13.
//  Copyright (c) 2013 Brian Smith. All rights reserved.
//

#import "PVSource.h"
#import "PVCommon.h"

@interface PVCameraSource : PVSource<GPUImageVideoCameraDelegate>

@property (nonatomic,assign) PlayvuuCameraPosition cameraPosition;
@property (nonatomic,readonly) NSString * captureSessionPreset;

- (void) swapCameras;

@end

