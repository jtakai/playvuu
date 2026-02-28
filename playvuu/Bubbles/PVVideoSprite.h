//
//  PVVideoSprite.h
//
//  Idea based on:
//
// =====================
//  JGCameraSprite.h
//  Created by Jake Gundersen on 9/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
// =====================
//
// Pablo Vasquez

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GPUImage/GPUImageTextureOutput.h>
#import <GPUImage/GPUImageMovie.h>

@interface PVVideoSprite : CCSprite <GPUImageTextureOutputDelegate,GPUImageMovieDelegate>

-(id) initWithRect:(CGRect) rect;
-(void)setMovieAtUrl:(NSURL *)movieUrl;
-(void)setSlideShow:(UIImage *)slideShow;
//-(void)stopVideo;
//-(void)resumeVideo;
//-(void)toggleVideo;
@end
