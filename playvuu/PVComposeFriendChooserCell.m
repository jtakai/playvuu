//
//  PVComposeFriendChooserCell.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/18/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVComposeFriendChooserCell.h"
#import "PVComposeFriendViewModel.h"

@interface PVComposeFriendChooserCell()
@property (weak, nonatomic) IBOutlet UIImageView *selectionImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *addRemoveLabel;

@end

@implementation PVComposeFriendChooserCell
static const NSArray *names;
static int counter;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self doInit];
    }
    return self;
}

+(void)initialize{
    names = @[ @"Shane Pollack", @"Joe Takai", @"Alejandro Japkin", @"Pablo Vasquez", @"Nicolas Miyasato", @"Brian Smith", @"Jesse Worthington"];
}

-(void) awakeFromNib {
    [super awakeFromNib];
    [self doInit];
}

-(void) doInit {
    self.name.font = [UIFont proximaNovaRegularWithSize:14];
    self.addRemoveLabel.font = [UIFont proximaNovaRegularWithSize:30];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        self.selectionImage.image = [UIImage imageNamed:@"chosencomposer_socializer_button"];
        self.addRemoveLabel.text = @"-";
        
    } else {
        self.selectionImage.image = [UIImage imageNamed:@"unchosencomposer_socializer_button"];
        self.addRemoveLabel.text = @"+";
        
    }
}


-(void) setupWithModel:(PVComposeFriendViewModel*)model {
//     self.name.text = model.name;
    self.name.text = [names objectAtIndex:(counter++%names.count)];
}


+(CGFloat) height {
    return 44;
}

@end
