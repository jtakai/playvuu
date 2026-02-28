//
//  UIView+Frame.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void) setFrameSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGSize) frameSize
{
    return self.frame.size;
}

-(CGPoint) frameOrigin
{
    return self.frame.origin;
}

-(void) setFrameOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGFloat) frameOriginX
{
    return self.frame.origin.x;
}
-(void) setFrameOriginX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat) frameOriginY
{
    return self.frame.origin.y;
}
-(void) setFrameOriginY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


-(CGFloat) frameWidth
{
    return CGRectGetWidth(self.frame);
}

-(void) setFrameWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat) frameHeight
{
    return CGRectGetHeight(self.frame);
}

-(void) setFrameHeight:(CGFloat)height;
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
