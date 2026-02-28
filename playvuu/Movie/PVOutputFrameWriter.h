//
//  PVCroppedMovieFrameWriter.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/30/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@protocol PVOutputFrameWriterDelegate <NSObject>

-(void)newAvailableImage:(UIImage *)image;

@end

@interface PVOutputFrameWriter : GPUImageCropFilter<GPUImageInput>
-(UIImage *)getImage;
+(PVOutputFrameWriter *)writerWithRect:(CGRect)cropRegion;
-(void)startProcessing;
@property id<PVOutputFrameWriterDelegate> delegate;

@end
