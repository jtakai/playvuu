//
//  PVGridCell.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/17/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVGridCell.h"
#import "PVBubbleView.h"

@interface PVGridCell (){
    
}
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet PVBubbleView *slideView;
@end


@implementation PVGridCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib{
    self.titleLable.font = [UIFont proximaNovaSemiBoldFontWithSize:13];
    self.titleLable.textColor = [UIColor videoCellDarkGrayColor];
    self.infoLabel.font = [UIFont proximaNovaSemiBoldFontWithSize:10];
    self.infoLabel.textColor = [UIColor videoCellLightGrayColor];
}


-(void) setupWithProject:(PVProject*)project infoKey:(NSString *)infoKey{
    
    self.titleLable.text = project.title;
    self.infoLabel.text = [project objectForKey:infoKey];
    [self.slideView setSlideShow:project.slideTexture];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
