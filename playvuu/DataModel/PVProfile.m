//
//  PVProfile.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/29/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVProfile.h"

@implementation PVProfile

@dynamic bubbleConfig, projects;

+(NSString *)parseClassName{
    return @"PVProfile";
}

+(void) load{
    [PVProfile registerSubclass];
    [super load];
}

@end
