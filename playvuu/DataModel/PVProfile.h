//
//  PVProfile.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/29/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

@interface PVProfile : PFObject <PFSubclassing>

@property (retain) NSArray *projects;   // Projects for the user.
@property (retain) NSDictionary *bubbleConfig; // Bubble world configuration for display

@end
