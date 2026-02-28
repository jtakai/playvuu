//
//  PVStatusVars.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>

@interface PVStatusVars : NSObject

@property (strong, readonly) EAGLSharegroup *sharegroup;

+(PVStatusVars *)appStatus;
+(EAGLSharegroup *) getGPUImageSharegroup;
+(void) refreshUser;

@end
