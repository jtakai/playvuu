//
//  GPUImageProtocols.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#ifndef playvuu_GPUImageProtocols_h
#define playvuu_GPUImageProtocols_h

#import <QuartzCore/QuartzCore.h>
#import <CoreMedia/CoreMedia.h>

#define GPUImageRotationSwapsWidthAndHeight(rotation) ((rotation) == kGPUImageRotateLeft || (rotation) == kGPUImageRotateRight || (rotation) == kGPUImageRotateRightFlipVertical)

typedef enum { kGPUImageNoRotation, kGPUImageRotateLeft, kGPUImageRotateRight, kGPUImageFlipVertical, kGPUImageFlipHorizonal, kGPUImageRotateRightFlipVertical, kGPUImageRotate180 } GPUImageRotationMode;

@protocol GPUImageTextureDelegate;

@protocol GPUImageInput <NSObject>
- (void)newFrameReadyAtTime:(CMTime)frameTime atIndex:(NSInteger)textureIndex;
- (void)setInputTexture:(GLuint)newInputTexture atIndex:(NSInteger)textureIndex;
- (void)setTextureDelegate:(id<GPUImageTextureDelegate>)newTextureDelegate atIndex:(NSInteger)textureIndex;
- (NSInteger)nextAvailableTextureIndex;
- (void)setInputSize:(CGSize)newSize atIndex:(NSInteger)textureIndex;
- (void)setInputRotation:(GPUImageRotationMode)newInputRotation atIndex:(NSInteger)textureIndex;
- (CGSize)maximumOutputSize;
- (void)endProcessing;
- (BOOL)shouldIgnoreUpdatesToThisTarget;
- (BOOL)enabled;
- (void)conserveMemoryForNextFrame;
- (BOOL)wantsMonochromeInput;
- (void)setCurrentlyReceivingMonochromeInput:(BOOL)newValue;
@end

@protocol GPUImageTextureDelegate <NSObject>
- (void)textureNoLongerNeededForTarget:(id<GPUImageInput>)textureTarget;
@end




#endif
