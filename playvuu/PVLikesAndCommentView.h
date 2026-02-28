//
//  PVLikesAndCommentView.h
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PVLikesAndCommentView : UIView

@property (nonatomic, copy) void (^likeButtonPressedBlock)(void);
@property (nonatomic, copy) void (^commentButtonPressedBlock)(void);

-(void) setupWithCommentsCount:(NSNumber*)commentsCount
                    likesCount:(NSNumber*)likesCount;


-(IBAction)likeButtonPressed:(id)sender;
-(IBAction)commentButtonPressed:(id)sender;

@end
