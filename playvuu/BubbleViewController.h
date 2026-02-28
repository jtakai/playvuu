//
//  BubbleViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/1/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//
#import "cocos2d.h"

@interface BubbleViewController : UIViewController <CCDirectorDelegate>
-(int)addBubbleAtX:(float)xPos y:(float)yPos withVideo:(NSString *)video andSlideShow:(UIImage*)slideShow;
-(void)reset;
@end
