//
//  PVVideoCell.m
//  playvuu
//
//  Created by Ariel Elkin on 02/08/2013.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVVideoCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PVBubbleView.h"
#import "PVProject.h"
#import "PVLikesAndCommentView.h"
#import "PVShareAccessoryView.h"
#import "UIFont+Utils.h"
#import "UIColor+Utils.h"

@interface PVVideoCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIView *rightContainerView;
@property (strong, nonatomic) IBOutlet PVBubbleView *slideView;
@end

@implementation PVVideoCell

-(void) awakeFromNib {
    [super awakeFromNib];
    [self doInit];
}

-(void) doInit {
    self.titleLabel.font = [UIFont proximaNovaSemiBoldFontWithSize:13];
    self.titleLabel.textColor = [UIColor videoCellDarkGrayColor];

    self.subtitleLabel.font = [UIFont proximaNovaSemiBoldFontWithSize:10];
    self.subtitleLabel.textColor = [UIColor videoCellLightGrayColor];
    
    [self.contentView setUserInteractionEnabled: NO];
}

-(void)setSlideShow:(PFFile *)slideFile{
    [slideFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error)
            [_slideView setAtlas:[[UIImage alloc] initWithData:data]];
        else
            NSLog(@"Couldn't fetch data: %@", error);
    }];
}

-(void) setupWithProject:(PVProject*)project videoCellType:(PVVideoCellTypes)cellType {
    
    self.titleLabel.text = project.title;
    self.subtitleLabel.text = project.authorName;
    self.slideView.tapBlock = self.bubbleTapBlock;
    [self setSlideShow:project.slideTexture];
    
    
    switch (cellType) {
        case PVLikesAndCommentType:
            [self configureForLikesAndCommentsTypeWithProject:project];
            break;
        case PVShareType:
            [self configureForShareTypeWithProject:project];
            break;
        default:
            ASSERT(NO);
            break;
    }
}


-(void) configureForLikesAndCommentsTypeWithProject:(PVProject*)project {
    
    // TODO:
    // Setup button actions;
    PVLikesAndCommentView *likesAndCommentsView = [[NSBundle mainBundle] loadFirstNibNamedWithNoOwner:[PVLikesAndCommentView class]];
    ASSERT(likesAndCommentsView);
    
    [likesAndCommentsView setupWithCommentsCount:[NSNumber numberWithInt: (arc4random() % 300)]
                                      likesCount:[NSNumber numberWithInt: (arc4random() % 300)]];
    
    likesAndCommentsView.likeButtonPressedBlock = self.likeButtonPressedBlock;
    likesAndCommentsView.commentButtonPressedBlock = self.TappedCommentsBlock;
    
    [self.rightContainerView removeAllSubviews];
    [self.rightContainerView addSubview:likesAndCommentsView];
}

-(void) configureForShareTypeWithProject:(PVProject*)project {
    
    // TODO: Setup button actions;
    PVShareAccessoryView *accessoryView = [[NSBundle mainBundle] loadFirstNibNamedWithNoOwner:[PVShareAccessoryView class]];
    ASSERT(accessoryView);

    accessoryView.sharePressedBlock = self.sharePressedBlock;
    [accessoryView setupWithDate:[project createdAt]];
    
    [self.rightContainerView removeAllSubviews];
    [self.rightContainerView addSubview:accessoryView];
}

+(CGFloat) height {
    return 77;
}
@end
