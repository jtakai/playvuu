//
//  PVInbox.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/1/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVInbox.h"

@implementation PVInbox

+(NSString *)parseClassName{
    return @"PVInbox";
}


+(void) load{
    [PVInbox registerSubclass];
    [super load];
}
@end
