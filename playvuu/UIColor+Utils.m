//
//  UIColor+Utils.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/17/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)

+(UIColor*) videoCellDarkGrayColor {
    return [UIColor colorWithRed:55.0/255 green:55.0/255 blue:55.0/255 alpha:1];
}

+(UIColor*) videoCellLightGrayColor {
    return [UIColor colorWithRed:115.0/255 green:115.0/255 blue:115.0/255 alpha:1];
}


+(UIColor*) navigationBarBlueColor {
    return [UIColor colorWithRed:1/255.0 green:193/255.0 blue:242/255.0 alpha:1];
}

+(UIColor *) colorWithR:(int)R G:(int)G B:(int)B A:(int)A{
    return [UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:(A/255.0)];
}

@end
