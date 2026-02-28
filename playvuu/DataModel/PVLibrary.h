//
//  PVLibrary.h
//  playvuu
//
//  Created by Pablo Vasquez on 9/1/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#if !defined(_PVLIBRARY_H)
#define _PVLIBRARY_H

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import "PVProject.h"

@interface PVLibrary : PFObject<PFSubclassing>

@property (retain) NSMutableArray *projects;
@property int projectCount;

+(void) addProject:(PVProject *)project;
+(PVLibrary *)currentLibrary;
+(PVLibrary *)newLibrary;

@end

#endif // _PVLIBRARY_Y