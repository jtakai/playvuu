//
//  PVVideoCell.h
//  playvuu
//
//  Created by Ariel Elkin on 02/08/2013.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class PVBubbleView;

@class PVProject;

typedef enum {
    PVLikesAndCommentType,
    PVShareType
} PVVideoCellTypes;

@interface PVVideoCell : UITableViewCell

@property (nonatomic, copy) void (^TappedCommentsBlock)(void);
@property (nonatomic, copy) void (^sharePressedBlock)(void);
@property (nonatomic, copy) void (^likeButtonPressedBlock)(void);
@property (nonatomic, copy) void (^bubbleTapBlock)(void);

-(void) setupWithProject:(PVProject*)project videoCellType:(PVVideoCellTypes)cellType;

+(CGFloat) height;

@end
