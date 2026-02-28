//
//  PVLikesAndCommentView.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVLikesAndCommentView.h"
#import "UIColor+Utils.h"
#import "UIFont+Utils.h"

@interface PVLikesAndCommentView()

@property (weak, nonatomic) IBOutlet UILabel *likesLabelCount;
@property (weak, nonatomic) IBOutlet UILabel *commentLabelCount;

@end

@implementation PVLikesAndCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doInit];
    }
    return self;
}


-(void) awakeFromNib {
    [super awakeFromNib];
    [self doInit];
}

-(void) doInit {
    self.likesLabelCount.font = [UIFont proximaNovaSemiBoldFontWithSize:13];
    self.likesLabelCount.textColor = [UIColor videoCellLightGrayColor];
    
    self.commentLabelCount.font = [UIFont proximaNovaSemiBoldFontWithSize:13];
    self.commentLabelCount.textColor = [UIColor videoCellLightGrayColor];
}

-(void) setupWithCommentsCount:(NSNumber*)commentsCount
                    likesCount:(NSNumber*)likesCount {
    
    self.likesLabelCount.text = [likesCount stringValue];
    self.commentLabelCount.text = [commentsCount stringValue];
    
}

-(IBAction)likeButtonPressed:(id)sender {
    if (self.likeButtonPressedBlock) {
        self.likeButtonPressedBlock();
    }
}

-(IBAction)commentButtonPressed:(id)sender {
    if (self.commentButtonPressedBlock) {
        self.commentButtonPressedBlock();
    }
}

@end
