//
//  PVStatusVars.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVStatusVars.h"
#import <GPUImage/GPUImage.h>
#import "PVUser.h"

#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@implementation PVStatusVars

@synthesize sharegroup = _sharegroup;

-(id)init {
    if((self = [super init])){}
    
    return self;
}

// Aaaaah horrid thing to isolate GPUImage from Cocos2D. Y U no like each other?
+(EAGLSharegroup *) getGPUImageSharegroup{
    return [[[GPUImageContext sharedImageProcessingContext] context] sharegroup];
}

// http://cocoasamurai.blogspot.com/2011/04/singletons-your-doing-them-wrong.html
+ (PVStatusVars *)appStatus;
{
    static dispatch_once_t pred;
    static PVStatusVars *appStatus_ = nil;
    
    dispatch_once(&pred, ^{
        appStatus_ = [[[self class] alloc] init];
    });
    return appStatus_;
}

+(void)refreshUser{
    // Fetch user and library.
    [[PVUser currentUser] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(!error && object){
            NSLog(@"Fetched currentUser");
            
            [[PVUser currentUser].userData fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                NSLog(@"Fetched userData");}];
            
            PVUser *user = (PVUser *)object;
            if(!user.library)
                user.library = [PVLibrary newLibrary];
            else
                [user.library fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error)
                 { NSLog(@"fetched library: %@", error);}];
        }else
            NSLog(@"Error fetching %@: %@",object, error);
    }];
}

@end
