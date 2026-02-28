//
//  PVCroppedMovieFrameWriter.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/30/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVOutputFrameWriter.h"
#import <ImageIO/ImageIO.h>
#define MAX_CAP_FRAMES (30)

@interface PVOutputFrameWriter (){
    BOOL isProcessing;
    int edge; // Not in use yet.
    CMTime lastFrameTime;
    CGImageRef frames[MAX_CAP_FRAMES];
    CGSize inputSize;
    int frameCount;
}
@end

@implementation PVOutputFrameWriter

// This is here just because. I suppose it will depart soon.
+(PVOutputFrameWriter *)writerWithRect:(CGRect)cropRegion{
    return[[PVOutputFrameWriter alloc] initWithRect:cropRegion];
}

-(PVOutputFrameWriter *)initWithRect:(CGRect)cropRegion{
    // Still to process parameter region
    
    if(self = [super initWithCropRegion:CGRectMake(0, 0, 0.5f,0.5f)]){
        //[super setCropRegion:cropRegion];
    }
    
    return self;
}


-(void)reset{
    if(!isProcessing){
        for(int i = 0; i<frameCount; i++)
            CGImageRelease(frames[i]);
        frameCount = 0;
    }else
        NSLog(@"Cannot release frames while processing!!");
}

-(void)startProcessing{
    NSLog(@"Started Processing");
    if(!isProcessing){
        // Sets the Crop Region according to input size. Basically we center
        // the maximal square that fits in the frame.
        float w = inputSize.width, h = inputSize.height;
        float minEdge = MIN(w, h);
        [self setCropRegion:CGRectMake((w-minEdge)/(2*w), (h-minEdge)/(2*h) , minEdge/w, minEdge/h)];

        
        if(frameCount)
            [self reset];

        isProcessing = YES;
        lastFrameTime.value = 0;
    }
}

- (void)endProcessing{
    [super endProcessing];
    NSLog(@"endProcessing called!!");
    if(isProcessing){
        isProcessing = NO;
    }
}

-(void)setInputSize:(CGSize)newSize atIndex:(NSInteger)textureIndex{
    [super setInputSize:newSize atIndex:textureIndex];
    inputSize = newSize;
}

-(void)newFrameReadyAtTime:(CMTime)frameTime atIndex:(NSInteger)textureIndex{
    [super newFrameReadyAtTime:frameTime atIndex:textureIndex];
    
    if(isProcessing){
        if(!lastFrameTime.value)
            lastFrameTime = frameTime;
        //NSLog(@"ts = %d", frameTime.timescale);
        int time = (frameTime.value - lastFrameTime.value)/frameTime.timescale;
        
        if(time > frameCount){
            frames[frameCount++] = [self newCGImageFromCurrentlyProcessedOutput];
        }
    }
}

-(UIImage *)getImage{
    
    // Context creation for drawing the tilemap
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // The context cannot be created with 3Bpp.
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel    = 4;
    size_t bytesPerRow      = (512 * bitsPerComponent * bytesPerPixel + 7) / 8;
    
    CGContextRef tileContext = CGBitmapContextCreate(NULL, 512, 512, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaNoneSkipLast);
    
    if (tileContext == NULL)
        NSLog(@"Context not created!");
    
    CGColorSpaceRelease(colorSpace);
    int step = frameCount/4;
    for(int i = 0; i<4; i++){
        CGRect frameRect = CGRectMake((i%2)*256, (i/2)*256, 256, 256);
        CGContextDrawImage(tileContext, frameRect, frames[i*step]);
    }
    
    CGImageRef finalImage = CGBitmapContextCreateImage(tileContext);
    
    UIImage *saveImage = [UIImage imageWithCGImage:finalImage scale:1.0 orientation:UIImageOrientationUp];
    
    CGImageRelease(finalImage);
    CGContextRelease(tileContext);
    
    UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil);
    
    return saveImage;
}

@end
