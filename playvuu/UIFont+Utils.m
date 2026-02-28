//
//  UIFont+Utils.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/17/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "UIFont+Utils.h"

@implementation UIFont (Utils)

+(UIFont*)proximaNovaRegularWithSize:(CGFloat)fontSize {
    return  [UIFont fontWithName:@"ProximaNova-Regular" size:fontSize];
}

+(UIFont*) proximaNovaSemiBoldFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"ProximaNova-Semibold" size:fontSize];
}

+(UIFont*) proximaNovaSemiBoldItalicFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"ProximaNova-SemiboldIt" size:fontSize];
}

+(UIFont*)proximaNovaBoldWithSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"ProximaNova-Bold" size:fontSize];
}

@end
