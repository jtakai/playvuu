//
//  PVBubbleView.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/2/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <GPUImage/GPUImage.h>
#import <Parse/Parse.h>

@interface PVBubbleView : UIView
-(void)setAtlas:(UIImage *)atlasImage;
-(void)setSlideShow:(PFFile *)slideFile;
@property (strong, nonatomic) void(^tapBlock)();
@property (nonatomic) BOOL animate;
@end
