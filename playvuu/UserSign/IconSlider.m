//
//  IconSlider.m
//  playvuu
//
//  Created by Pablo Vasquez on 7/25/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "IconSlider.h"

@interface IconSlider()

@property (strong, nonatomic, readwrite) NSString *imageName;

@end


@implementation IconSlider

/* hardcoded value for now*/
static const float threshold = 0.8;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)isSwiped
{
    return [self value] >= threshold;
}

- (void) reset
{
    [self setValue:0 animated:YES];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if([self value] < threshold)
        [self reset];
    else
        [self sendActionsForControlEvents: UIControlEventValueChanged];
}

- (void) awakeFromNib
{
    UIImage *clearImage = [[UIImage alloc] init];
    [self setMinimumTrackImage:clearImage forState:UIControlStateNormal];
    [self setMaximumTrackImage:clearImage forState:UIControlStateNormal];
    [self setThumbImage:[UIImage imageNamed:self.imageName] forState:UIControlStateNormal];
    [self setContinuous:NO];
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
