//
//  PVComposerVideoChooserCell.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/19/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVComposerVideoChooserCell.h"

@implementation PVComposerVideoChooserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self doInit];
    }
    return self;
}

-(void) doInit {
    self.page.transform = CGAffineTransformMakeRotation(M_PI_2);
}

-(void) awakeFromNib {
    [super awakeFromNib];
    [self doInit];
}

+(CGFloat) height {
    return 300;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

}

@end
