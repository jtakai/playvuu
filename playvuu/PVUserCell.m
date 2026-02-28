//
//  PVUserCell.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/13/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVUserCell.h"
#import "PVBubbleView.h"

@implementation PVUserCell


UILabel *nameLabel;
UILabel *locationLabel;
UILabel *projectCountLabel;
UILabel *statusLabel;
UIButton *followButton;
PFImageView *pictureView;



-(void)setCellData:(PVUserData *)cellData{
    _cellData = cellData;
    nameLabel.text = _cellData.displayName;
    locationLabel.text = _cellData.location;
    //statusLabel.text = _cellData.status;
    pictureView.file = _cellData.profilePicture;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        
        // Picture
        PFImageView *pictureView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        pictureView.image = [UIImage imageNamed:@"cam.png"];
        [pictureView setCenter:CGPointMake(10 + pictureView.frame.size.width/2,
                                                       25 + self.frame.size.height/2)];
        [self.contentView addSubview:pictureView];
        [pictureView loadInBackground];
        
        int textXOffset = pictureView.frame.size.width + 25;
        
        //Name
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(textXOffset, 0, 200, 50)];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:17]];
        [self.contentView addSubview:nameLabel];
        
        // Location
        locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 20, 200, 50)];
        [locationLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
        [locationLabel setTextAlignment:NSTextAlignmentLeft];
        [locationLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:locationLabel];
        
        // Location
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationLabel.frame.origin.x, locationLabel.frame.origin.y + 20, 200, 50)];
        [statusLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
        [statusLabel setTextAlignment:NSTextAlignmentLeft];
        [statusLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:statusLabel];
        
        int buttonsXOffset = self.frame.size.width - 55;
        
        //Like Button:
        UIButton *followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [followButton setCenter:CGPointMake(buttonsXOffset, 23)];
        [followButton setTitle:@"Follow" forState:UIControlStateNormal];
        [followButton addTarget:self action:@selector(followButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:followButton];
        
        //Likes count:
        projectCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(followButton.frame.origin.x + followButton.frame.size.width + 5, followButton.frame.origin.y-8, 50, 50)];
        [projectCountLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
        [projectCountLabel setTextAlignment:NSTextAlignmentLeft];
        [projectCountLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:projectCountLabel];
    }
    return self;
}

-(void)followButtonPressed{
    NSLog(@"Pressed follow button for %@", nameLabel.text);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
