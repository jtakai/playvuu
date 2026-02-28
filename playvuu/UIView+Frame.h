//
//  UIView+Frame.h
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

-(void) setFrameSize:(CGSize)size;
-(CGSize) frameSize;

-(CGPoint) frameOrigin;
-(void) setFrameOrigin:(CGPoint)origin;

-(CGFloat) frameOriginX;
-(void) setFrameOriginX:(CGFloat)x;

-(CGFloat) frameOriginY;
-(void) setFrameOriginY:(CGFloat)y;

-(CGFloat) frameWidth;
-(void) setFrameWidth:(CGFloat)width;

-(CGFloat) frameHeight;
-(void) setFrameHeight:(CGFloat)height;

@end
