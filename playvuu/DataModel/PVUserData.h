//
//  PVUserData.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/13/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//
#if !defined(_PVUSERDATA_H)
#define _PVUSERDATA_H

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import "PVUser.h"

@class PVUser;

@interface PVUserData : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
+ (void)saveWithFacebookUser: (PVUser *)user;
- (PVUserData *) copy;
- (void) updateNames;

@property (retain) NSString *canonical;
@property (retain) NSString *location;
@property (retain) NSString *firstName;
@property (retain) NSString *lastName;
@property (retain) NSString *displayName;
@property (retain) NSString *email;
@property (retain) NSString *gender;
@property (retain) NSString *userName;
@property (retain) NSString *marital;
@property (retain) NSString *birthday;

@property (retain) PFFile *profilePicture;

@end
#endif // _PVUSERDATA_H