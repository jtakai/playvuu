//
//  PVShareAccessoryView.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVShareAccessoryView.h"

@interface PVShareAccessoryView()

@property (weak, nonatomic) IBOutlet UILabel *dateString;


@end


@implementation PVShareAccessoryView

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
    self.dateString.font = [UIFont proximaNovaSemiBoldItalicFontWithSize:10];
    self.dateString.textColor = [UIColor videoCellLightGrayColor];
}

-(void) setupWithDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    self.dateString.text = [dateFormatter stringFromDate:date];
}

-(IBAction) shareButtonPressed:(UIButton*)button {
    if (self.sharePressedBlock) {
        self.sharePressedBlock();
    }
}

@end
