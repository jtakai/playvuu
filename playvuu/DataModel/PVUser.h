//
//  PVUser.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/13/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//
#if !defined(_PVUSER_H)
#define _PVUSER_H

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import "PVUserData.h"
#import "PVProfile.h"
#import "PVLibrary.h"

@class PVUserData;

@interface PVUser : PFUser<PFSubclassing>

@property (retain) PVUserData *userData;
@property (retain) NSString *status;
@property (retain) PVProfile *profile;
@property (retain) PVProfile *timeline;
@property (retain) PVLibrary *library;

-(void)setEmailFields:(NSString *)email;
@end

#endif //_PVUSER_H