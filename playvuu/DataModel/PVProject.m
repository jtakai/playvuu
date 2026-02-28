//
//  PVProject.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/29/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVProject.h"
#import "PVUser.h"

@implementation PVProject

@dynamic slideTexture, thumbVideo, fullVideo, activity, keywords, title, layerData;
@dynamic authorName, authorId, localVideoURL;

+(void) load{
    [PVProject registerSubclass];
    [super load];
}

+(NSString *)parseClassName{
    return @"PVProject";
}

-(void)setSlideShow:(UIImage *)slideShow{
    NSData *imageData = UIImagePNGRepresentation(slideShow);
    NSString *filename = [NSString stringWithFormat:@"%@_slide", [self objectId]];
    self.slideTexture = [PFFile fileWithName:filename data:imageData];    
}

+(PVProject *)newProjectWithTitle:(NSString *)title{
    PVProject *newProject = [PVProject new];
    newProject.title = title;
    newProject.authorName = [PVUser currentUser].userData.displayName;
    newProject.authorId = [[PVUser currentUser] objectId];
    
    return newProject;
}

@end
