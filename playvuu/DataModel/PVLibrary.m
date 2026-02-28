//
//  PVLibrary.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/1/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVLibrary.h"
#import "PVUser.h"
#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@implementation PVLibrary

@dynamic projects, projectCount; // Probably more than just projects.

+(void) load{
    [PVLibrary registerSubclass];
    [super load];
}

+(PVLibrary *)newLibrary{
    PVLibrary * newLibrary = [PVLibrary new];
    newLibrary.projects = [NSMutableArray arrayWithCapacity:0];
    newLibrary.projectCount = 0;
    [newLibrary saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded)
            NSLog(@"New Library created");
        else
            NSLog(@"Library creation error: %@", error);
    }];
    return newLibrary;
}

+(PVLibrary *)currentLibrary{
    return [PVUser currentUser].library;
}

+(void)addProject:(PVProject *)project{
    PVLibrary *current =[PVLibrary currentLibrary];
    
    [current.projects addObject:project];
    current.projectCount+=1;
}

+(NSString *)parseClassName{
    return @"PVLibrary";
}

@end
