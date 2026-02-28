//
//  PVUser.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/13/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVUser.h"

@implementation PVUser

@dynamic userData, status, profile, timeline, library;

-(void)setEmailFields:(NSString *)email{
    self.email = email;
    self.username = email;
    self.userData.email = email;
}

+(void)load{
    [PVUser registerSubclass];
    [super load];
}

//static PVUser *currentPVUser;
/*
+ (PVUser *)currentUser {
    // This shouldn't be necessary, but Parse is returning PFUser (not PVUser)
    // Still have to debug this issue
    if(!currentPVUser || ![[PFUser currentUser].username isEqual:currentPVUser.username]){
        PFQuery *query = [PVUser query];
        currentPVUser = (PVUser *)[query getObjectWithId:[PFUser currentUser].objectId];
    }
    
    return currentPVUser;
}*/

@end
